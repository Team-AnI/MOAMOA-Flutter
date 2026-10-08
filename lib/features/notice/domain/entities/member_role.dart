/// 모임에서 내 역할 (1-4 모임 상세의 myRole)
///
/// 공지 작성·수정·삭제는 [admin] 만 할 수 있습니다.
enum MemberRole {
  admin,
  member;

  bool get isAdmin => this == MemberRole.admin;
}
