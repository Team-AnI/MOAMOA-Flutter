/// 내 투표 제출 요청 과정의 현재 단계입니다.
enum VoteSubmitStatus {
  /// 아직 제출하지 않았습니다.
  initial,

  /// 제출 중입니다. 중복 제출은 무시합니다.
  submitting,

  /// 제출에 성공했습니다.
  success,

  /// 제출에 실패했습니다.
  failure,
}
