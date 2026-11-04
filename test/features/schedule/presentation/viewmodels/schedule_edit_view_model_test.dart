import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_update_request.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/schedule_id.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_edit_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_edit_status.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late ProviderContainer container;

  final startAt = DateTime(2026, 10, 11, 7);
  final endAt = DateTime(2026, 10, 11, 9);
  final original = Schedule(id: 20, title: '정모', startAt: startAt);
  const scheduleId = ScheduleId(meetingId: 1, scheduleId: 20);

  // 바뀐 필드 비교용으로 모든 필드가 채워진 일정과, 같은 일정을 서버처럼 UTC 로 받은 일정입니다.
  final detailed = Schedule(
    id: 21,
    title: '10월 정기 러닝',
    description: '반포 한강공원 집합',
    startAt: startAt,
    endAt: endAt,
    location: '반포 한강공원',
  );
  const detailedId = ScheduleId(meetingId: 1, scheduleId: 21);
  final detailedUtc = detailed.copyWith(
    id: 22,
    startAt: startAt.toUtc(),
    endAt: endAt.toUtc(),
  );
  const detailedUtcId = ScheduleId(meetingId: 1, scheduleId: 22);

  setUp(() {
    repository = FakeScheduleRepository(
      schedules: [original, detailed, detailedUtc],
    );
    container = ProviderContainer(
      overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(scheduleEditProvider(scheduleId), (_, _) {});
  });

  Future<void> submit({String title = '새 정모'}) {
    return container
        .read(scheduleEditProvider(scheduleId).notifier)
        .submit(title: title, startAt: startAt);
  }

  ScheduleEditState state() => container.read(scheduleEditProvider(scheduleId));

  /// [id] 일정을 수정 제출합니다. 넘기지 않은 값은 [detailed] 와 같고, [clearEnd] 이면 종료 일시를 비웁니다.
  Future<void> edit(
    ScheduleId id, {
    String title = '10월 정기 러닝',
    String description = '반포 한강공원 집합',
    DateTime? start,
    DateTime? end,
    bool clearEnd = false,
    String location = '반포 한강공원',
  }) {
    container.listen(scheduleEditProvider(id), (_, _) {});
    return container
        .read(scheduleEditProvider(id).notifier)
        .submit(
          title: title,
          description: description,
          startAt: start ?? startAt,
          endAt: clearEnd ? null : end ?? endAt,
          location: location,
        );
  }

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
      await container.read(scheduleDetailProvider(scheduleId).future);
      repository.error = Exception('network');
      await submit();
      expect(state().status, ScheduleEditStatus.failure);

      repository.error = null;
      await submit();
      expect(state().status, ScheduleEditStatus.success);
    });

    test('수정에 성공하면 상세를 다시 불러온다', () async {
      await container.read(scheduleDetailProvider(scheduleId).future);
      expect(repository.detailCallCount, 1);

      await submit();
      await container.read(scheduleDetailProvider(scheduleId).future);

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
        scheduleEditProvider(scheduleId),
        (_, _) {},
      );
      await isolated.read(scheduleListProvider(args).future);
      repository.updateCompleter = Completer<void>();

      final pending = isolated
          .read(scheduleEditProvider(scheduleId).notifier)
          .submit(title: '새 정모', startAt: startAt);
      await pumpEventQueue();
      subscription.close(); // 요청 중에 화면이 닫힌 상황
      await isolated.pump();
      repository.updateCompleter!.complete();
      await pending;
      await isolated.read(scheduleListProvider(args).future);

      expect(repository.listCallCount, 2);
    });

    test('바뀐 필드만 요청에 담아 저장한다', () async {
      await edit(detailedId, title: '11월 정기 러닝', location: '잠실 공원');

      expect(
        repository.updateCalls.single,
        const ScheduleUpdateRequest(
          meetingId: 1,
          scheduleId: 21,
          title: '11월 정기 러닝',
          location: '잠실 공원',
        ),
      );
    });

    test('시작·종료 일시가 바뀌면 바뀐 일시를 요청에 담는다', () async {
      final newStart = DateTime(2026, 10, 12, 7);
      final newEnd = DateTime(2026, 10, 12, 9);

      await edit(detailedId, start: newStart, end: newEnd);

      final request = repository.updateCalls.single;
      expect(request.startAt, newStart);
      expect(request.endAt, newEnd);
      expect(request.title, isNull);
    });

    test('바뀐 필드가 없으면 저장하지 않는다', () async {
      await edit(detailedId);

      expect(repository.updateCalls, isEmpty);
    });

    test('제목 앞뒤 공백은 지우고, 공백만 바뀐 입력은 바뀌지 않은 것으로 본다', () async {
      await edit(detailedId, title: '  10월 정기 러닝  ');

      expect(repository.updateCalls, isEmpty);
    });

    test('종료 일시만 비우면 저장하지 않는다', () async {
      await edit(detailedId, clearEnd: true);

      expect(repository.updateCalls, isEmpty);
    });

    test('종료 일시가 없던 일정에 종료 일시를 넣으면 요청에 담는다', () async {
      await edit(scheduleId, title: '정모', description: '', location: '');

      expect(repository.updateCalls.single.endAt, endAt);
    });

    test('설명이나 장소를 비우면 빈 문자열로 보낸다', () async {
      await edit(detailedId, description: '   ', location: '');

      final request = repository.updateCalls.single;
      expect(request.description, '');
      expect(request.location, '');
    });

    // 서버 응답의 시각은 UTC 로, 입력 폼의 시각은 로컬로 들어온다.
    test('UTC 로 받은 일정과 같은 순간의 로컬 일시이면 일시가 바뀌지 않은 것으로 본다', () async {
      await edit(
        detailedUtcId,
        title: '11월 정기 러닝',
        start: startAt.toLocal(),
        end: endAt.toLocal(),
      );

      final request = repository.updateCalls.single;
      expect(request.title, '11월 정기 러닝');
      expect(request.startAt, isNull);
      expect(request.endAt, isNull);
    });

    test('UTC 로 받은 일정을 바꾸지 않고 저장하면 저장하지 않는다', () async {
      await edit(detailedUtcId, start: startAt.toLocal(), end: endAt.toLocal());

      expect(repository.updateCalls, isEmpty);
    });
  });
}
