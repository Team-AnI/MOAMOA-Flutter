import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_icon.dart';

class GroupPageLayout extends StatelessWidget {
  const GroupPageLayout({
    super.key,
    required this.child,
    this.title,
    this.onClose,
    this.isBack = false,
    this.bottom,
    this.step,
  });
  final Widget child;
  final String? title;
  final VoidCallback? onClose;
  final bool isBack;
  final Widget? bottom;
  final int? step;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 56,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (title != null) Text(title!, style: GroupDesign.strong),
                Positioned(
                  left: 16,
                  child: IconButton(
                    tooltip: isBack ? '뒤로' : '닫기',
                    onPressed: onClose,
                    icon: GroupIcon(isBack ? 'back' : 'close', size: 20),
                  ),
                ),
              ],
            ),
          ),
          if (step != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
              child: Row(
                children: [
                  Expanded(child: _step(true)),
                  const SizedBox(width: 6),
                  Expanded(child: _step(step == 2)),
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: child,
            ),
          ),
          if (bottom != null)
            Padding(
              // SafeArea가 확보한 여백에 디자인 여백을 중복해서 더하지 않습니다.
              padding: EdgeInsets.fromLTRB(
                20,
                12,
                20,
                (20 - MediaQuery.paddingOf(context).bottom).clamp(0.0, 20.0),
              ),
              child: bottom!,
            ),
        ],
      ),
    ),
  );

  Widget _step(bool active) => Container(
    height: 4,
    decoration: BoxDecoration(
      color: active ? GroupDesign.ink : const Color(0xffd2d2d7),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
