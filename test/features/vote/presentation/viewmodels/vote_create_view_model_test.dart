import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/vote/presentation/providers/vote_providers.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_create_state.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_create_status.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_create_view_model.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_slot_interval.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_time_range.dart';

import '../../fakes/fake_vote_repository.dart';

void main() {
  late FakeVoteRepository repository;
  late ProviderContainer container;

  // 마감은 지금 이후여야 해서 먼 미래로 둔다.
  final deadline = DateTime(2099, 10, 12, 23, 59);

  setUp(() {
    repository = FakeVoteRepository();
    container = ProviderContainer(
      overrides: [voteRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(voteCreateProvider(1), (_, _) {});
  });

  VoteCreateViewModel viewModel() =>
      container.read(voteCreateProvider(1).notifier);

  VoteCreateState state() => container.read(voteCreateProvider(1));

  void fillAll() {
    viewModel()
      ..changeTitle('10월 정기 모임')
      ..changeDates([DateTime(2026, 10, 14), DateTime(2026, 10, 13)])
      ..changeDeadline(deadline);
  }

  group(VoteCreateViewModel, () {
    test('처음에는 이름·후보 날짜·투표 마감 3개 항목이 비어 있어 시작할 수 없다', () {
      expect(state().missingCount, 3);
      expect(state().missingHint, '3개 항목을 채우면 투표를 시작할 수 있어요');
      expect(state().canSubmit, isFalse);
    });

    test('처음에는 오류 문구를 보여주지 않는다', () {
      expect(state().titleError, isNull);
      expect(state().datesError, isNull);
      expect(state().deadlineError, isNull);
    });

    test('후보 날짜는 시각을 빼고 겹치는 날짜 없이 오름차순으로 담는다', () {
      viewModel().changeDates([
        DateTime(2026, 10, 14, 9),
        DateTime(2026, 10, 13),
        DateTime(2026, 10, 14),
      ]);

      expect(state().dates, [DateTime(2026, 10, 13), DateTime(2026, 10, 14)]);
      expect(state().datesLabel, '10/13 화 · 10/14 수');
    });

    test('후보 날짜와 후보 시간을 고르면 날짜마다 시작부터 간격마다 종료 전까지의 시각을 후보로 만든다', () {
      viewModel()
        ..changeDates([DateTime(2026, 10, 13), DateTime(2026, 10, 14)])
        ..changeTimeRange(
          const VoteTimeRange(
            start: Duration(hours: 18),
            end: Duration(hours: 20),
            interval: VoteSlotInterval.oneHour,
          ),
        );

      expect(state().meetingTimes, [
        DateTime(2026, 10, 13, 18),
        DateTime(2026, 10, 13, 19),
        DateTime(2026, 10, 14, 18),
        DateTime(2026, 10, 14, 19),
      ]);
    });

    test('빈 항목이 있는데 제출하면 만들지 않고 빈 항목마다 오류 문구를 보여준다', () async {
      viewModel().changeTitle('   ');

      await viewModel().submit();

      expect(repository.createCalls, isEmpty);
      expect(state().status, VoteCreateStatus.initial);
      expect(state().titleError, '일정 이름을 입력해 주세요');
      expect(state().datesError, '후보 날짜를 하나 이상 골라 주세요');
      expect(state().deadlineError, '투표 마감을 골라 주세요');
    });

    test('투표 마감을 지금 이전으로 고르면 마감 칸에 오류 문구를 보여주고 시작할 수 없다', () async {
      viewModel()
        ..changeTitle('10월 정기 모임')
        ..changeDates([DateTime(2026, 10, 13)])
        ..changeDeadline(DateTime.now().subtract(const Duration(hours: 1)));

      expect(state().deadlineError, '투표 마감은 지금 이후로 골라 주세요');
      expect(state().canSubmit, isFalse);

      await viewModel().submit();
      expect(repository.createCalls, isEmpty);

      viewModel().changeDeadline(deadline);
      expect(state().deadlineError, isNull);
      expect(state().canSubmit, isTrue);
    });

    test('마감을 고른 뒤 그 시각이 지나서 제출하면 만들지 않고 마감 칸에 오류 문구를 보여준다', () async {
      viewModel()
        ..changeTitle('10월 정기 모임')
        ..changeDates([DateTime(2026, 10, 13)])
        ..changeDeadline(DateTime.now().add(const Duration(milliseconds: 50)));
      expect(state().canSubmit, isTrue);

      await Future<void>.delayed(const Duration(milliseconds: 100));
      await viewModel().submit();

      expect(repository.createCalls, isEmpty);
      expect(state().deadlineError, '투표 마감은 지금 이후로 골라 주세요');
    });

    test('모두 채우고 제출하면 투표를 만들고 success 상태가 되어 일정 id 를 담는다', () async {
      fillAll();

      await viewModel().submit();

      expect(state().status, VoteCreateStatus.success);
      expect(state().createdScheduleId, 21);
      final call = repository.createCalls.single;
      expect(call['meetingId'], 1);
      expect(call['title'], '10월 정기 모임');
      expect(call['voteDeadlineAt'], deadline);
      // 기본 후보 시간 18:00~20:30, 30분 → 날짜마다 5칸
      final meetingTimes = call['meetingTimes']! as List<DateTime>;
      expect(meetingTimes, hasLength(10));
      expect(meetingTimes.first, DateTime(2026, 10, 13, 18));
      expect(meetingTimes.last, DateTime(2026, 10, 14, 20));
    });

    test('제출 중에 다시 눌러도 한 번만 만든다', () async {
      fillAll();
      repository.createCompleter = Completer<int>();

      final first = viewModel().submit();
      final second = viewModel().submit();
      expect(state().status, VoteCreateStatus.submitting);
      expect(state().canSubmit, isFalse);

      repository.createCompleter!.complete(21);
      await Future.wait([first, second]);

      expect(repository.createCalls, hasLength(1));
      expect(state().status, VoteCreateStatus.success);
    });

    test('서버가 거절하면 failure 상태가 되고 서버 문구를 담으며 다시 제출할 수 있다', () async {
      fillAll();
      repository.error = const ApiException(
        code: ApiErrorCode.validation,
        message: '투표 마감 일시는 현재 이후여야 합니다.',
      );

      await viewModel().submit();

      expect(state().status, VoteCreateStatus.failure);
      expect(state().errorMessage, '투표 마감 일시는 현재 이후여야 합니다.');

      repository.error = null;
      await viewModel().submit();

      expect(state().status, VoteCreateStatus.success);
      expect(state().errorMessage, isNull);
    });
  });
}
