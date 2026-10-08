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
      child: const Row(
        children: [
          _Tab(name: '모임', icon: 'groups', active: true),
          _Tab(name: '알림', icon: 'bell', active: false),
          _Tab(name: '내 계정', icon: 'user', active: false),
        ],
      ),
    ),
  );
}

class _Tab extends StatelessWidget {
  const _Tab({required this.name, required this.icon, required this.active});
  final String name, icon;
  final bool active;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Semantics(
      selected: active,
      enabled: active,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GroupIcon(icon, size: 24),
          const SizedBox(height: 3),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: active ? GroupDesign.ink : GroupDesign.muted,
            ),
          ),
        ],
      ),
    ),
  );
}
