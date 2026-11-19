import '../../../../core/usecases/usecase.dart';
import '../entities/payment_action.dart';
import '../repositories/settlement_repository.dart';

final class ApprovePaymentParams extends Params {
  const ApprovePaymentParams({
    required this.meetingId,
    required this.settlementId,
    required this.paymentId,
  });
  final int meetingId, settlementId, paymentId;
  @override
  List<Object?> get props => [meetingId, settlementId, paymentId];
}

abstract class ApprovePayment
    extends Usecase<PaymentAction, ApprovePaymentParams> {}

final class ApprovePaymentImpl implements ApprovePayment {
  const ApprovePaymentImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<PaymentAction> call(ApprovePaymentParams params) async {
    return _settlementRepository.approvePayment(
      params.meetingId,
      params.settlementId,
      params.paymentId,
    );
  }
}
