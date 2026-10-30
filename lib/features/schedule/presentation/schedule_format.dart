const _weekdays = ['월', '화', '수', '목', '금', '토', '일'];

/// 화면 표시용 날짜/시간 문자열. 서버가 UTC 로 줄 수 있어 toLocal() 한 값에 사용합니다.
extension ScheduleDateFormatX on DateTime {
  String get weekdayKo => _weekdays[weekday - 1];

  String get hhmm =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// 예: 9월 20일(일) 23:59
  String get fieldLabel => '$month월 $day일($weekdayKo) $hhmm';

  /// 오전/오후와 12시간제 시각. 예: 오후 7:00, 오전 12:30(자정 30분)
  String get meridiemTime {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final meridiem = hour < 12 ? '오전' : '오후';
    return '$meridiem $hour12:${minute.toString().padLeft(2, '0')}';
  }
}

/// 예: 2시간, 1시간 30분, 45분
String durationLabel(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes % 60;
  return [if (hours > 0) '$hours시간', if (minutes > 0) '$minutes분'].join(' ');
}
