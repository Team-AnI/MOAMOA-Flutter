import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_list_preferences_provider.dart';
import 'group_design.dart';
import 'group_icon.dart';
import 'group_mark.dart';

class GroupListMenu extends ConsumerWidget {
  const GroupListMenu({super.key, required this.current});
  final CurrentGroup current;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final display = ref.watch(groupListDisplayProvider);
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                GroupMark(name: current.group.name, size: 48),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(current.group.name, style: GroupDesign.strong),
                      const SizedBox(height: 4),
                      Text(
                        display.menuSubtitle(current),
                        style: GroupDesign.sub,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Material(
              color: GroupDesign.fill,
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: Column(
                  children: [
                    _MenuAction(
                      title: display.isPinned(current.group.id)
                          ? '고정 해제'
                          : '맨 위에 고정',
                      icon: 'list_pin',
                      onTap: () {
                        ref
                            .read(groupListPreferencesProvider.notifier)
                            .togglePin(current.group.id);
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(height: 1, color: Colors.white),
                    const _MenuAction(
                      title: '이 모임 알림 끄기',
                      icon: 'list_mute',
                      subtitle: '알림 기능 연결 후 사용할 수 있어요',
                    ),
                    const Divider(height: 1, color: Colors.white),
                    _MenuAction(
                      title: '보관하기',
                      icon: 'list_archive',
                      subtitle: '목록에서 숨겨요',
                      onTap: () {
                        ref
                            .read(groupListPreferencesProvider.notifier)
                            .toggleArchive(current.group.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Material(
              color: GroupDesign.fill,
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: Column(
                  children: [
                    _MenuAction(
                      title: '모임 나가기',
                      icon: 'list_leave',
                      destructive: true,
                      subtitle: current.canViewInviteCode
                          ? '관리자는 모임을 나갈 수 없어요'
                          : '탈퇴 기능 연결 후 사용할 수 있어요',
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
}

class _MenuAction extends StatelessWidget {
  const _MenuAction({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.destructive = false,
  });
  final String title, icon;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool destructive;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: destructive && onTap != null
                  ? const Color(0xfffdecec)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: GroupIcon(
              icon,
              size: 18,
              color: onTap != null ? null : GroupDesign.muted,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GroupDesign.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: onTap == null
                        ? GroupDesign.muted
                        : destructive
                        ? const Color(0xffe30000)
                        : GroupDesign.ink,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: GroupDesign.caption),
                ],
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
