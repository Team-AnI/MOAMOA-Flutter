import 'package:moamoa/features/schedule/presentation/schedule_format.dart';

/// 투표 화면 표시용 날짜 문자열입니다.
extension VoteDateFormatX on DateTime {
  String get shortDateLabel => '$month/$day $weekdayKo';

  String get monthLabel => '$year년 $month월';
}

/// 하루 중 시각(0:00 부터 지난 시간)을 표시하는 문자열입니다.
extension VoteTimeOfDayFormatX on Duration {
  String get hhmm =>
      '${inHours.toString().padLeft(2, '0')}:${(inMinutes % 60).toString().padLeft(2, '0')}';
}
