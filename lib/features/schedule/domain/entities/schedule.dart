import 'package:freezed_annotation/freezed_annotation.dart';

import 'schedule_status.dart';

part 'schedule.freezed.dart';

@freezed
abstract class Schedule with _$Schedule {
  const Schedule._();

  const factory Schedule({
    required int id,
    required String title,
    @Default('') String description,
    required DateTime startAt,
    DateTime? endAt,
    @Default('') String location,
    @Default(ScheduleStatus.scheduled) ScheduleStatus status,
  }) = _Schedule;

  /// 투표로 시간을 정하는 중인 일정입니다. [startAt] 은 가장 이른 후보 시간이 임시로 들어 있습니다.
  bool get isVoting => status == ScheduleStatus.voting;
}
