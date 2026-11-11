import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_id.freezed.dart';

/// 상세·수정·취소 Provider 가 키로 쓰는 일정 식별자입니다.
@freezed
abstract class ScheduleId with _$ScheduleId {
  const factory ScheduleId({required int meetingId, required int scheduleId}) =
      _ScheduleId;
}
