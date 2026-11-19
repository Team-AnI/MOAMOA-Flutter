import '../../../../core/usecases/usecase.dart';
import '../entities/payment_action.dart';
import '../repositories/settlement_repository.dart';

final class SubmitPaymentParams extends Params {
  const SubmitPaymentParams({
    required this.meetingId,
    required this.settlementId,
  });
  final int meetingId, settlementId;
  @override
  List<Object?> get props => [meetingId, settlementId];
}

abstract class SubmitPayment
    extends Usecase<PaymentAction, SubmitPaymentParams> {}

final class SubmitPaymentImpl implements SubmitPayment {
  const SubmitPaymentImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<PaymentAction> call(SubmitPaymentParams params) async {
    return _settlementRepository.submitPayment(
      params.meetingId,
      params.settlementId,
    );
  }
}
