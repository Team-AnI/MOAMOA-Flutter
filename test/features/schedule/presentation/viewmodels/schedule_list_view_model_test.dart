import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late ProviderContainer container;

  final run = Schedule(
    id: 20,
    title: '10월 정기 러닝',
    startAt: DateTime(2026, 10, 11, 7),
  );
  final args = (
    meetingId: 1,
    startDate: DateTime(2026, 10),
    endDate: DateTime(2026, 10, 31),
  );

  setUp(() {
    repository = FakeScheduleRepository(schedules: [run]);
    container = ProviderContainer(
      // 테스트에서는 실패한 Provider 의 자동 재시도를 꺼서 오류 상태를 바로 확인한다.
      retry: (_, _) => null,
      overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  test('일정 목록을 불러온다', () async {
    final schedules = await container.read(scheduleListProvider(args).future);

    expect(schedules, [run]);
  });

  test('refresh 하면 최신 목록으로 갱신된다', () async {
    await container.read(scheduleListProvider(args).future);
    final added = Schedule(
      id: 21,
      title: '정모',
      startAt: DateTime(2026, 10, 18, 14),
    );
    repository.schedules = [run, added];

    await container.read(scheduleListProvider(args).notifier).refresh();

    expect(container.read(scheduleListProvider(args)).value, [run, added]);
  });

  test('refresh 를 연속으로 호출해도 한 번만 조회한다', () async {
    await container.read(scheduleListProvider(args).future);
    final notifier = container.read(scheduleListProvider(args).notifier);
    final before = repository.listCallCount;

    await Future.wait([notifier.refresh(), notifier.refresh()]);

    expect(repository.listCallCount, before + 1);
  });

  test('불러오지 못하면 오류 상태가 된다', () async {
    repository.error = Exception('network');

    await expectLater(
      container.read(scheduleListProvider(args).future),
      throwsException,
    );
  });
}
