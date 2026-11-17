/// 투표로 만든 일정의 상태입니다. (API 5-2 status)
enum VoteStatus {
  /// 투표 중입니다.
  voting,

  /// 후보 하나로 확정되었습니다.
  confirmed,

  /// 취소되었습니다.
  canceled,
}
