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

  group('VoteDisplayX 상태별 표시', () {
    final open = sampleVote();
    final closed = sampleVote(votingOpen: false);
    final confirmed = sampleVote(
      status: VoteStatus.confirmed,
      votingOpen: false,
    );
    final canceled = sampleVote(status: VoteStatus.canceled, votingOpen: false);
    final mine = open.candidates.firstWhere((c) => c.selectedByMe);
    final others = open.candidates.firstWhere((c) => !c.selectedByMe);

    test('알약 문구는 마감 뒤에만 관리자에게 "확정 전" 을 덧붙인다', () {
      expect(open.statusLabelFor(isAdmin: true), '투표 중 · 9월 20일 마감');
      expect(closed.statusLabelFor(isAdmin: false), '투표 마감');
      expect(closed.statusLabelFor(isAdmin: true), '투표 마감 · 확정 전');
      expect(confirmed.statusLabelFor(isAdmin: true), '확정');
      expect(canceled.statusLabelFor(isAdmin: false), '취소된 투표');
    });

    test('알약 색은 투표 중·확정은 파랑, 마감·취소는 회색이다', () {
      expect(open.statusPillColors, confirmed.statusPillColors);
      expect(closed.statusPillColors, canceled.statusPillColors);
      expect(open.statusPillColors, isNot(closed.statusPillColors));
    });

    test('제목 아래 안내 문구는 상태마다 다르고, 투표 중에는 고르라고 안내한다', () {
      expect(open.subtitleFor(isAdmin: false), '가능한 시간을 모두 눌러 주세요.');
      expect(closed.subtitleFor(isAdmin: false), '투표가 끝났어요.');
      expect(closed.subtitleFor(isAdmin: true), '투표가 끝났어요. 일정을 확정해 주세요.');
      expect(confirmed.subtitleFor(isAdmin: false), '투표로 정한 일정이에요.');
      expect(canceled.subtitleFor(isAdmin: true), '관리자가 투표를 취소했어요.');
    });

    test('마감 뒤 구성원은 내가 고른 칸만 진하게 보고, 관리자는 모두 진하게 본다', () {
      expect(closed.cellOpacityOf(mine, isAdmin: false), 1);
      expect(closed.cellOpacityOf(others, isAdmin: false), 0.6);
      expect(closed.cellOpacityOf(others, isAdmin: true), 1);
    });

    test('확정되면 모든 칸을 흐리게 하고, 취소되면 칸이 아니라 표 전체를 흐리게 한다', () {
      expect(confirmed.cellOpacityOf(mine, isAdmin: false), 0.4);
      expect(canceled.cellOpacityOf(mine, isAdmin: false), 1);
      expect(canceled.tableOpacity, 0.4);
      expect(open.tableOpacity, 1);
    });

    test('날짜가 3개를 넘거나 시각 줄이 6개를 넘으면 표를 넘겨 봐야 하고 안내 문구가 붙는다', () {
      VoteCandidate at(int day, int hour) => VoteCandidate(
        meetingTime: DateTime(2099, 10, day, hour),
        availableCount: 1,
        selectedByMe: false,
      );
      final fourDates = open.copyWith(
        candidates: [for (var d = 1; d <= 4; d++) at(d, 19)],
      );
      final sevenTimes = open.copyWith(
        candidates: [for (var h = 12; h < 19; h++) at(1, h)],
      );
      final threeByThree = open.copyWith(
        candidates: [
          for (var d = 1; d <= 3; d++)
            for (var h = 18; h <= 20; h++) at(d, h),
        ],
      );

      expect(fourDates.isTableScrollable, isTrue);
      expect(sevenTimes.isTableScrollable, isTrue);
      expect(threeByThree.isTableScrollable, isFalse);
      expect(
        fourDates.subtitleFor(isAdmin: false),
        '날짜는 옆으로, 시간은 위아래로 넘겨 보세요.',
      );
      expect(threeByThree.subtitleFor(isAdmin: false), '가능한 시간을 모두 눌러 주세요.');
    });

    test('공유 문구는 투표 이름과 상태를 담는다', () {
      expect(open.shareText, '[모아모아] 일정 투표 · 10월 정기 모임\n투표 중 · 9월 20일 마감');
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
