import 'package:flutter/material.dart';

/// 공지 화면 디자인 색상 (Figma: 4 · 모임 홈 — 공지)
abstract final class NoticeColors {
  /// text/primary
  static const text = Color(0xFF1D1D1F);

  /// text/secondary
  static const bodyText = Color(0xFF333333);

  /// text/tertiary
  static const subText = Color(0xFF7A7A7A);
  static const icon = Color(0xFF4E5968);
  static const hint = Color(0xFFB0B8C1);

  /// bg/fill
  static const gray = Color(0xFFF5F5F7);
  static const divider = Color(0xFFE5E8EB);
  static const error = Color(0xFFF04452);
  static const switchOff = Color(0xFFD2D2D7);

  /// text/disabled
  static const disabled = Color(0xFFCCCCCC);

  /// accent/text
  static const blue = Color(0xFF0066CC);

  /// accent/tint
  static const lightBlue = Color(0xFFE5EFFA);

  /// alert/text, alert/tint (중요 뱃지)
  static const alert = Color(0xFFE30000);
  static const alertTint = Color(0xFFFDECEC);
}
