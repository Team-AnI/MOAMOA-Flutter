import 'package:flutter/material.dart';

/// Figma 디자인 토큰(색상)
abstract final class MoaColors {
  static const page = Color(0xFFFFFFFF);
  static const fill = Color(0xFFF5F5F7);
  static const raised = Color(0xFFFFFFFF);
  static const accent = Color(0xFF1D1D1F);
  static const accentTint = Color(0xFFE5EFFA);
  static const accentText = Color(0xFF0066CC);
  static const textPrimary = Color(0xFF1D1D1F);
  static const textSecondary = Color(0xFF333333);
  static const textTertiary = Color(0xFF7A7A7A);
  static const textInverse = Color(0xFFFFFFFF);

  /// 디자인에 없는 값. 오류 문구에 임시로 사용합니다.
  static const error = Color(0xFFD92D20);
}

/// Figma 디자인 토큰(글자 스타일, Moa4/*).
/// TODO: Pretendard 폰트를 추가하면 fontFamily 를 지정합니다.
abstract final class MoaText {
  static final titleXl = _s(26, FontWeight.w700, 1.35, -0.7);
  static final titleM = _s(18, FontWeight.w700, 1.4, -0.4);
  static final titleL = _s(22, FontWeight.w700, 1.36, -0.5);
  static final titleS = _s(17, FontWeight.w600, 1.41, -0.3);
  static final bodyStrong = _s(15, FontWeight.w600, 1.47, -0.2);
  static final body = _s(15, FontWeight.w400, 1.47, -0.2);
  static final subStrong = _s(14, FontWeight.w600, 1.43, -0.1);
  static final sub = _s(14, FontWeight.w400, 1.43, -0.1);
  static final captionStrong = _s(12, FontWeight.w600, 1.33, 0);
  static final caption = _s(12, FontWeight.w400, 1.33, 0);
  static final button = _s(16, FontWeight.w600, 1.25, -0.2);

  static TextStyle _s(
    double size,
    FontWeight weight,
    double height,
    double ls,
  ) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: ls,
      color: MoaColors.textPrimary,
    );
  }
}
