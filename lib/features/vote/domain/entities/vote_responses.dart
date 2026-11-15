import 'package:freezed_annotation/freezed_annotation.dart';

import 'vote_member_response.dart';

part 'vote_responses.freezed.dart';

/// 투표 참여 현황입니다. (API 5-4, 관리자만 조회)
@freezed
abstract class VoteResponses with _$VoteResponses {
  const factory VoteResponses({
    required int memberCount,
    required int respondedCount,
    required List<VoteMemberResponse> members,
  }) = _VoteResponses;
}
