/// 프로필 색 저장 요청의 현재 단계
enum ProfileSetupStatus {
  /// 아직 저장하지 않았습니다.
  initial,

  /// 저장 중입니다. 중복 요청은 무시합니다.
  submitting,

  /// 저장했습니다. 첫 화면으로 이동합니다.
  success,

  /// 저장에 실패했습니다. 오류를 안내하고 다시 저장할 수 있습니다.
  failure,
}
