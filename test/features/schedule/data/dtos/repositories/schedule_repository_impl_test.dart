import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/data/repositories/schedule_repository_impl.dart';

void main() {
  late ScheduleRepositoryImpl repository;

  setUp(() {
    repository = ScheduleRepositoryImpl();
  });

  Future<int> create(String title, DateTime startAt, {int meetingId = 1}) {
    return repository.createSchedule(
      meetingId: meetingId,
      title: title,
      startAt: startAt,
    );
  }

  test('만든 일정을 id 로 조회한다', () async {
    final id = await create('정모', DateTime(2026, 10, 11, 7));

    final schedule = await repository.getSchedule(meetingId: 1, scheduleId: id);

    expect(schedule.title, '정모');
  });

  test('없는 일정을 조회하면 오류가 난다', () async {
    await expectLater(
      repository.getSchedule(meetingId: 1, scheduleId: 999),
      throwsStateError,
    );
  });

  test('기간 안의 같은 모임 일정만 시작 일시 순으로 조회한다', () async {
    await create('늦은 일정', DateTime(2026, 10, 20, 7));
    await create('범위 밖', DateTime(2026, 11, 2, 7));
    await create('다른 모임', DateTime(2026, 10, 12, 7), meetingId: 2);
    await create('이른 일정', DateTime(2026, 10, 11, 7));

    final schedules = await repository.getSchedules(
      meetingId: 1,
      startDate: DateTime(2026, 10, 11),
      endDate: DateTime(2026, 10, 20), // 종료일 당일도 포함
    );

    expect(schedules.map((s) => s.title), ['이른 일정', '늦은 일정']);
  });
}
