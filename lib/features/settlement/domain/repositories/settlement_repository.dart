import '../entities/settlement.dart';

abstract interface class SettlementRepository {
  Future<int> create(CreateSettlementInput input);
  Future<List<Settlement>> list(int meetingId);
  Future<SettlementDetail> detail(int meetingId, int settlementId);
  Future<PaymentAction> submitPayment(int meetingId, int settlementId);
  Future<PaymentAction> approvePayment(
    int meetingId,
    int settlementId,
    int paymentId,
  );
  Future<PaymentAction> rejectPayment(
    int meetingId,
    int settlementId,
    int paymentId, {
    String? reason,
  });
}
