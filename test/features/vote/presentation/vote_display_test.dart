import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/vote/domain/entities/vote_candidate.dart';
import 'package:moamoa/features/vote/domain/entities/vote_member_response.dart';
import 'package:moamoa/features/vote/domain/entities/vote_responses.dart';
import 'package:moamoa/features/vote/domain/entities/vote_status.dart';
import 'package:moamoa/features/vote/presentation/vote_display.dart';

import '../fakes/vote_fixtures.dart';

void main() {
  group('VoteDisplayX', () {
    test('후보를 날짜 열과 하루 중 시각 줄로 나눠 오름차순으로 돌려준다', () {
      final vote = sampleVote();

      expect(vote.candidateDates, [
        DateTime(2099, 10, 13),
        DateTime(2099, 10, 14),
      ]);
      expect(vote.candidateTimes, [
        const Duration(hours: 18),
        const Duration(hours: 19),
      ]);
      expect(
        vote.candidateAt(DateTime(2099, 10, 14), const Duration(hours: 19)),
        vote.candidates.last,
      );
    });

    test('그 날짜·시각에 후보가 없으면 칸 후보는 null 이 된다', () {
      final vote = sampleVote().copyWith(
        candidates: [sampleVote().candidates.first],
      );

      expect(
        vote.candidateAt(DateTime(2099, 10, 14), const Duration(hours: 19)),
        isNull,
      );
    });

    const heats = {0: 0, 1: 1, 2: 1, 3: 2, 4: 2, 5: 3, 6: 3, 7: 4, 8: 4};

    for (final MapEntry(key: count, value: heat) in heats.entries) {
      test('8명 중 $count명이 가능하면 $heat단계 색이 된다', () {
        final candidate = VoteCandidate(
          meetingTime: DateTime(2099, 10, 13, 18),
          availableCount: count,
          selectedByMe: false,
        );

        expect(sampleVote().heatOf(candidate), heat);
      });
    }

    test('확정 시트 후보는 가능 인원이 많은 순, 같으면 이른 시간 순이 된다', () {
      final vote = sampleVote().copyWith(
        candidates: [
          for (final (day, count) in [(14, 3), (13, 5), (12, 5)])
            VoteCandidate(
              meetingTime: DateTime(2099, 10, day, 19),
              availableCount: count,
              selectedByMe: false,
            ),
        ],
      );

      expect(
        [for (final c in vote.rankedCandidates) c.meetingTime.day],
        [12, 13, 14],
      );
    });

    test('투표 중이면 마감일을 함께 보여주고, 마감·확정·취소면 상태만 보여준다', () {
      expect(sampleVote().statusLabel, '투표 중 · 9월 20일 마감');
      expect(sampleVote(votingOpen: false).statusLabel, '투표 마감');
      expect(
        sampleVote(status: VoteStatus.confirmed, votingOpen: false).statusLabel,
        '확정',
      );
      expect(
        sampleVote(status: VoteStatus.canceled, votingOpen: false).statusLabel,
        '취소된 투표',
      );
    });

    test('투표 중이면 마감 뒤에도 확정할 수 있고, 확정·취소된 투표는 확정할 수 없다', () {
      expect(sampleVote().canConfirm, isTrue);
      expect(sampleVote(votingOpen: false).canConfirm, isTrue);
      expect(sampleVote(status: VoteStatus.confirmed).canConfirm, isFalse);
      expect(sampleVote(status: VoteStatus.canceled).canConfirm, isFalse);
    });
  });

  group('VoteResponsesDisplayX', () {
    test('응답하지 않은 구성원 이름을 모아 보여주고, 이름이 없으면 기본 문구로 바꾼다', () {
      final responses = sampleResponses().copyWith(
        members: [
          ...sampleResponses().members,
          const VoteMemberResponse(
            memberId: 9,
            userName: '최민아',
            responded: false,
          ),
        ],
      );

      expect(responses.unrespondedNamesLabel, '미응답 이름 미설정, 최민아');
    });

    test('모두 응답했으면 미응답 이름 문구가 없다', () {
      const responses = VoteResponses(
        memberCount: 1,
        respondedCount: 1,
        members: [VoteMemberResponse(memberId: 1, responded: true)],
      );

      expect(responses.unrespondedNamesLabel, isNull);
    });
  });
}
