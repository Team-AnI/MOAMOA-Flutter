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

  /// 동그라미 지름. 글자 크기도 이 값에 맞춰 바뀝니다.
  final double size;

  // 기본 지름 44 일 때 글자 크기 17(MoaText.titleS)과 같은 비율입니다.
  static const _fontSizeRatio = 17 / 44;

  double get _radius => size / 2;

  double get _fontSize => size * _fontSizeRatio;

  String get _initial => userName.profileInitial;

  Color get _background => switch (color) {
    ProfileColor.lightBlue => MoaColors.accentTint,
    ProfileColor.gray => MoaColors.profileGray,
    ProfileColor.blue => MoaColors.profileBlue,
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
      radius: _radius,
      backgroundColor: _background,
      child: Text(
        _initial,
        style: MoaText.titleS.copyWith(color: _foreground, fontSize: _fontSize),
      ),
    );
  }
}
