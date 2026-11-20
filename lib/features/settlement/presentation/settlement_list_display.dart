import '../domain/entities/settlement.dart';
import 'settlement_format.dart';

extension SettlementListDisplay on List<Settlement> {
  Iterable<Settlement> get active =>
      where((s) => s.status == SettlementStatus.inProgress);
  Iterable<Settlement> get history =>
      where((s) => s.status != SettlementStatus.inProgress);
  Iterable<Settlement> get myUnpaid =>
      active.where((s) => s.myPaymentStatus == PaymentStatus.unpaid);
  Settlement? get featuredAdmin => active.firstOrNull;
  Settlement? get featuredMember => myUnpaid.firstOrNull;
  Iterable<Settlement> get activePreview => active.take(3);
  Iterable<Settlement> get historyPreview => history.take(3);
  Iterable<Settlement> get recentPreview => recent.take(3);
  List<Settlement> get recent =>
      [...this]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}

extension SettlementRowDisplayX on Settlement {
  String get amountLabel => won(myAmount ?? totalAmount);
  String get rowSubtitle => '$amountLabel · ${shortDate(dueAt)}까지';
  String get dueSubtitle => '$title · ${shortDate(dueAt)}까지';
  String get statusLabel => myPaymentStatus?.label ?? status.label;
  String get memberAmountLabel =>
      myAmount == null ? '청구 금액 확인 필요' : won(myAmount!);
}
