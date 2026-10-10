/// 모임 안에서 구성원이 가진 역할입니다.
enum MemberRole { admin, member }

/// 역할에 따른 기능별 권한입니다.
extension MemberRoleX on MemberRole {
  bool get canWriteNotices => this == MemberRole.admin;
  bool get canCreateSchedules => this == MemberRole.admin;
  bool get canConfirmSchedules => this == MemberRole.admin;
  bool get canViewInviteCode => this == MemberRole.admin;
}
