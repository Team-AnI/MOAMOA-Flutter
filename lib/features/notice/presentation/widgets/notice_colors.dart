import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 공지 화면 디자인 색상 (Figma: 4 · 모임 홈 — 공지)
abstract final class NoticeColors {
  /// text/primary
  static const text = MoaColors.textPrimary;

  /// text/secondary
  static const bodyText = MoaColors.textSecondary;

  /// text/tertiary
  static const subText = MoaColors.textTertiary;
  static const icon = Color(0xFF4E5968);
  static const hint = Color(0xFFB0B8C1);

  /// bg/fill
  static const gray = MoaColors.fill;
  static const error = Color(0xFFF04452);
}
