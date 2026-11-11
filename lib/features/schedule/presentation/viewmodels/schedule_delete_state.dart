import 'package:freezed_annotation/freezed_annotation.dart';

import 'schedule_delete_status.dart';

part 'schedule_delete_state.freezed.dart';

/// 일정 취소 상태입니다. 현재 단계를 담습니다.
@freezed
abstract class ScheduleDeleteState with _$ScheduleDeleteState {
  const factory ScheduleDeleteState({
    @Default(ScheduleDeleteStatus.initial) ScheduleDeleteStatus status,
  }) = _ScheduleDeleteState;
}
