import '../../../../core/usecases/usecase.dart';

import '../repositories/settlement_repository.dart';

final class RefundPaymentParams extends Params {
  const RefundPaymentParams({
    required this.meetingId,
    required this.settlementId,
    required this.paymentId,
  });
  final int meetingId, settlementId, paymentId;
  @override
  List<Object?> get props => [meetingId, settlementId, paymentId];
}

abstract class RefundPayment extends Usecase<void, RefundPaymentParams> {}

final class RefundPaymentImpl implements RefundPayment {
  const RefundPaymentImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<void> call(RefundPaymentParams params) async {
    return _settlementRepository.refundPayment(
      params.meetingId,
      params.settlementId,
      params.paymentId,
    );
  }
}
