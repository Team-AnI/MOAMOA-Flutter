import 'package:flutter/material.dart';

/// Figma 디자인 토큰(색상)입니다. 화면에서는 색을 직접 쓰지 않고 이 값을 사용합니다.
/// page: 화면 배경 / fill: 카드·입력칸 배경 / raised: 떠 있는 흰 요소 /
/// accent: 강조(검정 버튼, 선택) / accentTint, accentText: 강조의 연한 배경과 글자 /
/// textPrimary·Secondary·Tertiary: 글자 진함 정도 / textInverse: 어두운 배경 위 글자 /
/// profileGray·profileBlue: 프로필 색 GRAY·BLUE 의 동그라미 배경
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
  static const profileGray = Color(0xFFD2D2D7);
  static const profileBlue = Color(0xFFB8D4F2);

  /// 삭제 등 위험 동작의 글자·아이콘 색이며 일반 오류 안내와 구분합니다.
  static const danger = Color(0xFFE30000);

  /// 위험 동작 버튼·안내에 사용하는 연한 배경입니다.
  static const dangerTint = Color(0xFFFDECEC);

  /// 팝업·바텀시트 뒤 화면을 어둡게 덮는 배경입니다.
  static const barrier = Color(0x8F000000);

  /// 어두운 배경의 보조 글자와 입력칸의 힌트 글자입니다.
  static const onDarkSecondary = Color(0xFFCCCCCC);

  /// 초대 코드 카드의 복사 버튼처럼 어두운 요소의 배경입니다.
  static const darkFill = Color(0xFF38383A);

  /// 모임 진입 선택 카드의 어두운 아이콘 영역 배경입니다.
  static const darkRaised = Color(0xFF272729);

  /// 비활성 진행 표시와 바텀시트 손잡이 같은 보조 표시 색입니다.
  static const placeholder = Color(0xFFD2D2D7);

  /// 사진 선택·추가 요소 아래에 드리우는 옅은 그림자입니다.
  static const shadow = Color(0x14000000);

  /// 디자인에 없는 값. 오류 문구에 임시로 사용합니다.
  static const error = Color(0xFFD92D20);
}

/// Figma 디자인 토큰(글자 스타일, Moa4/*)입니다.
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
