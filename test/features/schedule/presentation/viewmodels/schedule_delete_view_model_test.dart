import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_delete_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_delete_status.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late ProviderContainer container;

  const scheduleArgs = (meetingId: 1, scheduleId: 20);

  setUp(() {
    repository = FakeScheduleRepository();
    container = ProviderContainer(
      overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(scheduleDeleteProvider(scheduleArgs), (_, _) {});
  });

  Future<void> cancel() {
    return container
        .read(scheduleDeleteProvider(scheduleArgs).notifier)
        .cancel();
  }

  ScheduleDeleteState state() =>
      container.read(scheduleDeleteProvider(scheduleArgs));

  group('ScheduleDeleteViewModel', () {
    test('요청 전에는 초기 상태이다', () {
      expect(state().status, ScheduleDeleteStatus.initial);
    });

    test('취소에 성공하면 성공 상태가 되고 해당 일정을 취소한다', () async {
      await cancel();

      expect(state().status, ScheduleDeleteStatus.success);
      expect(repository.deleteCalls.single.meetingId, 1);
      expect(repository.deleteCalls.single.scheduleId, 20);
    });

    test('취소에 실패하면 오류 상태가 되고 다시 요청할 수 있다', () async {
      repository.error = Exception('network');
      await cancel();
      expect(state().status, ScheduleDeleteStatus.failure);

      repository.error = null;
      await cancel();
      expect(state().status, ScheduleDeleteStatus.success);
    });

    test('취소에 성공하면 일정 목록을 다시 불러온다', () async {
      final args = ScheduleListRequest(
        meetingId: 1,
        startDate: DateTime(2026, 10),
        endDate: DateTime(2026, 10, 31),
      );
      await container.read(scheduleListProvider(args).future);
      expect(repository.listCallCount, 1);

      await cancel();
      await container.read(scheduleListProvider(args).future);

      expect(repository.listCallCount, 2);
    });

    test('요청 중에 화면이 닫혀도 취소에 성공하면 일정 목록을 다시 불러온다', () async {
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
        scheduleDeleteProvider(scheduleArgs),
        (_, _) {},
      );
      await isolated.read(scheduleListProvider(args).future);
      repository.deleteCompleter = Completer<void>();

      final pending = isolated
          .read(scheduleDeleteProvider(scheduleArgs).notifier)
          .cancel();
      await pumpEventQueue();
      subscription.close(); // 요청 중에 화면이 닫힌 상황
      await isolated.pump();
      repository.deleteCompleter!.complete();
      await pending;
      await isolated.read(scheduleListProvider(args).future);

      expect(repository.listCallCount, 2);
    });
  });
}
