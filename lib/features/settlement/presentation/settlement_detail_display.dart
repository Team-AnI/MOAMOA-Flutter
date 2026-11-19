import '../domain/entities/settlement.dart';
import 'settlement_format.dart';

extension SettlementDetailDisplay on SettlementDetail {
  bool get canSubmit =>
      status == SettlementStatus.inProgress &&
      myPayment?.status == PaymentStatus.unpaid;
  String get heading => scheduleTitle ?? title;
  String get dueLabel => '${shortDate(dueAt)}까지';
  String get accountLabel => '$bankName $accountNumber';
  String get totalLabel => '${won(totalAmount)} · $dueLabel';
  String get splitLabel => '${won(totalAmount)}을 ${summary.totalCount}명이 나눠요';
  String get paidLabel =>
      '${summary.paidCount}/${summary.totalCount}명 · ${won(summary.paidAmount)}';
  String get myAmountLabel =>
      myPayment == null ? '정산 대상이 아니에요' : won(myPayment!.amount);
  String get myStatusLabel => paymentStatusLabel(myPayment?.status);
  String get pendingHeading => '확인 대기 ${summary.pendingCount}명';
  String get unpaidHeading => '미납 ${summary.unpaidCount}명';
  String get paidHeading => '완납 ${summary.paidCount}명';
  List<SettlementPayment> get pendingPayments => payments
      .where((p) => p.status == PaymentStatus.pending)
      .toList(growable: false);
  List<SettlementPayment> get unpaidPayments => payments
      .where((p) => p.status == PaymentStatus.unpaid)
      .toList(growable: false);
  List<SettlementPayment> get paidPayments => payments
      .where((p) => p.status == PaymentStatus.paid)
      .toList(growable: false);
}

extension SettlementSummaryDisplay on SettlementSummary {
  double get paidProgress =>
      totalCount <= 0 ? 0 : (paidCount / totalCount).clamp(0, 1);
  String get paidPercentage => '${(paidProgress * 100).round()}%';
}

extension SettlementPaymentDisplay on SettlementPayment {
  String get displayName =>
      userName?.trim().isNotEmpty == true ? userName! : '구성원';
  String get displayStatus => paymentStatusLabel(status);
  String get submittedLabel =>
      submittedAt == null ? displayStatus : '${shortDate(submittedAt!)} 제출';
}
