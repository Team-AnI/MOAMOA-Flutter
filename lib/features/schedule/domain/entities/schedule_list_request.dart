import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_list_request.freezed.dart';

/// 일정 목록 조회 요청입니다. [startDate]~[endDate](포함) 기간을 조회합니다.
/// 같은 값이면 같은 Provider 로 취급되므로 날짜는 시각을 뺀 값으로 넘기는 것이 좋습니다.
@freezed
abstract class ScheduleListRequest with _$ScheduleListRequest {
  const factory ScheduleListRequest({
    required int meetingId,
    required DateTime startDate,
    required DateTime endDate,
  }) = _ScheduleListRequest;
}
