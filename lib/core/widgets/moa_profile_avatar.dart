import 'package:flutter/material.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/profile_name.dart';

/// 구성원 프로필 동그라미. 프로필 색 배경에 이름 첫 글자를 보여줍니다.
///
/// 프로필 사진은 차기 버전이라 아직 받지 않습니다. 사진이 생겨도 없을 때는 지금처럼 색으로 보여줍니다.
class MoaProfileAvatar extends StatelessWidget {
  const MoaProfileAvatar({
    super.key,
    required this.userName,
    required this.color,
    this.size = 44,
  });

  final String? userName;
  final ProfileColor color;

  /// 동그라미 지름
  final double size;

  // 회색·파랑 배경은 아직 MoaColors 토큰이 없어 구성원 목록(#82)의 값을 그대로 씁니다.
  static const _grayBackground = Color(0xFFD2D2D7);
  static const _blueBackground = Color(0xFFB8D4F2);

  Color get _background => switch (color) {
    ProfileColor.lightBlue => MoaColors.accentTint,
    ProfileColor.gray => _grayBackground,
    ProfileColor.blue => _blueBackground,
    ProfileColor.dark => MoaColors.accent,
  };

  Color get _foreground => switch (color) {
    ProfileColor.lightBlue => MoaColors.accentText,
    ProfileColor.gray || ProfileColor.blue => MoaColors.textPrimary,
    ProfileColor.dark => MoaColors.textInverse,
  };

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: _background,
      child: Text(
        profileInitial(userName),
        style: MoaText.titleS.copyWith(color: _foreground),
      ),
    );
  }
}
