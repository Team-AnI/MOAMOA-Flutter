import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vote_member_response.dart';

part 'vote_member_response_model.freezed.dart';
part 'vote_member_response_model.g.dart';

/// 구성원별 투표 참여 응답 모델 (5-4 members 의 항목)
@freezed
abstract class VoteMemberResponseModel with _$VoteMemberResponseModel {
  const factory VoteMemberResponseModel({
    required int memberId,
    @JsonKey(readValue: _readUserName) String? userName,
    required bool responded,

    /// ISO-8601. 제출하지 않았으면 null 입니다.
    String? submittedAt,
  }) = _VoteMemberResponseModel;

  factory VoteMemberResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VoteMemberResponseModelFromJson(json);
}

/// 명세는 userName 이지만 배포된 서버(v0.1.0)는 nickname 으로 보냅니다.
Object? _readUserName(Map<dynamic, dynamic> json, String key) =>
    json['userName'] ?? json['nickname'];

/// 응답 모델을 도메인 Entity 로 바꿉니다.
extension VoteMemberResponseModelX on VoteMemberResponseModel {
  VoteMemberResponse toEntity() => VoteMemberResponse(
    memberId: memberId,
    userName: userName,
    responded: responded,
    submittedAt: submittedAt == null
        ? null
        : DateTime.parse(submittedAt!).toLocal(),
  );
}
