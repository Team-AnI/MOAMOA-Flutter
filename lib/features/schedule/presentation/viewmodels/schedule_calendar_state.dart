import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_calendar_state.freezed.dart';

/// 캘린더 탭의 상태입니다. 보고 있는 달과 선택한 날짜를 담습니다.
@freezed
abstract class ScheduleCalendarState with _$ScheduleCalendarState {
  const factory ScheduleCalendarState({
    /// 보고 있는 달의 1일입니다.
    required DateTime month,

    /// 선택한 날짜(시각 제외)입니다.
    required DateTime selected,
  }) = _ScheduleCalendarState;
}
