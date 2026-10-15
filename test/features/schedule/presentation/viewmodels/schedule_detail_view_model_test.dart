import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late ProviderContainer container;

  final run = Schedule(
    id: 20,
    title: '10월 정기 러닝',
    startAt: DateTime(2026, 10, 11, 7),
  );

  setUp(() {
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        scheduleRepositoryProvider.overrideWithValue(
          FakeScheduleRepository(schedules: [run]),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  test('일정 상세를 불러온다', () async {
    final schedule = await container.read(
      scheduleDetailProvider(
        const ScheduleDetailRequest(meetingId: 1, scheduleId: 20),
      ).future,
    );

    expect(schedule, run);
  });

  test('없는 일정이면 오류 상태가 된다', () async {
    await expectLater(
      container.read(
        scheduleDetailProvider(
          const ScheduleDetailRequest(meetingId: 1, scheduleId: 999),
        ).future,
      ),
      throwsStateError,
    );
  });
}
