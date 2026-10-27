import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_edit_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_edit_status.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late ProviderContainer container;

  final startAt = DateTime(2026, 10, 11, 7);
  final original = Schedule(id: 20, title: '정모', startAt: startAt);
  const scheduleArgs = (meetingId: 1, scheduleId: 20);

  setUp(() {
    repository = FakeScheduleRepository(schedules: [original]);
    container = ProviderContainer(
      overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(scheduleEditProvider(scheduleArgs), (_, _) {});
  });

  Future<void> submit({String title = '새 정모'}) {
    return container
        .read(scheduleEditProvider(scheduleArgs).notifier)
        .submit(title: title, startAt: startAt);
  }

  ScheduleEditState state() =>
      container.read(scheduleEditProvider(scheduleArgs));

  group('ScheduleEditViewModel', () {
    test('제출 전에는 초기 상태이다', () {
      expect(state().status, ScheduleEditStatus.initial);
    });

    test('제출에 성공하면 성공 상태가 되고 바뀐 내용을 저장한다', () async {
      await submit();

      expect(state().status, ScheduleEditStatus.success);
      expect(repository.updateCalls.single.title, '새 정모');
      expect(repository.updateCalls.single.scheduleId, 20);
    });

    test('제출 중에 다시 눌러도 한 번만 저장한다', () async {
      repository.updateCompleter = Completer<void>();

      final first = submit();
      final second = submit();
      await Future<void>.delayed(Duration.zero);
      expect(state().status, ScheduleEditStatus.submitting);

      repository.updateCompleter!.complete();
      await Future.wait([first, second]);

      expect(repository.updateCalls, hasLength(1));
      expect(state().status, ScheduleEditStatus.success);
    });

    test('저장에 실패하면 오류 상태가 되고 다시 제출할 수 있다', () async {
      await container.read(scheduleDetailProvider(scheduleArgs).future);
      repository.error = Exception('network');
      await submit();
      expect(state().status, ScheduleEditStatus.failure);

      repository.error = null;
      await submit();
      expect(state().status, ScheduleEditStatus.success);
    });

    test('수정에 성공하면 상세를 다시 불러온다', () async {
      await container.read(scheduleDetailProvider(scheduleArgs).future);
      expect(repository.detailCallCount, 1);

      await submit();
      await container.read(scheduleDetailProvider(scheduleArgs).future);

      expect(repository.detailCallCount, 2);
    });

    test('수정에 성공하면 일정 목록을 다시 불러온다', () async {
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

    test('요청 중에 화면이 닫혀도 수정에 성공하면 일정 목록을 다시 불러온다', () async {
      final args = ScheduleListRequest(
        meetingId: 1,
        startDate: DateTime(2026, 10),
        endDate: DateTime(2026, 10, 31),
      );
      // 공용 container 는 구독을 끊을 수 없어서 따로 만든다.
      final isolated = ProviderContainer(
        overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(isolated.dispose);
      final subscription = isolated.listen(
        scheduleEditProvider(scheduleArgs),
        (_, _) {},
      );
      await isolated.read(scheduleListProvider(args).future);
      repository.updateCompleter = Completer<void>();

      final pending = isolated
          .read(scheduleEditProvider(scheduleArgs).notifier)
          .submit(title: '새 정모', startAt: startAt);
      await pumpEventQueue();
      subscription.close(); // 요청 중에 화면이 닫힌 상황
      await isolated.pump();
      repository.updateCompleter!.complete();
      await pending;
      await isolated.read(scheduleListProvider(args).future);

      expect(repository.listCallCount, 2);
    });
  });
}
