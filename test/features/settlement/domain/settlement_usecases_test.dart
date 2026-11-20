import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/domain/usecases/create_settlement.dart';
import 'package:moamoa/features/settlement/domain/usecases/reject_payment.dart';

import '../presentation/settlement_review_test_support.dart';

class _Repository extends TestSettlementRepository {
  CreateSettlementInput? input;
  int rejects = 0;
  @override
  Future<int> create(CreateSettlementInput value) async {
    input = value;
    return 40;
  }

  @override
  Future<PaymentAction> rejectPayment(
    int meetingId,
    int settlementId,
    int paymentId, {
    String? reason,
  }) async {
    rejects++;
    return PaymentAction(
      paymentId: paymentId,
      status: PaymentStatus.unpaid,
      rejectionReason: reason,
    );
  }
}

CreateSettlementParams params({
  String title = ' 회비 ',
  String amount = '1,000',
  List<int> members = const [3],
  DateTime? due,
  bool missingDue = false,
  String bank = ' 국민 ',
  String account = ' 1234 ',
  String holder = ' 김모아 ',
}) => CreateSettlementParams(
  meetingId: 7,
  scheduleId: 12,
  title: title,
  amount: amount,
  memberIds: members,
  bankName: bank,
  accountNumber: account,
  accountHolder: holder,
  dueAt: missingDue ? null : due ?? DateTime(2026, 12, 1),
);
void main() {
  group(CreateSettlement, () {
    test('생성 검증은 값을 정리하고 선택한 일정·정확한 총액을 Repository로 전달한다', () async {
      final repo = _Repository();
      expect(
        await CreateSettlementImpl(settlementRepository: repo)(params()),
        40,
      );
      expect(repo.input!.title, '회비');
      expect(repo.input!.totalAmount, 1000);
      expect(repo.input!.scheduleId, 12);
      expect(repo.input!.bankName, '국민');
    });
    final bad = <String, CreateSettlementParams>{
      '제목 없음': params(title: ' '),
      '제목 51자': params(title: '가' * 51),
      '서버 UTF16 길이 초과': params(title: '😀' * 26),
      '은행 21자': params(bank: '가' * 21),
      '계좌 31자': params(account: '1' * 31),
      '예금주 21자': params(holder: '가' * 21),
      '0원': params(amount: '0'),
      '숫자 아님': params(amount: 'abc'),
      'Int 초과': params(amount: '2147483648'),
      '대상 없음': params(members: []),
      '중복 대상': params(members: [3, 3]),
      '잘못된 대상': params(members: [0]),
      '기한 없음': params(missingDue: true),
      '총액이 인원보다 작음': params(amount: '1', members: [3, 5]),
    };
    for (final entry in bad.entries) {
      test('${entry.key}: 서버 요청 전에 안내하고 요청을 보내지 않는다', () async {
        final repo = _Repository();
        await expectLater(
          CreateSettlementImpl(settlementRepository: repo)(entry.value),
          throwsA(
            isA<ApiException>().having(
              (e) => e.code,
              'code',
              ApiErrorCode.validation,
            ),
          ),
        );
        expect(repo.input, isNull);
      });
    }
    test('입력 길이 경계값과 인원당 최소 1원은 허용한다', () async {
      final repo = _Repository();
      await CreateSettlementImpl(settlementRepository: repo)(
        params(
          title: '가' * 50,
          bank: '가' * 20,
          account: '1' * 30,
          holder: '가' * 20,
          amount: '2',
          members: [3, 5],
        ),
      );
      expect(repo.input!.totalAmount, 2);
    });
  });
  group(RejectPayment, () {
    test('반려 사유 255자는 요청을 보낸다', () async {
      final repo = _Repository();
      await RejectPaymentImpl(settlementRepository: repo)(
        RejectPaymentParams(
          meetingId: 7,
          settlementId: 40,
          paymentId: 81,
          reason: '가' * 255,
        ),
      );
      expect(repo.rejects, 1);
    });
    test('반려 사유 256자는 요청 전에 검증 예외가 발생한다', () async {
      final repo = _Repository();
      await expectLater(
        RejectPaymentImpl(settlementRepository: repo)(
          RejectPaymentParams(
            meetingId: 7,
            settlementId: 40,
            paymentId: 81,
            reason: '가' * 256,
          ),
        ),
        throwsA(isA<ApiException>()),
      );
      expect(repo.rejects, 0);
    });
  });
}
