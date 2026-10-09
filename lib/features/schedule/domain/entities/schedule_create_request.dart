import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_create_request.freezed.dart';

/// 일정 생성 요청. 검증이 끝난 값만 담으므로 시작 일시는 null 이 아닙니다.
@freezed
abstract class ScheduleCreateRequest with _$ScheduleCreateRequest {
  const factory ScheduleCreateRequest({
    required int meetingId,
    required String title,
    @Default('') String description,
    required DateTime startAt,
    DateTime? endAt,
    @Default('') String location,
  }) = _ScheduleCreateRequest;
}
