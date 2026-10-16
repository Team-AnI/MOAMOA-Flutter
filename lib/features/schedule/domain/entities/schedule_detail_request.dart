import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_detail_request.freezed.dart';

/// 일정 상세 조회 요청입니다.
@freezed
abstract class ScheduleDetailRequest with _$ScheduleDetailRequest {
  const factory ScheduleDetailRequest({
    required int meetingId,
    required int scheduleId,
  }) = _ScheduleDetailRequest;
}
