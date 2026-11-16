import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 내 계정 메뉴 한 줄의 내용
class AccountMenuItem {
  const AccountMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.showArrow = true,
  });

  /// `assets/icons/` 안의 아이콘 파일 이름 (확장자 제외)
  final String icon;
  final String label;
  final VoidCallback onTap;

  /// 다른 화면으로 가는 메뉴면 오른쪽 화살표를 보여줍니다. (로그아웃은 없음)
  final bool showArrow;
}

/// 내 계정 화면의 메뉴 묶음 (Figma "Group": 회색 카드 안에 줄과 구분선)
class AccountMenuGroup extends StatelessWidget {
  const AccountMenuGroup({super.key, required this.items});

  final List<AccountMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          for (final (index, item) in items.indexed) ...[
            // 구분선
            if (index > 0)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 1, color: MoaColors.page),
              ),
            // 메뉴 한 줄
            InkWell(
              onTap: item.onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MoaColors.page,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/${item.icon}.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(item.label, style: MoaText.bodyStrong),
                    ),
                    if (item.showArrow)
                      SvgPicture.asset(
                        'assets/icons/caret_right.svg',
                        width: 16,
                        height: 16,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
