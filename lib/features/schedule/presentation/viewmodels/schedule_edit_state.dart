import 'package:freezed_annotation/freezed_annotation.dart';

import 'schedule_edit_status.dart';

part 'schedule_edit_state.freezed.dart';

/// 일정 수정 화면의 상태입니다. 현재 단계를 담습니다.
@freezed
abstract class ScheduleEditState with _$ScheduleEditState {
  const factory ScheduleEditState({
    @Default(ScheduleEditStatus.initial) ScheduleEditStatus status,
  }) = _ScheduleEditState;
}
