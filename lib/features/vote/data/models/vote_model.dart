import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vote.dart';
import '../../domain/entities/vote_status.dart';
import 'vote_candidate_model.dart';

part 'vote_model.freezed.dart';
part 'vote_model.g.dart';

/// 투표 조회 응답 모델 (5-2)
@freezed
abstract class VoteModel with _$VoteModel {
  const factory VoteModel({
    required int scheduleId,
    required String title,

    /// VOTING / CONFIRMED / CANCELED
    required String status,

    /// ISO-8601 (예: 2026-10-22T23:59:00+09:00)
    required String voteDeadlineAt,
    required bool votingOpen,
    required int memberCount,
    required int respondedCount,
    required bool myResponded,
    required List<VoteCandidateModel> candidates,
  }) = _VoteModel;

  factory VoteModel.fromJson(Map<String, dynamic> json) =>
      _$VoteModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
extension VoteModelX on VoteModel {
  Vote toEntity() => Vote(
    scheduleId: scheduleId,
    title: title,
    status: _status,
    voteDeadlineAt: DateTime.parse(voteDeadlineAt).toLocal(),
    votingOpen: votingOpen,
    memberCount: memberCount,
    respondedCount: respondedCount,
    myResponded: myResponded,
    candidates: candidates.map((candidate) => candidate.toEntity()).toList(),
  );

  /// 모르는 상태 값이면 FormatException 을 던져 Repository 에서 ApiException 으로 바뀌게 합니다.
  VoteStatus get _status => switch (status) {
    'VOTING' => VoteStatus.voting,
    'CONFIRMED' => VoteStatus.confirmed,
    'CANCELED' => VoteStatus.canceled,
    _ => throw FormatException('알 수 없는 투표 상태입니다: $status'),
  };
}
