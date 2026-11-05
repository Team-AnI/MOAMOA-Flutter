// 구성원 이름을 화면에 보여줄 때 쓰는 규칙입니다.
// userName 은 사용자 기능이 생기기 전까지 null 일 수 있습니다. (API 명세 공통 규칙)

import 'package:flutter/widgets.dart';

/// 이름이 없거나 공백이면 '이름 미설정' 을 돌려줍니다.
String profileDisplayName(String? userName) =>
    _hasName(userName) ? userName! : '이름 미설정';

/// 프로필 동그라미 안에 넣을 이름 첫 글자. 이름이 없거나 공백이면 '?' 입니다.
///
/// 이모지처럼 여러 코드로 된 글자도 한 글자로 자릅니다.
String profileInitial(String? userName) =>
    _hasName(userName) ? userName!.trim().characters.first : '?';

bool _hasName(String? userName) =>
    userName != null && userName.trim().isNotEmpty;
