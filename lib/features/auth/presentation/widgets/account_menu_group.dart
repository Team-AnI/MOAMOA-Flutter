import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

import 'account_menu_item.dart';

/// 메뉴 한 줄의 색. 되돌릴 수 없는 메뉴(회원 탈퇴)는 빨간색으로 보여줍니다.
extension _AccountMenuItemStyleX on AccountMenuItem {
  Color get tileColor => isDanger ? MoaColors.dangerTint : MoaColors.page;

  ColorFilter? get iconColor => isDanger
      ? const ColorFilter.mode(MoaColors.danger, BlendMode.srcIn)
      : null;

  TextStyle get labelStyle => isDanger
      ? MoaText.bodyStrong.copyWith(color: MoaColors.danger)
      : MoaText.bodyStrong;
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
                        color: item.tileColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/${item.icon}.svg',
                        width: 18,
                        height: 18,
                        colorFilter: item.iconColor,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Text(item.label, style: item.labelStyle)),
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
