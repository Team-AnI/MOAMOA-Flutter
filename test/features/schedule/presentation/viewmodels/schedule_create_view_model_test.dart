import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_exception.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

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
  });

  Future<void> submit({String title = '정모', DateTime? start}) {
    return container
        .read(scheduleCreateProvider(1).notifier)
        .submit(title: title, startAt: start);
  }

  AsyncValue<int?> state() => container.read(scheduleCreateProvider(1));

  test('제출 전에는 값이 없다', () {
    expect(state().value, isNull);
    expect(state().isLoading, isFalse);
  });

  test('제출에 성공하면 생성된 일정 id 를 담는다', () async {
    await submit(start: startAt);

    expect(state().value, 100);
    expect(repository.createCalls.single.meetingId, 1);
  });

  test('입력이 잘못되면 저장하지 않고 검증 오류 상태가 된다', () async {
    await submit(title: ' ');

    expect(state().error, isA<ScheduleValidationException>());
    expect(repository.createCalls, isEmpty);
  });

  test('제출 중에 다시 눌러도 한 번만 저장한다', () async {
    repository.createCompleter = Completer<int>();

    final first = submit(start: startAt);
    final second = submit(start: startAt);
    expect(state().isLoading, isTrue);

    repository.createCompleter!.complete(100);
    await Future.wait([first, second]);

    expect(repository.createCalls, hasLength(1));
    expect(state().isLoading, isFalse);
  });

  test('저장에 실패하면 오류 상태가 되고 다시 제출할 수 있다', () async {
    repository.error = Exception('network');
    await submit(start: startAt);
    expect(state().hasError, isTrue);

    repository.error = null;
    await submit(start: startAt);
    expect(state().value, 100);
  });

  test('생성에 성공하면 일정 목록을 다시 불러온다', () async {
    final args = (
      meetingId: 1,
      startDate: DateTime(2026, 10),
      endDate: DateTime(2026, 10, 31),
    );
    await container.read(scheduleListProvider(args).future);
    expect(repository.listCallCount, 1);

    await submit(start: startAt);
    await container.read(scheduleListProvider(args).future);

    expect(repository.listCallCount, 2);
  });
}
