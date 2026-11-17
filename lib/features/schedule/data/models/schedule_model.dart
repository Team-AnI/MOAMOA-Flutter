import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_status.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

/// 일정 목록/상세 응답. 일시는 ISO=8601 문자열이 DateTime으로 변환됩니다.
/// 목록 응답에는 description이 없습니다
/// status 가 없으면 직접 만든 일정(SCHEDULED)으로 봅니다.
@freezed
abstract class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    @JsonKey(name: 'scheduleId') required int id,
    required String title,
    @Default('') String description,
    required DateTime startAt,
    DateTime? endAt,
    @Default('') String location,
    @Default('SCHEDULED') String status,
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
    status: _status,
  );

  /// 모르는 상태 값이면 FormatException 을 던집니다. (투표 상태와 같은 방식)
  ScheduleStatus get _status => switch (status) {
    'SCHEDULED' => ScheduleStatus.scheduled,
    'VOTING' => ScheduleStatus.voting,
    'CONFIRMED' => ScheduleStatus.confirmed,
    'CANCELED' => ScheduleStatus.canceled,
    _ => throw FormatException('알 수 없는 일정 상태입니다: $status'),
  };
}
