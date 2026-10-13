import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'schedule_calendar_state.dart';

part 'schedule_calendar_view_model.g.dart';

/// 캘린더 탭의 월 이동과 날짜 선택을 관리합니다.
/// 목록 탭을 다녀와도 보던 달과 날짜가 유지되도록 ViewModel 에서 상태를 들고 있습니다.
@riverpod
class ScheduleCalendarViewModel extends _$ScheduleCalendarViewModel {
  @override
  ScheduleCalendarState build() {
    final today = _today();
    return ScheduleCalendarState(
      month: DateTime(today.year, today.month),
      selected: today,
    );
  }

  /// 월을 바꾸고 선택 날짜도 그 달로 옮깁니다. (이번 달이면 오늘, 아니면 1일)
  void changeMonth(DateTime month) {
    final today = _today();
    final isThisMonth = month.year == today.year && month.month == today.month;
    state = ScheduleCalendarState(
      month: DateTime(month.year, month.month),
      selected: isThisMonth ? today : DateTime(month.year, month.month),
    );
  }

  void select(DateTime date) {
    state = state.copyWith(selected: DateTime(date.year, date.month, date.day));
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
