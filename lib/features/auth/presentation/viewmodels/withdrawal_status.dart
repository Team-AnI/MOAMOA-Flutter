/// 회원 탈퇴 요청의 현재 단계
enum WithdrawalStatus {
  /// 아직 요청하지 않았습니다.
  initial,

  /// 요청 중입니다. 중복 요청은 무시합니다.
  submitting,

  /// 탈퇴했습니다. 완료 화면으로 이동합니다.
  success,

  /// 요청에 실패했습니다. 비밀번호를 다시 입력하거나 안내를 확인할 수 있습니다.
  failure,
}
