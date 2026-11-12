import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_member.dart';
import '../../domain/entities/member_role.dart';

part 'meeting_model.freezed.dart';
part 'meeting_model.g.dart';

/// 생성·가입·목록·상세 응답에서 공통으로 사용하는 API 필드입니다.
@freezed
abstract class MeetingModel with _$MeetingModel {
  const factory MeetingModel({
    @JsonKey(name: 'meetingId') required int id,
    required String name,
    String? description,
    @JsonKey(name: 'myRole') required String role,
    num? memberCount,
  }) = _MeetingModel;

  factory MeetingModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingModelFromJson(json);
}

/// API 모델을 공유 도메인 엔티티로 변환합니다.
extension MeetingModelX on MeetingModel {
  CurrentGroup toEntity({String? descriptionOverride}) => CurrentGroup(
    group: Group(
      id: id,
      name: name,
      description: descriptionOverride ?? description,
      memberCount: memberCount,
    ),
    membership: GroupMember(groupId: id, role: MemberRole.fromServer(role)),
  );
}
