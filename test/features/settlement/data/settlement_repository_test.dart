import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/settlement/data/datasources/settlement_remote_data_source_impl.dart';
import 'package:moamoa/features/settlement/data/repositories/settlement_repository_impl.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';

class _Adapter implements HttpClientAdapter {
  _Adapter(this.response);
  final String response;
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromString(
      response,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

(SettlementRepositoryImpl, _Adapter) _repository(String response) {
  final adapter = _Adapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
    ..httpClientAdapter = adapter;
  return (
    SettlementRepositoryImpl(
      settlementRemoteDataSource: SettlementRemoteDataSourceImpl(dio: dio),
    ),
    adapter,
  );
}

void main() {
  group(SettlementRepositoryImpl, () {
    contractTests();
    test('정산 생성은 구성원 ID와 UTC 기한을 API에 보내고 생성 ID를 읽는다', () async {
      final (repository, adapter) = _repository(
        '{"success":true,"data":{"settlementId":40}}',
      );
      final id = await repository.create(
        CreateSettlementInput(
          meetingId: 7,
          title: '모임 회비',
          totalAmount: 45000,
          memberIds: [3, 5, 7],
          bankName: '국민은행',
          accountNumber: '1234',
          accountHolder: '김모아',
          dueAt: DateTime.parse('2026-10-20T23:59:00+09:00'),
        ),
      );
      expect(id, 40);
      expect(adapter.request?.method, 'POST');
      expect(
        adapter.request?.uri.toString(),
        'https://example.test/v1/meetings/7/settlements',
      );
      final body = adapter.request!.data as Map<String, Object?>;
      expect(body['memberIds'], [3, 5, 7]);
      expect(body['dueAt'], '2026-10-20T14:59:00.000Z');
    });

    test('정산 목록의 본인 납부 상태를 유지한다', () async {
      final (repository, adapter) = _repository(
        '''{"success":true,"data":{"settlements":[{
      "settlementId":40,"title":"모임 회비","totalAmount":45000,"memberCount":3,
      "dueAt":"2026-10-20T23:59:00+09:00","createdAt":"2026-10-14T10:00:00+09:00",
      "status":"IN_PROGRESS","myAmount":15000,"myPaymentStatus":"PENDING"
    }]}}''',
      );
      final items = await repository.list(7);
      expect(items.single.myPaymentStatus, PaymentStatus.pending);
      expect(items.single.myAmount, 15000);
      expect(
        adapter.request!.uri.toString(),
        'https://example.test/v1/meetings/7/settlements',
      );
      expect(adapter.request!.data, isNull);
    });

    test('납부 반려 사유를 보내고 미납 상태를 반환한다', () async {
      final (repository, adapter) = _repository(
        '{"success":true,"data":{"paymentId":81,"status":"UNPAID","rejectionReason":"입금 미확인"}}',
      );
      final result = await repository.rejectPayment(
        7,
        40,
        81,
        reason: '입금 미확인',
      );
      expect(result.status, PaymentStatus.unpaid);
      expect(
        adapter.request?.uri.toString(),
        'https://example.test/v1/meetings/7/settlements/40/payments/81/rejection',
      );
      expect(adapter.request!.data, {'reason': '입금 미확인'});
    });
  });
}

Map<String, Object?> detailJson({bool refundField = false}) => {
  'settlementId': 40,
  'title': '모임 회비',
  'scheduleId': null,
  'totalAmount': 15000,
  'bankName': '국민은행',
  'accountNumber': '1234',
  'accountHolder': '김모아',
  'dueAt': '2026-12-01T23:59:00+09:00',
  'status': 'IN_PROGRESS',
  'noticeId': null,
  'myPayment': {'paymentId': 81, 'amount': 15000, 'status': 'UNPAID'},
  'summary': {
    'totalCount': 1,
    'unpaidCount': 1,
    'pendingCount': 0,
    'paidCount': 0,
    'paidAmount': 0,
    if (refundField) 'refundedCount': 0,
  },
  'payments': null,
};
void contractTests() {
  for (final refundField in [false, true]) {
    test(
      '상세 DTO: ${refundField ? "후속 환불 필드가 있어도" : "현재 서버의 환불 필드가 없어도"} 기본 납부 정보를 읽는다',
      () async {
        final (repository, _) = _repository(
          jsonEncode({
            'success': true,
            'data': detailJson(refundField: refundField),
          }),
        );
        final result = await repository.detail(7, 40);
        expect(result.myPayment!.status, PaymentStatus.unpaid);
        expect(result.payments, isEmpty);
        expect(result.summary.refundedCount, refundField ? 0 : null);
      },
    );
  }
  for (final field in ['settlementId', 'summary', 'dueAt', 'payments']) {
    test('상세 DTO의 잘못된 $field 구조는 공통 오류로 전달한다', () async {
      final data = detailJson();
      data[field] = switch (field) {
        'settlementId' => '40',
        'summary' => [],
        'dueAt' => 'not-a-date',
        _ => {},
      };
      final (repository, _) = _repository(
        jsonEncode({'success': true, 'data': data}),
      );
      await expectLater(
        repository.detail(7, 40),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.unknown,
          ),
        ),
      );
    });
  }
  test('알 수 없는 납부·정산 상태는 unknown으로 보존한다', () async {
    final data = detailJson();
    data['status'] = 'FUTURE';
    data['myPayment'] = {'paymentId': 81, 'amount': 15000, 'status': 'FUTURE'};
    final (repository, _) = _repository(
      jsonEncode({'success': true, 'data': data}),
    );
    final result = await repository.detail(7, 40);
    expect(result.status, SettlementStatus.unknown);
    expect(result.myPayment!.status, PaymentStatus.unknown);
  });
  for (final approval in [false, true]) {
    test('${approval ? "승인" : "제출"} 요청은 경로 ID를 본문에 섞지 않는다', () async {
      final (repository, adapter) = _repository(
        '{"success":true,"data":{"paymentId":81,"status":"PENDING"}}',
      );
      if (approval) {
        await repository.approvePayment(7, 40, 81);
      } else {
        await repository.submitPayment(7, 40);
      }
      expect(
        adapter.request!.uri.toString(),
        'https://example.test/v1/meetings/7/settlements/40/payments/${approval ? "81/approval" : "me/submissions"}',
      );
      expect(adapter.request!.data, isNull);
    });
  }
  test('선택 사유가 없는 반려 DTO는 경로 변수를 JSON에서 제외한다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"paymentId":81,"status":"UNPAID"}}',
    );
    await repository.rejectPayment(7, 40, 81);
    expect(adapter.request!.data, isEmpty);
  });
  for (final envelope in <String, Object?>{
    '최상위 배열': [],
    '성공 값 누락': {
      'data': {'settlements': []},
    },
    '실패 envelope': {
      'success': false,
      'data': {'settlements': []},
    },
    'data 누락': {'success': true},
    'data 타입 오류': {'success': true, 'data': []},
  }.entries) {
    test('${envelope.key} 응답은 빈 목록 대신 공통 오류로 전달한다', () async {
      final (repository, _) = _repository(jsonEncode(envelope.value));
      await expectLater(repository.list(7), throwsA(isA<ApiException>()));
    });
  }
}
