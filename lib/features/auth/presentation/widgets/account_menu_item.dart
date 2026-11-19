import 'package:flutter/widgets.dart';

/// 내 계정 메뉴 한 줄의 내용
class AccountMenuItem {
  const AccountMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showArrow = true,
    this.isDanger = false,
  });

  /// `assets/icons/` 안의 아이콘 파일 이름 (확장자 제외)
  final String icon;
  final String label;
  final VoidCallback onTap;

  /// 다른 화면으로 가는 메뉴면 오른쪽 화살표를 보여줍니다. (로그아웃은 없음)
  final bool showArrow;

  /// 되돌릴 수 없는 메뉴(회원 탈퇴)면 빨간 글자와 연한 빨강 아이콘 칸으로 보여줍니다.
  final bool isDanger;
}
