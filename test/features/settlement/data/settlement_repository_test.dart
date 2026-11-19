import 'package:moamoa/features/settlement/domain/entities/regular_due_update.dart';

import 'dart:convert';

import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/errors/api_error_code.dart';

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final dio = Dio()..httpClientAdapter = adapter;
  return (
    SettlementRepositoryImpl(
      settlementRemoteDataSource: SettlementRemoteDataSourceImpl(
        dio: dio,
        baseUrl: 'https://example.test',
      ),
    ),
    adapter,
  );
}

void main() {
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
      adapter.request?.path,
      'https://example.test/v1/meetings/7/settlements',
    );
    final body = adapter.request!.data as Map<String, Object?>;
    expect(body['memberIds'], [3, 5, 7]);
    expect(body['dueAt'], '2026-10-20T14:59:00.000Z');
  });

  test('정산 목록의 본인 납부 상태를 유지한다', () async {
    final (repository, _) = _repository(
      '''{"success":true,"data":{"settlements":[{
      "settlementId":40,"title":"모임 회비","totalAmount":45000,"memberCount":3,
      "dueAt":"2026-10-20T23:59:00+09:00","createdAt":"2026-10-14T10:00:00+09:00",
      "status":"IN_PROGRESS","myAmount":15000,"myPaymentStatus":"PENDING"
    }]}}''',
    );
    final items = await repository.list(7);
    expect(items.single.myPaymentStatus, PaymentStatus.pending);
    expect(items.single.myAmount, 15000);
  });

  test('납부 반려 사유를 보내고 미납 상태를 반환한다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"paymentId":81,"status":"UNPAID","rejectionReason":"입금 미확인"}}',
    );
    final result = await repository.rejectPayment(7, 40, 81, reason: '입금 미확인');
    expect(result.status, PaymentStatus.unpaid);
    expect(
      adapter.request?.path,
      'https://example.test/v1/meetings/7/settlements/40/payments/81/rejection',
    );
    expect(adapter.request!.data, {'reason': '입금 미확인'});
  });

  test('정기 회비 목록을 주기와 활성 상태까지 읽는다', () async {
    final (repository, adapter) = _repository(
      '''{"success":true,"data":{"regularDues":[{
      "regularDuesId":7,"title":"월 회비","amount":10000,"cycleType":"MONTHLY",
      "cycleDay":"LAST","sendTime":"09:00","dueDays":7,
      "bankName":"국민은행","accountNumber":"1234","accountHolder":"김모아",
      "isActive":true,"postNotice":false
    }]}}''',
    );
    final items = await repository.listRegularDues(7);
    expect(items.single.cycle, DuesCycle.monthly);
    expect(items.single.cycleDay, 'LAST');
    expect(items.single.isActive, true);
    expect(
      adapter.request?.path,
      'https://example.test/v1/meetings/7/regular-dues',
    );
  });

  test('정기 회비 생성은 1인당 금액과 반복 주기를 보낸다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"regularDuesId":7}}',
    );
    final id = await repository.createRegularDue(
      7,
      const RegularDueInput(
        title: '월 회비',
        amount: 10000,
        cycle: DuesCycle.monthly,
        cycleDay: 'LAST',
        sendTime: '09:00',
        dueDays: 7,
        bankName: '국민은행',
        accountNumber: '1234',
        accountHolder: '김모아',
        postNotice: false,
      ),
    );
    expect(id, 7);
    expect(adapter.request?.method, 'POST');
    final body = adapter.request!.data as Map<String, Object?>;
    expect(body['amount'], 10000);
    expect(body['cycleType'], 'MONTHLY');
    expect(body['cycleDay'], 'LAST');
  });

  test('정기 회비 수정은 기본적으로 이번 회차 적용을 요청하지 않는다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"currentSettlementApplied":null}}',
    );
    final applied = await repository.updateRegularDue(
      7,
      9,
      const RegularDueUpdate(title: '수정한 월 회비'),
    );
    expect(applied, isNull);
    expect(adapter.request?.method, 'PATCH');
    expect(
      (adapter.request!.data as Map<String, Object?>).containsKey(
        'applyToCurrentSettlement',
      ),
      false,
    );
    expect(adapter.request!.data, {'title': '수정한 월 회비'});
  });

  test('정기 회비 활성 상태만 바꿀 때 기존 금액·계좌를 다시 보내지 않는다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"currentSettlementApplied":null}}',
    );
    await repository.updateRegularDue(
      7,
      9,
      const RegularDueUpdate(isActive: false),
    );
    expect(adapter.request?.data, {'isActive': false});
  });

  test('정산 수정은 변경한 항목만 보내 납부 기록이 있는 금액을 건드리지 않는다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"settlementId":40}}',
    );
    await repository.updateSettlement(
      7,
      40,
      const SettlementEditInput(title: '수정된 정산', unlinkSchedule: true),
    );
    expect(adapter.request?.method, 'PATCH');
    expect(
      adapter.request?.path,
      'https://example.test/v1/meetings/7/settlements/40',
    );
    expect(adapter.request?.data, {'title': '수정된 정산', 'scheduleId': null});
  });

  test('정산 취소는 사유를 보내고 기존 내역은 삭제하지 않는다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"settlementId":40,"status":"CANCELED"}}',
    );
    await repository.cancelSettlement(7, 40, reason: '금액 오류');
    expect(adapter.request?.method, 'POST');
    expect(
      adapter.request?.path,
      'https://example.test/v1/meetings/7/settlements/40/cancellation',
    );
    expect(adapter.request?.data, {'reason': '금액 오류'});
  });

  test('환불 완료 기록은 송금 정보 없이 대상 납부 ID만 보낸다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"paymentId":81,"status":"REFUNDED"}}',
    );
    await repository.refundPayment(7, 40, 81);
    expect(
      adapter.request?.path,
      'https://example.test/v1/meetings/7/settlements/40/payments/81/refund',
    );
    expect(adapter.request?.data, isNull);
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
  test('대체 정산 생성은 원 정산 ID를 전달하고 부분 수정은 일정 연결을 임의로 해제하지 않는다', () async {
    final (repo, adapter) = _repository(
      '{"success":true,"data":{"settlementId":99}}',
    );
    await repo.create(
      CreateSettlementInput(
        meetingId: 7,
        replacesSettlementId: 40,
        title: '다시 정산',
        totalAmount: 1000,
        memberIds: [3],
        bankName: '국민',
        accountNumber: '1234',
        accountHolder: '김모아',
        dueAt: DateTime(2026, 12, 1),
      ),
    );
    expect((adapter.request!.data as Map)['replacesSettlementId'], 40);
    await repo.updateSettlement(
      7,
      40,
      const SettlementEditInput(title: '이름만 수정'),
    );
    expect((adapter.request!.data as Map).containsKey('scheduleId'), isFalse);
  });

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
  test('납부 제출·승인 요청은 경로 ID를 본문에 섞지 않는다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"paymentId":81,"status":"PENDING"}}',
    );
    await repository.submitPayment(7, 40);
    expect(
      adapter.request!.path,
      'https://example.test/v1/meetings/7/settlements/40/payments/me/submissions',
    );
    expect(adapter.request!.data, isNull);
    await repository.approvePayment(7, 40, 81);
    expect(
      adapter.request!.path,
      'https://example.test/v1/meetings/7/settlements/40/payments/81/approval',
    );
    expect(adapter.request!.data, isNull);
  });
  test('선택 사유가 없는 반려 DTO는 경로 변수를 JSON에서 제외한다', () async {
    final (repository, adapter) = _repository(
      '{"success":true,"data":{"paymentId":81,"status":"UNPAID"}}',
    );
    await repository.rejectPayment(7, 40, 81);
    expect(adapter.request!.data, isEmpty);
  });
}
