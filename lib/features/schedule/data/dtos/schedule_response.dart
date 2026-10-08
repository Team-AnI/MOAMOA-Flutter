import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

part 'schedule_response.freezed.dart';
part 'schedule_response.g.dart';

/// 일정 목록/상세 응답. 일시는 ISO=8601 문자열이 DateTime으로 변환됩니다.
/// 목록 응답에는 description이 없습니다
@freezed
abstract class ScheduleResponse with _$ScheduleResponse {
  const ScheduleResponse._();

  const factory ScheduleResponse({
    @JsonKey(name: 'scheduleId') required int id,
    required String title,
    String? description,
    required DateTime startAt,
    DateTime? endAt,
    String? location,
  }) = _ScheduleResponse;

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);

  Schedule toEntity() => Schedule(
    id: id,
    title: title,
    description: description,
    startAt: startAt,
    endAt: endAt,
    location: location,
  );
}
