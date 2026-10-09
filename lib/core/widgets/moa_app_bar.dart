import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 상세/입력 화면 상단의 뒤로가기 AppBar (Figma "Top Bar")
class MoaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoaAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MoaColors.page,
      surfaceTintColor: MoaColors.page,
      scrolledUnderElevation: 0,
      // Figma 의 왼쪽 여백(16px)에 맞춘다.
      leadingWidth: 60,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: IconButton(
          onPressed: context.pop,
          icon: SvgPicture.asset('assets/icons/caret_left.svg'),
        ),
      ),
    );
  }
}
