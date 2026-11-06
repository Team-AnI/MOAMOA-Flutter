import 'package:flutter/material.dart';

/// Figma Moa4의 색상과 타이포그래피.
abstract final class GroupDesign {
  static const ink = Color(0xff1d1d1f);
  static const fill = Color(0xfff5f5f7);
  static const secondary = Color(0xff333333);
  static const muted = Color(0xff7a7a7a);
  static const blue = Color(0xff0066cc);
  static const tint = Color(0xffe5effa);
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
