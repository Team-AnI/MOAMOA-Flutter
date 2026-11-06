import 'package:flutter/material.dart';

import '../../core/theme/moa_theme.dart';

/// 모임 기능에서 분리한 앱 공통 기본 테마입니다.
abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    fontFamily: 'Pretendard',
    scaffoldBackgroundColor: MoaColors.page,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MoaColors.accent,
      dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
      primary: MoaColors.accent,
      surface: MoaColors.raised,
    ),
  );
}
