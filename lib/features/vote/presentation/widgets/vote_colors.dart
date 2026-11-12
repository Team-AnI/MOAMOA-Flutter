import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 투표 화면에서 쓰는 Figma 색 중 공통 토큰([MoaColors])에 없는 값입니다.
abstract final class VoteColors {
  /// alert/text: 오류 문구와 테두리
  static const alert = Color(0xFFE30000);

  /// alert/tint: 오류가 난 시간 선택 띠
  static const alertTint = Color(0xFFFDECEC);

  /// text/disabled: 빈 칸 안내 문구, 비활성 버튼 글자
  static const textDisabled = Color(0xFFCCCCCC);

  /// heat/0~4: 투표 표의 칸 색. 가능 인원이 많을수록 진합니다. 0명(0단계)은 흰 칸입니다.
  static const heat = [
    MoaColors.raised,
    MoaColors.accentTint,
    Color(0xFFB8D4F2),
    Color(0xFF66A3E0),
    MoaColors.accentText,
  ];
}
