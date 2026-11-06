import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_icon.dart';

/// 알림·계정 라우트는 각 담당 기능에서 연결합니다.
class GroupTabBar extends StatelessWidget {
  const GroupTabBar({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: GroupDesign.fill)),
      ),
      child: Row(
        children: [
          for (final tab in const [
            (name: '모임', icon: 'groups', active: true),
            (name: '캘린더', icon: 'list_calendar', active: false),
            (name: '내 계정', icon: 'user', active: false),
          ])
            Expanded(
              child: Semantics(
                selected: tab.active,
                enabled: tab.active,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GroupIcon(tab.icon, size: 24),
                    const SizedBox(height: 3),
                    Text(
                      tab.name,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: tab.active ? GroupDesign.ink : GroupDesign.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
