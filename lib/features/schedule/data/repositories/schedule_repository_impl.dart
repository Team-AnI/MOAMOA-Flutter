import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// 아직 서버 연동 전이라 메모리에 저장하는 임시 구현체. 앱을 다시 켜면 사라집니다.
/// API 가 생기면 DataSource 를 주입받는 형태로 교체합니다.
class ScheduleRepositoryImpl implements ScheduleRepository {
  final List<({int meetingId, Schedule schedule})> _items = [];
  int _nextId = 1;

  @override
  Future<int> createSchedule({
    required int meetingId,
    required String title,
    String? description,
    required DateTime startAt,
    DateTime? endAt,
    String? location,
  }) async {
    final id = _nextId++;
    _items.add((
      meetingId: meetingId,
      schedule: Schedule(
        id: id,
        title: title,
        description: description,
        startAt: startAt,
        endAt: endAt,
        location: location,
      ),
    ));
    return id;
  }

  @override
  Future<List<Schedule>> getSchedules({
    required int meetingId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final end = endDate.add(const Duration(days: 1));
    return _items
        .where((item) => item.meetingId == meetingId)
        .map((item) => item.schedule)
        .where((s) => !s.startAt.isBefore(startDate) && s.startAt.isBefore(end))
        .toList()
      ..sort((a, b) => a.startAt.compareTo(b.startAt));
  }

  @override
  Future<Schedule> getSchedule({
    required int meetingId,
    required int scheduleId,
  }) async {
    return _items
        .firstWhere(
          (item) =>
              item.meetingId == meetingId && item.schedule.id == scheduleId,
          orElse: () => throw StateError('일정을 찾을 수 없습니다: $scheduleId'),
        )
        .schedule;
  }
}
