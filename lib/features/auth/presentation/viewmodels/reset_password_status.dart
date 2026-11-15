/// 새 비밀번호 설정 요청의 현재 단계
enum ResetPasswordStatus {
  /// 아직 요청하지 않았습니다.
  initial,

  /// 요청 중입니다. 중복 요청은 무시합니다.
  submitting,

  /// 비밀번호를 바꿨습니다. 앱에서 다시 로그인하라고 안내합니다.
  success,

  /// 요청에 실패했습니다.
  failure,
}
