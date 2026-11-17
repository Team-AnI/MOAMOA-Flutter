import 'package:freezed_annotation/freezed_annotation.dart';

import 'vote_candidate.dart';
import 'vote_status.dart';

part 'vote.freezed.dart';

/// 투표 한 건과 후보별 결과입니다. (API 5-2)
///
/// [votingOpen] 은 투표 중이고 마감 전일 때만 true 이며, 이때만 응답할 수 있습니다.
/// [candidates] 는 후보 시간 오름차순입니다.
@freezed
abstract class Vote with _$Vote {
  const factory Vote({
    required int scheduleId,
    required String title,
    required VoteStatus status,
    required DateTime voteDeadlineAt,
    required bool votingOpen,
    required int memberCount,
    required int respondedCount,
    required bool myResponded,
    required List<VoteCandidate> candidates,
  }) = _Vote;
}
