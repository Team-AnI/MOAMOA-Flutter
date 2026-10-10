import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 상세/입력 화면 상단의 뒤로가기 AppBar (Figma "Top Bar").
///
/// [AppBar] 를 그대로 상속해서 높이(56), 상태 표시줄 처리 등 기본 동작은 AppBar 를 따릅니다.
/// `Scaffold(appBar: MoaAppBar())` 처럼 씁니다. (AppBar 는 const 생성자가 아니라 `const` 를 붙일 수 없습니다.)
class MoaAppBar extends AppBar {
  MoaAppBar({super.key})
    : super(
        backgroundColor: MoaColors.page,
        surfaceTintColor: MoaColors.page,
        scrolledUnderElevation: 0,
        // Figma 의 왼쪽 여백(16px)에 맞춥니다.
        leadingWidth: 60,
        leading: const _BackButton(),
      );
}

/// 이전 화면으로 돌아가는 버튼. `context.pop` 이 필요해서 별도 위젯으로 둡니다.
class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: IconButton(
        onPressed: context.pop,
        icon: SvgPicture.asset('assets/icons/caret_left.svg'),
      ),
    );
  }
}
