import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

abstract class ScheduleRepository {
  /// 일정을 만들고 생성된 일정 id를 돌려줍니다.
  Future<int> createSchedule({
    required int meetingId,
    required String title,
    String? description,
    required DateTime startAt,
    DateTime? endAt,
    String? location,
  });

  /// [startDate]~[endDate](포함) 기간의 일정을 시작 일시 순으로 돌려줍니다.
  Future<List<Schedule>> getSchedules({
    required int meetingId,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Schedule> getSchedule({
    required int meetingId,
    required int scheduleId,
  });
}
