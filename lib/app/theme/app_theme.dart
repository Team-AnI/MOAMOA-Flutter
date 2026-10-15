import 'package:flutter/material.dart';

/// 모임 기능에서 분리한 앱 공통 기본 테마입니다.
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: 'Pretendard',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff1d1d1f),
      primary: const Color(0xff1d1d1f),
      surface: Colors.white,
    ),
  );
}
