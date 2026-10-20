import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

/// 일정 목록/상세 응답. 일시는 ISO=8601 문자열이 DateTime으로 변환됩니다.
/// 목록 응답에는 description이 없습니다
@freezed
abstract class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    @JsonKey(name: 'scheduleId') required int id,
    required String title,
    @Default('') String description,
    required DateTime startAt,
    DateTime? endAt,
    @Default('') String location,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}

/// 응답 DTO 를 도메인 Entity 로 변환합니다.
extension ScheduleModelX on ScheduleModel {
  Schedule toEntity() => Schedule(
    id: id,
    title: title,
    description: description,
    startAt: startAt,
    endAt: endAt,
    location: location,
  );
}
