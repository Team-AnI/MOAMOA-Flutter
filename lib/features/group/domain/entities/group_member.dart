import 'group_role.dart';

/// 한 모임에 속한 사용자의 구성원 정보입니다.
class GroupMember {
  const GroupMember({
    required this.groupId,
    required this.userId,
    required this.role,
  });

  final String groupId;
  final String userId;
  final GroupRole role;
}
