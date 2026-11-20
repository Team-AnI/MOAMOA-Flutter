import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../domain/usecases/approve_payment.dart';
import '../../domain/usecases/create_settlement.dart';
import '../../domain/usecases/reject_payment.dart';
import '../../domain/usecases/submit_payment.dart';
import '../providers/settlement_providers.dart';
import 'settlement_action.dart';
import 'settlement_action_state.dart';

/// 같은 모임의 중복 제출을 막고, 화면이 닫혀도 서버 작업 완료 후 공유 조회를 갱신합니다.
class SettlementActionsViewModel extends Notifier<SettlementActionState> {
  SettlementActionsViewModel({required this.meetingId});
  final int meetingId;
  @override
  SettlementActionState build() => const SettlementActionState();

  Future<void> create(CreateSettlementParams params) => _run(
    SettlementAction.create,
    () => ref.read(createSettlementProvider)(params),
    createdId: (id) => id,
  );
  Future<void> submit(int settlementId) => _run(
    SettlementAction.submit,
    () => ref.read(submitPaymentProvider)(
      SubmitPaymentParams(meetingId: meetingId, settlementId: settlementId),
    ),
    settlementId: settlementId,
  );
  Future<void> approve(int settlementId, int paymentId) => _run(
    SettlementAction.approve,
    () => ref.read(approvePaymentProvider)(
      ApprovePaymentParams(
        meetingId: meetingId,
        settlementId: settlementId,
        paymentId: paymentId,
      ),
    ),
    settlementId: settlementId,
  );
  Future<void> reject(int settlementId, int paymentId, {String? reason}) =>
      _run(
        SettlementAction.reject,
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

  Future<void> _run<T>(
    SettlementAction action,
    Future<T> Function() request, {
    int? settlementId,
    int? Function(T)? createdId,
  }) async {
    if (state.isSubmitting) return;
    final link = ref.keepAlive();
    state = SettlementActionState(
      isSubmitting: true,
      action: action,
      settlementId: settlementId,
    );
    try {
      final result = await request();
      if (!ref.mounted) return;
      _refresh(settlementId);
      state = SettlementActionState(
        action: action,
        settlementId: settlementId,
        createdSettlementId: createdId?.call(result),
      );
    } on ApiException catch (error) {
      if (!ref.mounted) return;
      if ({
        ApiErrorCode.conflict,
        ApiErrorCode.unprocessableEntity,
        ApiErrorCode.forbidden,
      }.contains(error.code)) {
        _refresh(settlementId);
        if (error.code == ApiErrorCode.forbidden) {
          ref.invalidate(groupMyRoleProvider(meetingId));
        }
      }
      state = SettlementActionState(
        action: action,
        settlementId: settlementId,
        failure: error,
      );
    } catch (_) {
      if (ref.mounted) {
        state = SettlementActionState(
          action: action,
          settlementId: settlementId,
          failure: const ApiException(code: ApiErrorCode.unknown),
        );
      }
    } finally {
      link.close();
    }
  }
}
