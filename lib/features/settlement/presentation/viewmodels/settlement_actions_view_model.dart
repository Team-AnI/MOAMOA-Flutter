import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../domain/entities/payment_action.dart';
import '../../domain/usecases/create_settlement.dart';
import '../../domain/usecases/submit_payment.dart';
import '../../domain/usecases/approve_payment.dart';
import '../../domain/usecases/reject_payment.dart';
import '../providers/settlement_providers.dart';
import 'settlement_action_state.dart';

/// 같은 모임의 중복 제출을 막고, 화면이 닫혀도 서버 작업 완료 후 공유 조회를 갱신합니다.
class SettlementActionsViewModel extends Notifier<SettlementActionState> {
  SettlementActionsViewModel({required this.meetingId});
  final int meetingId;
  @override
  SettlementActionState build() => const SettlementActionState();

  Future<int?> create(CreateSettlementParams params) =>
      _run(() => ref.read(createSettlementProvider)(params));
  Future<PaymentAction?> submit(int settlementId) => _run(
    () => ref.read(submitPaymentProvider)(
      SubmitPaymentParams(meetingId: meetingId, settlementId: settlementId),
    ),
    settlementId: settlementId,
  );
  Future<PaymentAction?> approve(int settlementId, int paymentId) => _run(
    () => ref.read(approvePaymentProvider)(
      ApprovePaymentParams(
        meetingId: meetingId,
        settlementId: settlementId,
        paymentId: paymentId,
      ),
    ),
    settlementId: settlementId,
  );
  Future<PaymentAction?> reject(
    int settlementId,
    int paymentId, {
    String? reason,
  }) => _run(
    () => ref.read(rejectPaymentProvider)(
      RejectPaymentParams(
        meetingId: meetingId,
        settlementId: settlementId,
        paymentId: paymentId,
        reason: reason,
      ),
    ),
    settlementId: settlementId,
  );

  void _refresh(int? settlementId) {
    ref.invalidate(settlementListProvider(meetingId));
    if (settlementId != null) {
      ref.invalidate(
        settlementDetailProvider(
          SettlementDetailRequest(
            meetingId: meetingId,
            settlementId: settlementId,
          ),
        ),
      );
    }
  }

  Future<T?> _run<T>(Future<T> Function() action, {int? settlementId}) async {
    if (state.isSubmitting) return null;
    // 요청 동안만 수명을 유지합니다. 이전 화면으로 돌아가도 성공 결과를 목록에 반영합니다.
    final link = ref.keepAlive();
    state = const SettlementActionState(isSubmitting: true);
    try {
      final result = await action();
      if (ref.mounted) _refresh(settlementId);
      return result;
    } on ApiException catch (error) {
      if (ref.mounted &&
          {
            ApiErrorCode.conflict,
            ApiErrorCode.unprocessableEntity,
            ApiErrorCode.forbidden,
          }.contains(error.code)) {
        _refresh(settlementId);
        if (error.code == ApiErrorCode.forbidden) {
          ref.invalidate(groupMyRoleProvider(meetingId));
        }
      }
      rethrow;
    } finally {
      if (ref.mounted) state = const SettlementActionState();
      link.close();
    }
  }
}
