/// 모임에서 내 역할 (1-4 모임 상세의 myRole)
///
/// 공지 작성·수정·삭제는 [admin] 만 할 수 있습니다.
// TODO(#44): #35 에서 group 역할 타입이 정리되면 이 enum 을 삭제하고 group 의 타입으로 교체
enum MemberRole {
  admin,
  member;

  bool get isAdmin => this == MemberRole.admin;
}
