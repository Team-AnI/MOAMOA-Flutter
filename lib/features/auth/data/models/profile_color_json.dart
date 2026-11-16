import 'package:moamoa/core/constants/profile_color.dart';

/// 프로필 색을 서버에 보낼 값으로 바꿉니다. (서버 값을 읽을 때는 [ProfileColor.fromServer])
extension ProfileColorJsonX on ProfileColor {
  String get serverValue => switch (this) {
    ProfileColor.lightBlue => 'LIGHT_BLUE',
    ProfileColor.gray => 'GRAY',
    ProfileColor.blue => 'BLUE',
    ProfileColor.dark => 'DARK',
  };
}
