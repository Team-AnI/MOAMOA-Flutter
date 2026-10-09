import 'member_role.dart';

/// 한 모임에 속한 사용자의 구성원 정보입니다.
class GroupMember {
  const GroupMember({required this.groupId, this.userId, required this.role});

  final int groupId;

  /// 생성·가입·목록 응답에는 userId가 없으므로, 계정 조회 연동 전에는 null입니다.
  final int? userId;
  final MemberRole role;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupMember &&
          groupId == other.groupId &&
          userId == other.userId &&
          role == other.role;
  @override
  int get hashCode => Object.hash(groupId, userId, role);
}
