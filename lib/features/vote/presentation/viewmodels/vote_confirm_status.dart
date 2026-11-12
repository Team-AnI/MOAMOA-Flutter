/// 일정 확정 요청 과정의 현재 단계입니다.
enum VoteConfirmStatus {
  /// 아직 요청하지 않았습니다.
  initial,

  /// 요청 중입니다. 중복 요청은 무시합니다.
  submitting,

  /// 확정에 성공했습니다. 화면을 닫습니다.
  success,

  /// 확정에 실패했습니다.
  failure,
}
