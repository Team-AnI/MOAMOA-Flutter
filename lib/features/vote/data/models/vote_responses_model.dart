import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vote_responses.dart';
import 'vote_member_response_model.dart';

part 'vote_responses_model.freezed.dart';
part 'vote_responses_model.g.dart';

/// 투표 참여 현황 응답 모델 (5-4)
@freezed
abstract class VoteResponsesModel with _$VoteResponsesModel {
  const factory VoteResponsesModel({
    required int memberCount,
    required int respondedCount,
    required List<VoteMemberResponseModel> members,
  }) = _VoteResponsesModel;

  factory VoteResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$VoteResponsesModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
extension VoteResponsesModelX on VoteResponsesModel {
  VoteResponses toEntity() => VoteResponses(
    memberCount: memberCount,
    respondedCount: respondedCount,
    members: members.map((member) => member.toEntity()).toList(),
  );
}
