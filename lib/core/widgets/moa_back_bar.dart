import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// 상세/입력 화면 상단의 뒤로가기 바 (Figma "Top Bar")
class MoaBackBar extends StatelessWidget {
  const MoaBackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            onPressed: context.pop,
            icon: SvgPicture.asset('assets/icons/caret_left.svg'),
          ),
        ),
      ),
    );
  }
}
