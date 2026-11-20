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

extension DuesCycleDisplayX on DuesCycle {
  String get label => switch (this) {
    DuesCycle.monthly => '매월',
    DuesCycle.weekly => '매주',
    DuesCycle.unknown => '주기 확인 필요',
  };
  String dayLabel(String day) {
    const weekdays = {
      'MON': '월요일',
      'TUE': '화요일',
      'WED': '수요일',
      'THU': '목요일',
      'FRI': '금요일',
      'SAT': '토요일',
      'SUN': '일요일',
    };
    return switch (this) {
      DuesCycle.monthly => day == 'LAST' ? '말일' : '$day일',
      DuesCycle.weekly => weekdays[day] ?? day,
      DuesCycle.unknown => '주기 확인 필요',
    };
  }

  String labelForDay(String day) =>
      this == DuesCycle.unknown ? label : '$label ${dayLabel(day)}';
}

extension RegularDueDisplayX on RegularDue {
  String get rowSubtitle =>
      '${won(amount)} · ${cycle.labelForDay(cycleDay)} · $sendTime';
  String get activeLabel => isActive ? '진행 중' : '일시 중지';
  String get dueDaysLabel => '납부 기한: 요청일로부터 $dueDays일';
}
