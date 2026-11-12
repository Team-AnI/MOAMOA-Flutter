import 'package:moamoa/features/vote/domain/entities/vote.dart';
import 'package:moamoa/features/vote/domain/entities/vote_candidate.dart';
import 'package:moamoa/features/vote/domain/entities/vote_member_response.dart';
import 'package:moamoa/features/vote/domain/entities/vote_responses.dart';
import 'package:moamoa/features/vote/domain/entities/vote_status.dart';

/// 10/13·10/14 이틀 × 18:00·19:00 두 칸, 8명 중 7명이 응답한 투표입니다.
/// 10/14 19:00 이 7명으로 가장 많고, 내가 고른 칸은 10/13 19:00 입니다.
Vote sampleVote({
  VoteStatus status = VoteStatus.voting,
  bool votingOpen = true,
}) => Vote(
  scheduleId: 7,
  title: '10월 정기 모임',
  status: status,
  voteDeadlineAt: DateTime(2099, 9, 20, 23, 59),
  votingOpen: votingOpen,
  memberCount: 8,
  respondedCount: 7,
  myResponded: true,
  candidates: [
    VoteCandidate(
      meetingTime: DateTime(2099, 10, 13, 18),
      availableCount: 2,
      selectedByMe: false,
    ),
    VoteCandidate(
      meetingTime: DateTime(2099, 10, 13, 19),
      availableCount: 5,
      selectedByMe: true,
    ),
    VoteCandidate(
      meetingTime: DateTime(2099, 10, 14, 18),
      availableCount: 0,
      selectedByMe: false,
    ),
    VoteCandidate(
      meetingTime: DateTime(2099, 10, 14, 19),
      availableCount: 7,
      selectedByMe: false,
    ),
  ],
);

/// 8명 중 1명(이름 없음)이 응답하지 않은 응답 현황입니다.
VoteResponses sampleResponses() => VoteResponses(
  memberCount: 8,
  respondedCount: 7,
  members: [
    for (var id = 1; id <= 7; id++)
      VoteMemberResponse(memberId: id, userName: '구성원$id', responded: true),
    const VoteMemberResponse(memberId: 8, responded: false),
  ],
);
