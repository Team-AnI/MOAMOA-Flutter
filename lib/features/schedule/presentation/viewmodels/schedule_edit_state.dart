import 'package:freezed_annotation/freezed_annotation.dart';

import 'schedule_edit_status.dart';

part 'schedule_edit_state.freezed.dart';

/// 일정 수정 화면의 상태입니다. 현재 단계와 바뀐 값을 담습니다.
///
/// 바뀐 값은 화면이 원래 값과 비교해서 알려줍니다. 원래 값과 같으면 null 이고, null 인 값은 저장하지 않습니다.
@freezed
abstract class ScheduleEditState with _$ScheduleEditState {
  const factory ScheduleEditState({
    @Default(ScheduleEditStatus.initial) ScheduleEditStatus status,
    String? title,
    String? description,
    DateTime? startAt,
    DateTime? endAt,
    String? location,
  }) = _ScheduleEditState;
}
