import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/vote/domain/entities/vote.dart';
import 'package:moamoa/features/vote/domain/entities/vote_candidate.dart';
import 'package:moamoa/features/vote/domain/entities/vote_member_response.dart';
import 'package:moamoa/features/vote/domain/entities/vote_responses.dart';
import 'package:moamoa/features/vote/domain/entities/vote_status.dart';
import 'package:moamoa/features/vote/domain/usecases/confirm_schedule.dart';
import 'package:moamoa/features/vote/domain/usecases/create_vote.dart';
import 'package:moamoa/features/vote/domain/usecases/get_vote.dart';
import 'package:moamoa/features/vote/domain/usecases/get_vote_responses.dart';
import 'package:moamoa/features/vote/domain/usecases/submit_my_vote.dart';

import '../fakes/fake_vote_repository.dart';

void main() {
  final first = DateTime(2026, 10, 24, 19);
  final second = DateTime(2026, 10, 25, 14);
  final vote = Vote(
    scheduleId: 21,
    title: '10월 정기 모임',
    status: VoteStatus.voting,
    voteDeadlineAt: DateTime(2026, 10, 22, 23, 59),
    votingOpen: true,
    memberCount: 8,
    respondedCount: 5,
    myResponded: true,
    candidates: [
      VoteCandidate(meetingTime: first, availableCount: 3, selectedByMe: true),
      VoteCandidate(
        meetingTime: second,
        availableCount: 5,
        selectedByMe: false,
      ),
    ],
  );

  late FakeVoteRepository repository;

  setUp(() {
    repository = FakeVoteRepository(vote: vote);
  });

  group(CreateVote, () {
    test('제목 앞뒤 공백을 지우고 투표를 만든 뒤 일정 id 를 돌려준다', () async {
      final createVote = CreateVoteImpl(voteRepository: repository);

      final scheduleId = await createVote(
        CreateVoteParams(
          meetingId: 1,
          title: '  10월 정기 모임  ',
          voteDeadlineAt: DateTime(2026, 10, 22, 23, 59),
          meetingTimes: [first, second],
        ),
      );

      expect(scheduleId, 21);
      expect(repository.createCalls.single, {
        'meetingId': 1,
        'title': '10월 정기 모임',
        'voteDeadlineAt': DateTime(2026, 10, 22, 23, 59),
        'meetingTimes': [first, second],
      });
    });
  });

  group(GetVote, () {
    test('투표를 후보 목록과 함께 돌려준다', () async {
      final getVote = GetVoteImpl(voteRepository: repository);

      final result = await getVote(
        const GetVoteParams(meetingId: 1, scheduleId: 21),
      );

      expect(result, vote);
    });

    test('저장소가 ApiException 을 던지면 그대로 전달한다', () async {
      repository.error = const ApiException(
        code: ApiErrorCode.notFound,
        message: '투표를 찾을 수 없습니다.',
      );
      final getVote = GetVoteImpl(voteRepository: repository);

      await expectLater(
        getVote(const GetVoteParams(meetingId: 1, scheduleId: 21)),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group(SubmitMyVote, () {
    test('고른 후보 시간을 제출한다', () async {
      final submitMyVote = SubmitMyVoteImpl(voteRepository: repository);

      await submitMyVote(
        SubmitMyVoteParams(meetingId: 1, scheduleId: 21, meetingTimes: [first]),
      );

      expect(repository.submitCalls.single['meetingTimes'], [first]);
    });

    test('고른 후보가 없으면 빈 목록으로 제출해 가능한 시간이 없다고 알린다', () async {
      final submitMyVote = SubmitMyVoteImpl(voteRepository: repository);

      await submitMyVote(
        const SubmitMyVoteParams(
          meetingId: 1,
          scheduleId: 21,
          meetingTimes: [],
        ),
      );

      expect(repository.submitCalls.single['meetingTimes'], isEmpty);
    });
  });

  group(GetVoteResponses, () {
    test('구성원별 참여 현황을 돌려준다', () async {
      const responses = VoteResponses(
        memberCount: 2,
        respondedCount: 1,
        members: [
          VoteMemberResponse(memberId: 3, userName: '김모아', responded: true),
          VoteMemberResponse(memberId: 5, responded: false),
        ],
      );
      repository.responses = responses;
      final getVoteResponses = GetVoteResponsesImpl(voteRepository: repository);

      final result = await getVoteResponses(
        const GetVoteResponsesParams(meetingId: 1, scheduleId: 21),
      );

      expect(result, responses);
    });
  });

  group(ConfirmSchedule, () {
    test('고른 후보 시간으로 일정을 확정한다', () async {
      final confirmSchedule = ConfirmScheduleImpl(voteRepository: repository);

      await confirmSchedule(
        ConfirmScheduleParams(
          meetingId: 1,
          scheduleId: 21,
          meetingTime: second,
        ),
      );

      expect(repository.confirmCalls.single, {
        'meetingId': 1,
        'scheduleId': 21,
        'meetingTime': second,
      });
    });
  });
}
