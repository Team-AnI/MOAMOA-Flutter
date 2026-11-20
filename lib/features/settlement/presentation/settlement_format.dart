import '../domain/entities/settlement.dart';

String won(int amount) =>
    '${amount.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',')}원';

String shortDate(DateTime date) {
  final local = date.toLocal();
  return '${local.month}월 ${local.day}일';
}

extension PaymentStatusDisplayX on PaymentStatus {
  String get label => switch (this) {
    PaymentStatus.unpaid => '미납',
    PaymentStatus.pending => '확인 대기',
    PaymentStatus.paid => '완납',
    PaymentStatus.refunded => '환불됨',
    PaymentStatus.unknown => '상태 확인 필요',
  };
}

extension SettlementStatusDisplayX on SettlementStatus {
  String get label => switch (this) {
    SettlementStatus.inProgress => '진행 중',
    SettlementStatus.completed => '완료',
    SettlementStatus.canceled => '취소됨',
    SettlementStatus.unknown => '상태 확인 필요',
  };
}
