import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/vote/presentation/providers/vote_providers.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_submit_state.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_submit_status.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_submit_view_model.dart';
import 'package:moamoa/features/vote/presentation/vote_id.dart';

import '../../fakes/fake_vote_repository.dart';
import '../../fakes/vote_fixtures.dart';

void main() {
  late FakeVoteRepository repository;
  late ProviderContainer container;

  const id = VoteId(meetingId: 1, scheduleId: 7);
  final first = DateTime(2099, 10, 13, 19);
  final second = DateTime(2099, 10, 14, 19);

  setUp(() {
    repository = FakeVoteRepository(vote: sampleVote());
    container = ProviderContainer(
      overrides: [voteRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(voteSubmitProvider(id), (_, _) {});
  });

  VoteSubmitViewModel viewModel() =>
      container.read(voteSubmitProvider(id).notifier);

  VoteSubmitState state() => container.read(voteSubmitProvider(id));

  group(VoteSubmitViewModel, () {
    test('처음에는 아무것도 요청하지 않은 상태다', () {
      expect(state().status, VoteSubmitStatus.initial);
      expect(repository.submitCalls, isEmpty);
    });

    test('고른 후보 시간을 내 응답으로 제출하고 성공 상태가 된다', () async {
      await viewModel().submit([first, second]);

      expect(repository.submitCalls, [
        {
          'meetingId': 1,
          'scheduleId': 7,
          'meetingTimes': [first, second],
        },
      ]);
      expect(state().status, VoteSubmitStatus.success);
    });

    test('빈 목록도 가능한 시간이 없다는 응답으로 제출한다', () async {
      await viewModel().submit([]);

      expect(repository.submitCalls.single['meetingTimes'], isEmpty);
      expect(state().status, VoteSubmitStatus.success);
    });

    test('제출하면 내 선택과 가능 인원이 바뀌므로 투표를 다시 불러온다', () async {
      container.listen(voteProvider(id), (_, _) {});
      await container.read(voteProvider(id).future);
      final before = repository.getVoteCallCount;

      await viewModel().submit([first]);
      await container.read(voteProvider(id).future);

      expect(repository.getVoteCallCount, before + 1);
    });

    test('제출에 실패하면 서버 문구를 담아 실패 상태가 된다', () async {
      repository.submitError = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
        message: '투표가 마감되었습니다.',
      );

      await viewModel().submit([first]);

      expect(state().status, VoteSubmitStatus.failure);
      expect(state().errorMessage, '투표가 마감되었습니다.');
    });

    test('제출에 실패하면 그 사이 마감·확정됐을 수 있어 투표를 다시 불러온다', () async {
      container.listen(voteProvider(id), (_, _) {});
      await container.read(voteProvider(id).future);
      final before = repository.getVoteCallCount;
      repository.submitError = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
      );

      await viewModel().submit([first]);
      await container.read(voteProvider(id).future);

      expect(repository.getVoteCallCount, before + 1);
    });

    test('실패한 뒤 다시 제출하면 성공 상태가 되고 이전 오류 문구는 사라진다', () async {
      repository.submitError = const ApiException(
        code: ApiErrorCode.network,
        message: '네트워크 오류',
      );
      await viewModel().submit([first]);
      repository.submitError = null;

      await viewModel().submit([first]);

      expect(state().status, VoteSubmitStatus.success);
      expect(state().errorMessage, isNull);
    });

    test('제출 중에 다시 제출해도 한 번만 요청한다', () async {
      final completer = Completer<void>();
      repository.submitCompleter = completer;

      final pending = viewModel().submit([first]);
      await Future<void>.delayed(Duration.zero);
      expect(state().status, VoteSubmitStatus.submitting);

      await viewModel().submit([second]); // 무시된다
      completer.complete();
      await pending;

      expect(repository.submitCalls, hasLength(1));
      expect(state().status, VoteSubmitStatus.success);
    });
  });
}
