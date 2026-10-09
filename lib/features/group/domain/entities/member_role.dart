/// 모임 안에서 구성원이 가진 권한입니다.
enum MemberRole {
  admin,
  member;

  bool get canWriteNotices => this == admin;
  bool get canCreateSchedules => this == admin;
  bool get canConfirmSchedules => this == admin;

  bool get canViewInviteCode => this == admin;
}
