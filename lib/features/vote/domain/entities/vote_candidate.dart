import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_candidate.freezed.dart';

/// 투표 후보 시간 하나와 그 시간에 참여 가능한 인원입니다.
@freezed
abstract class VoteCandidate with _$VoteCandidate {
  const factory VoteCandidate({
    required DateTime meetingTime,
    required int availableCount,
    required bool selectedByMe,
  }) = _VoteCandidate;
}
