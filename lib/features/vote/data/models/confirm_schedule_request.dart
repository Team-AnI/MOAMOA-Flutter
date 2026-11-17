import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_schedule_request.freezed.dart';
part 'confirm_schedule_request.g.dart';

/// 일정 확정(5-5) 요청. [toJson] 은 요청 본문(meetingTime)이 됩니다.
@freezed
abstract class ConfirmScheduleRequest with _$ConfirmScheduleRequest {
  const factory ConfirmScheduleRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int scheduleId,
    required String meetingTime,
  }) = _ConfirmScheduleRequest;

  factory ConfirmScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmScheduleRequestFromJson(json);
}
