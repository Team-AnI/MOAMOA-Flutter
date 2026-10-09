import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_icon.dart';

class GroupCreatedActions extends StatelessWidget {
  const GroupCreatedActions({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: GroupDesign.fill,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Column(
      children: [
        _Action(title: '첫 공지 쓰기', icon: 'megaphone'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(height: 1, color: Colors.white),
        ),
        _Action(title: '첫 일정 만들기', icon: 'calendar'),
      ],
    ),
  );
}

class _Action extends StatelessWidget {
  const _Action({required this.title, required this.icon});
  final String title, icon;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: false,
    child: Tooltip(
      message: '담당 기능 화면 연결 후 사용할 수 있어요.',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: GroupIcon(icon, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GroupDesign.body.copyWith(
                  color: GroupDesign.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const GroupIcon('chevron', size: 16),
          ],
        ),
      ),
    ),
  );
}
