import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 캘린더 탭의 상태입니다. [month] 는 보고 있는 달의 1일, [selected] 는 선택한 날짜입니다.
typedef ScheduleCalendarState = ({DateTime month, DateTime selected});

/// 캘린더 탭의 월 이동과 날짜 선택을 관리합니다.
/// 목록 탭을 다녀와도 보던 달과 날짜가 유지되도록 ViewModel 에서 상태를 들고 있습니다.
class ScheduleCalendarViewModel extends Notifier<ScheduleCalendarState> {
  @override
  ScheduleCalendarState build() {
    final today = _today();
    return (month: DateTime(today.year, today.month), selected: today);
  }

  /// 월을 바꾸고 선택 날짜도 그 달로 옮깁니다. (이번 달이면 오늘, 아니면 1일)
  void changeMonth(DateTime month) {
    final today = _today();
    final isThisMonth = month.year == today.year && month.month == today.month;
    state = (
      month: DateTime(month.year, month.month),
      selected: isThisMonth ? today : DateTime(month.year, month.month),
    );
  }

  void select(DateTime date) {
    state = (
      month: state.month,
      selected: DateTime(date.year, date.month, date.day),
    );
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
