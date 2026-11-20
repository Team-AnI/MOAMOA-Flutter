import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/payment_action.dart';
import '../repositories/settlement_repository.dart';

final class RejectPaymentParams extends Params {
  const RejectPaymentParams({
    required this.meetingId,
    required this.settlementId,
    required this.paymentId,
    this.reason,
  });
  final int meetingId, settlementId, paymentId;
  final String? reason;
  @override
  List<Object?> get props => [meetingId, settlementId, paymentId, reason];
}

abstract class RejectPayment
    extends Usecase<PaymentAction, RejectPaymentParams> {}

final class RejectPaymentImpl implements RejectPayment {
  const RejectPaymentImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<PaymentAction> call(RejectPaymentParams params) async {
    if ((params.reason?.length ?? 0) > 255) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '반려 사유는 255자 이하여야 해요.',
      );
    }
    return _settlementRepository.rejectPayment(
      params.meetingId,
      params.settlementId,
      params.paymentId,
      reason: params.reason?.trim().isEmpty == true
          ? null
          : params.reason?.trim(),
    );
  }
}
