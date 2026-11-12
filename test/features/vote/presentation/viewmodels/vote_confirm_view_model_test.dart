import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/vote/presentation/providers/vote_providers.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_confirm_state.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_confirm_status.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_confirm_view_model.dart';
import 'package:moamoa/features/vote/presentation/vote_id.dart';

import '../../fakes/fake_vote_repository.dart';
import '../../fakes/vote_fixtures.dart';

void main() {
  late FakeVoteRepository repository;
  late ProviderContainer container;

  const id = VoteId(meetingId: 1, scheduleId: 7);
  final meetingTime = DateTime(2099, 10, 14, 19);

  setUp(() {
    repository = FakeVoteRepository();
    container = ProviderContainer(
      overrides: [voteRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(voteConfirmProvider(id), (_, _) {});
  });

  VoteConfirmViewModel viewModel() =>
      container.read(voteConfirmProvider(id).notifier);

  VoteConfirmState state() => container.read(voteConfirmProvider(id));

  group(VoteConfirmViewModel, () {
    test('고른 후보 시간으로 확정을 요청하고 성공 상태가 된다', () async {
      await viewModel().confirm(meetingTime);

      expect(repository.confirmCalls, [
        {'meetingId': 1, 'scheduleId': 7, 'meetingTime': meetingTime},
      ]);
      expect(state().status, VoteConfirmStatus.success);
    });

    test('확정에 실패하면 서버 문구를 담아 실패 상태가 된다', () async {
      repository.error = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
        message: '이미 확정된 일정입니다.',
      );

      await viewModel().confirm(meetingTime);

      expect(state().status, VoteConfirmStatus.failure);
      expect(state().errorMessage, '이미 확정된 일정입니다.');
    });

    test('확정에 실패하면 다른 관리자가 먼저 확정했을 수 있어 투표를 다시 불러온다', () async {
      repository.vote = sampleVote();
      container.listen(voteProvider(id), (_, _) {});
      await container.read(voteProvider(id).future);
      final before = repository.getVoteCallCount;
      repository.confirmError = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
      );

      await viewModel().confirm(meetingTime);
      await container.read(voteProvider(id).future);

      expect(repository.getVoteCallCount, greaterThan(before));
    });

    test('확정 중에 다시 눌러도 한 번만 요청한다', () async {
      repository.confirmCompleter = Completer<void>();

      final first = viewModel().confirm(meetingTime);
      expect(state().status, VoteConfirmStatus.submitting);
      await viewModel().confirm(meetingTime);
      repository.confirmCompleter!.complete();
      await first;

      expect(repository.confirmCalls, hasLength(1));
      expect(state().status, VoteConfirmStatus.success);
    });
  });
}
