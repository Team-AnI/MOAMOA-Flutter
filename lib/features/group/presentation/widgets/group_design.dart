import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// Figma Moa4의 색상과 타이포그래피.
abstract final class GroupDesign {
  static const ink = MoaColors.textPrimary;
  static const fill = MoaColors.fill;
  static const secondary = MoaColors.textSecondary;
  static const muted = MoaColors.textTertiary;
  static const blue = MoaColors.accentText;
  static const tint = MoaColors.accentTint;
  static const danger = MoaColors.danger;
  static const dangerTint = MoaColors.dangerTint;
  static const barrier = MoaColors.barrier;
  static const onDarkSecondary = MoaColors.onDarkSecondary;
  static const darkFill = MoaColors.darkFill;
  static const darkRaised = MoaColors.darkRaised;
  static const placeholder = MoaColors.placeholder;
  static const shadow = MoaColors.shadow;
  static const title = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.35,
    letterSpacing: -.7,
    color: ink,
  );
  static const heading = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -.4,
    color: ink,
  );
  static const body = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 15,
    height: 1.47,
    letterSpacing: -.2,
    color: secondary,
  );
  static const strong = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.41,
    letterSpacing: -.3,
    color: ink,
  );
  static const caption = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 12,
    height: 1.33,
    color: secondary,
  );
  static const sub = TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 14,
    height: 1.43,
    letterSpacing: -.1,
    color: secondary,
  );
}
