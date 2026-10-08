import '../../domain/entities/current_group.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_member.dart';
import '../../domain/entities/group_role.dart';

/// 생성·가입·목록·상세 응답에서 공통으로 사용하는 API 필드입니다.
class MeetingModel {
  MeetingModel.fromJson(Map<String, dynamic> json)
    : id = json['meetingId'] as int,
      name = json['name'] as String,
      description = json['description'] as String? ?? '',
      memberCount = json['memberCount'] as int?,
      role = switch (json['myRole']) {
        'ADMIN' => GroupRole.admin,
        'MEMBER' => GroupRole.member,
        _ => throw const FormatException('알 수 없는 모임 역할입니다.'),
      };

  final int id;
  final String name;
  final String description;
  final GroupRole role;
  final int? memberCount;

  CurrentGroup toEntity({String? descriptionOverride}) => CurrentGroup(
    group: Group(
      id: id.toString(),
      name: name,
      description: descriptionOverride ?? description,
      memberCount: memberCount,
    ),
    membership: GroupMember(groupId: id.toString(), role: role),
  );
}
