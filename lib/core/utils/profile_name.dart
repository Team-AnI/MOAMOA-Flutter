import 'package:flutter/widgets.dart';

/// 구성원 이름(userName)을 화면에 보여줄 때 쓰는 규칙입니다.
///
/// - userName 은 사용자 기능이 생기기 전까지 null 일 수 있습니다. (API 명세 공통 규칙)
/// - 모임을 나갔거나 탈퇴한 구성원은 서버가 userName 을 "탈퇴한 사용자" 로 보냅니다.
///   따로 정한 디자인이 없어 다른 이름과 똑같이 그대로 보여줍니다.
extension ProfileNameX on String? {
  /// 화면에 보여줄 이름. 이름이 없거나 공백이면 '이름 미설정' 입니다.
  String get profileDisplayName => _hasName ? this! : '이름 미설정';

  /// 프로필 동그라미 안에 넣을 이름 첫 글자. 이름이 없거나 공백이면 '?' 입니다.
  ///
  /// 이모지처럼 여러 코드로 된 글자도 한 글자로 자릅니다.
  String get profileInitial => _hasName ? this!.trim().characters.first : '?';

  bool get _hasName => this != null && this!.trim().isNotEmpty;
}
