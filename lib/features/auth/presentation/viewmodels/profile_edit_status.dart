/// 프로필 편집 저장의 현재 단계
enum ProfileEditStatus {
  /// 아직 저장하지 않았습니다.
  initial,

  /// 저장 중입니다. 중복 요청은 무시합니다.
  submitting,

  /// 저장했습니다. 내 계정 화면으로 돌아갑니다.
  success,

  /// 저장에 실패했습니다. 입력한 내용은 그대로 두고 다시 저장할 수 있습니다.
  failure,
}
