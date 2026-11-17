import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vote_candidate.dart';

part 'vote_candidate_model.freezed.dart';
part 'vote_candidate_model.g.dart';

/// 투표 후보 응답 모델 (5-2 candidates 의 항목)
@freezed
abstract class VoteCandidateModel with _$VoteCandidateModel {
  const factory VoteCandidateModel({
    /// ISO-8601 (예: 2026-10-24T19:00:00+09:00)
    required String meetingTime,
    required int availableCount,
    required bool selectedByMe,
  }) = _VoteCandidateModel;

  factory VoteCandidateModel.fromJson(Map<String, dynamic> json) =>
      _$VoteCandidateModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
extension VoteCandidateModelX on VoteCandidateModel {
  VoteCandidate toEntity() => VoteCandidate(
    meetingTime: DateTime.parse(meetingTime).toLocal(),
    availableCount: availableCount,
    selectedByMe: selectedByMe,
  );
}
