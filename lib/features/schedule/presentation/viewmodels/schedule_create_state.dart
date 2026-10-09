import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/features/schedule/domain/entities/created_schedule.dart';

import 'schedule_create_status.dart';

part 'schedule_create_state.freezed.dart';

/// 일정 만들기 화면의 상태입니다. 현재 단계, 성공 시 생성된 일정, 실패 여부를 담습니다.
@freezed
abstract class ScheduleCreateState with _$ScheduleCreateState {
  const factory ScheduleCreateState({
    @Default(ScheduleCreateStatus.initial) ScheduleCreateStatus status,

    /// [status] 가 success 일 때만 값이 있습니다.
    CreatedSchedule? created,
  }) = _ScheduleCreateState;
}
