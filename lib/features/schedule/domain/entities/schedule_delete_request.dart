import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_delete_request.freezed.dart';

/// 일정 취소(삭제) 요청입니다.
@freezed
abstract class ScheduleDeleteRequest with _$ScheduleDeleteRequest {
  const factory ScheduleDeleteRequest({
    required int meetingId,
    required int scheduleId,
  }) = _ScheduleDeleteRequest;
}
