/// 내 정보 조회의 현재 단계
enum MyAccountStatus {
  /// 불러오는 중입니다.
  loading,

  /// 불러왔습니다.
  loaded,

  /// 불러오지 못했습니다. 다시 시도할 수 있습니다.
  failure,
}
