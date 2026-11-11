import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_update_request.freezed.dart';

/// 일정 수정 요청. 바뀐 필드만 값이 있고, null 인 필드는 바꾸지 않습니다.
/// 종료 일시를 비우는 수정은 서버 동작이 확인되면 추가합니다.
@freezed
abstract class ScheduleUpdateRequest with _$ScheduleUpdateRequest {
  const factory ScheduleUpdateRequest({
    required int meetingId,
    required int scheduleId,
    String? title,
    String? description,
    DateTime? startAt,
    DateTime? endAt,
    String? location,
  }) = _ScheduleUpdateRequest;
}
