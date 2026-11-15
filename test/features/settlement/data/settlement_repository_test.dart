import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/settlement/data/datasources/settlement_remote_data_source.dart';
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
      remote: SettlementRemoteDataSource(
        dio: dio,
        baseUrl: 'https://example.test',
      ),
    ),
    adapter,
  );
}

void main() {
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
      const RegularDueInput(
        title: '수정한 월 회비',
        amount: 10000,
        cycle: DuesCycle.monthly,
        cycleDay: '10',
        sendTime: '09:00',
        dueDays: 7,
        bankName: '국민은행',
        accountNumber: '1234',
        accountHolder: '김모아',
        postNotice: false,
      ),
      previous: const RegularDue(
        id: 9,
        title: '월 회비',
        amount: 10000,
        cycle: DuesCycle.monthly,
        cycleDay: '10',
        sendTime: '09:00',
        dueDays: 7,
        bankName: '국민은행',
        accountNumber: '1234',
        accountHolder: '김모아',
        postNotice: false,
        isActive: true,
      ),
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
      const RegularDueInput(
        title: '월 회비',
        amount: 10000,
        cycle: DuesCycle.monthly,
        cycleDay: '10',
        sendTime: '09:00',
        dueDays: 7,
        bankName: '국민은행',
        accountNumber: '1234',
        accountHolder: '김모아',
        postNotice: false,
        isActive: false,
      ),
      previous: const RegularDue(
        id: 9,
        title: '월 회비',
        amount: 10000,
        cycle: DuesCycle.monthly,
        cycleDay: '10',
        sendTime: '09:00',
        dueDays: 7,
        bankName: '국민은행',
        accountNumber: '1234',
        accountHolder: '김모아',
        postNotice: false,
        isActive: true,
      ),
    );
    expect(adapter.request?.data, {'isActive': false});
  });
}
