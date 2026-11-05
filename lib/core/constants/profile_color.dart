/// 구성원 프로필 색 (API 명세 공통 규칙: LIGHT_BLUE(기본)·GRAY·BLUE·DARK)
///
/// 구성원 목록, 공지 작성자·읽음 현황처럼 구성원을 보여주는 곳에서 같이 씁니다.
enum ProfileColor {
  lightBlue,
  gray,
  blue,
  dark;

  /// 서버의 profileColor 값을 바꿉니다.
  ///
  /// 색은 화면에 보여주기만 하는 값이라, 값이 없거나 모르는 값이면 오류 대신 기본 연파랑을 씁니다.
  static ProfileColor fromServer(Object? value) => switch (value) {
    'GRAY' => ProfileColor.gray,
    'BLUE' => ProfileColor.blue,
    'DARK' => ProfileColor.dark,
    _ => ProfileColor.lightBlue,
  };
}
