import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';

/// 선택한 모임의 일정·공지 목록으로 이동하는 모임 홈입니다.
class GroupHomePage extends ConsumerWidget {
  const GroupHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(
      groupProvider.select((state) => state.currentGroup),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
              child: Row(
                children: [
                  _HeaderButton(
                    icon: 'home_back',
                    size: 36,
                    iconSize: 18,
                    label: '내 모임 목록',
                    onPressed: () => context.go('/groups'),
                  ),
                  const SizedBox(width: 10),
                  GroupMark(
                    name: current?.group.name ?? '',
                    size: 36,
                    photo: null,
                    backgroundColor: GroupDesign.darkRaised,
                    cornerRadius: 12,
                    textStyle: GroupDesign.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      current?.group.name ?? '모임 홈',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GroupDesign.heading,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const _HeaderButton(icon: 'home_bell', label: '알림 · 준비 중'),
                  if (current?.canManageGroup ?? false) ...[
                    const SizedBox(width: 8),
                    _HeaderButton(
                      icon: 'home_gear',
                      label: '모임 설정',
                      onPressed: () => context.push('/groups/settings'),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: current == null
                    ? const Text(
                        '내 모임 목록에서 모임을 선택해주세요.',
                        style: GroupDesign.body,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text('구성원', style: GroupDesign.heading),
                              ),
                              Tooltip(
                                message: '구성원 목록은 추후 연결됩니다.',
                                child: TextButton(
                                  onPressed: null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '전체 보기',
                                        style: GroupDesign.sub.copyWith(
                                          color: GroupDesign.muted,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      const GroupIcon(
                                        'chevron',
                                        size: 14,
                                        color: GroupDesign.muted,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: GroupDesign.fill,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: GroupDesign.tint,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: GroupIcon(
                                      'users',
                                      size: 18,
                                      color: GroupDesign.blue,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  current.group.memberCount == null
                                      ? '구성원'
                                      : '${current.group.memberCount}명',
                                  style: GroupDesign.sub.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: current.canViewInviteCode
                                        ? GroupDesign.blue
                                        : GroupDesign.ink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            _HomeTabs(groupId: current?.group.id),
          ],
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.size = 40,
    this.iconSize = 20,
  });
  final double size;
  final double iconSize;
  final String icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: label,
    child: SizedBox(
      width: size,
      height: size,
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: GroupDesign.fill,
          disabledBackgroundColor: GroupDesign.fill,
        ),
        onPressed: onPressed,
        icon: GroupIcon(icon, size: iconSize),
      ),
    ),
  );
}

class _HomeTabs extends StatelessWidget {
  const _HomeTabs({required this.groupId});

  final int? groupId;

  bool get hasSelectedGroup => groupId != null;

  @override
  Widget build(BuildContext context) => Container(
    height: 64,
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: GroupDesign.fill)),
    ),
    padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
    child: Row(
      children: [
        const _HomeTab(
          icon: 'home',
          label: '홈',
          tooltip: '홈',
          isSelected: true,
        ),
        _HomeTab(
          icon: 'home_calendar',
          label: '일정',
          tooltip: hasSelectedGroup ? '일정' : '모임을 선택해주세요',
          onTap: hasSelectedGroup
              ? () => context.push('/meetings/$groupId/schedules')
              : null,
        ),
        _HomeTab(
          icon: 'home_megaphone',
          label: '공지',
          tooltip: hasSelectedGroup ? '공지' : '모임을 선택해주세요',
          onTap: hasSelectedGroup
              ? () => context.push('/meetings/$groupId/notices')
              : null,
        ),
        const _HomeTab(icon: 'wallet', label: '회비', tooltip: '회비 · 준비 중'),
        const _HomeTab(
          icon: 'home_user',
          label: '내 정보',
          tooltip: '내 정보 · 준비 중',
        ),
      ],
    ),
  );
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({
    required this.icon,
    required this.label,
    required this.tooltip,
    this.onTap,
    this.isSelected = false,
  });

  final String icon;
  final String label;
  final String tooltip;
  final VoidCallback? onTap;
  final bool isSelected;

  Color get foregroundColor => isSelected ? GroupDesign.ink : GroupDesign.muted;

  bool get isEnabled => isSelected || onTap != null;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Semantics(
      button: true,
      selected: isSelected,
      enabled: isEnabled,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GroupIcon(icon, size: 24, color: foregroundColor),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: GroupDesign.tab.copyWith(color: foregroundColor),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
