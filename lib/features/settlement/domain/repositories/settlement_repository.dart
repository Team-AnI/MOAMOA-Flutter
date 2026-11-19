import '../entities/regular_due_update.dart';
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
  Future<List<RegularDue>> listRegularDues(int meetingId);
  Future<int> createRegularDue(int meetingId, RegularDueInput input);
  Future<bool?> updateRegularDue(
    int meetingId,
    int regularDuesId,
    RegularDueUpdate changes,
  );
  Future<void> deleteRegularDue(int meetingId, int regularDuesId);
}
