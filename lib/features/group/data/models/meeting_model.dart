import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_member.dart';
import '../../domain/entities/member_role.dart';

part 'meeting_model.freezed.dart';

/// 생성·가입·목록·상세 응답에서 공통으로 사용하는 API 필드입니다.
@Freezed(fromJson: false, toJson: false)
abstract class MeetingModel with _$MeetingModel {
  const factory MeetingModel({
    required int id,
    required String name,
    String? description,
    required MemberRole role,
    int? memberCount,
  }) = _MeetingModel;

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
    id: json['meetingId'] as int,
    name: json['name'] as String,
    description: json['description'] as String?,
    memberCount: _memberCount(json['memberCount']),
    role: switch (json['myRole']) {
      'ADMIN' => MemberRole.admin,
      'MEMBER' => MemberRole.member,
      _ => throw const FormatException('알 수 없는 모임 역할입니다.'),
    },
  );

  static int? _memberCount(Object? value) {
    if (value == null) return null;
    if (value is! int || value < 0) {
      throw const FormatException('잘못된 구성원 수입니다.');
    }
    return value;
  }
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
    membership: GroupMember(groupId: id, role: role),
  );
}
