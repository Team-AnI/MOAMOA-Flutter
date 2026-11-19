import '../domain/entities/settlement.dart';

extension SettlementListDisplay on List<Settlement> {
  Iterable<Settlement> get active =>
      where((s) => s.status == SettlementStatus.inProgress);
  Iterable<Settlement> get history =>
      where((s) => s.status != SettlementStatus.inProgress);
  Iterable<Settlement> get myUnpaid =>
      active.where((s) => s.myPaymentStatus == PaymentStatus.unpaid);
  List<Settlement> get recent =>
      [...this]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
