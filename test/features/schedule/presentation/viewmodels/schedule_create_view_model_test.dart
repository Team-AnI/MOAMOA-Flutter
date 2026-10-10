import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/created_schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_status.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late ProviderContainer container;

  final startAt = DateTime(2026, 10, 11, 7);

  setUp(() {
    repository = FakeScheduleRepository();
    container = ProviderContainer(
      overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(scheduleCreateProvider(1), (_, _) {});
  });

  Future<void> submit() {
    return container
        .read(scheduleCreateProvider(1).notifier)
        .submit(title: '정모', startAt: startAt);
  }

  ScheduleCreateState state() => container.read(scheduleCreateProvider(1));

  test('제출 전에는 초기 상태이다', () {
    expect(state().status, ScheduleCreateStatus.initial);
    expect(state().created, isNull);
  });

  test('제출에 성공하면 success 상태가 되고 생성된 일정을 담는다', () async {
    await submit();

    expect(state().status, ScheduleCreateStatus.success);
    expect(
      state().created,
      CreatedSchedule(id: 100, title: '정모', startAt: startAt),
    );
    expect(repository.createCalls.single.meetingId, 1);
  });

  test('제출 중에 다시 눌러도 한 번만 저장한다', () async {
    repository.createCompleter = Completer<int>();

    final first = submit();
    final second = submit();
    expect(state().status, ScheduleCreateStatus.submitting);

    repository.createCompleter!.complete(100);
    await Future.wait([first, second]);

    expect(repository.createCalls, hasLength(1));
    expect(state().status, ScheduleCreateStatus.success);
  });

  test('저장에 실패하면 failure 상태가 되고 다시 제출할 수 있다', () async {
    repository.error = Exception('network');
    await submit();
    expect(state().status, ScheduleCreateStatus.failure);

    repository.error = null;
    await submit();
    expect(state().status, ScheduleCreateStatus.success);
  });

  test('생성에 성공하면 일정 목록을 다시 불러온다', () async {
    final args = ScheduleListRequest(
      meetingId: 1,
      startDate: DateTime(2026, 10),
      endDate: DateTime(2026, 10, 31),
    );
    await container.read(scheduleListProvider(args).future);
    expect(repository.listCallCount, 1);

    await submit();
    await container.read(scheduleListProvider(args).future);

    expect(repository.listCallCount, 2);
  });
}
