import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';

/// 일정·공지·회비 영역은 담당 기능에서 연결합니다.
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
                    icon: 'back',
                    label: '내 모임 목록',
                    onPressed: () => context.go('/groups'),
                  ),
                  const SizedBox(width: 10),
                  GroupMark(
                    name: current?.group.name ?? '',
                    size: 36,
                    photo: ref.watch(groupUseMockProvider)
                        ? ref.watch(groupMockPhotosProvider)[current?.group.id]
                        : null,
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
                  const _HeaderButton(icon: 'bell', label: '알림 · 준비 중'),
                  if (current?.canViewInviteCode ?? false) ...[
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      tooltip: '모임 설정',
                      onSelected: (_) => context.push('/groups/invite'),
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: 'invite',
                          child: Text('초대 코드 확인'),
                        ),
                      ],
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: GroupDesign.fill,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(child: GroupIcon('gear', size: 20)),
                      ),
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
            const _HomeTabs(),
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
  });
  final String icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: label,
    child: SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: GroupDesign.fill,
          disabledBackgroundColor: GroupDesign.fill,
        ),
        onPressed: onPressed,
        icon: GroupIcon(icon, size: 20),
      ),
    ),
  );
}

class _HomeTabs extends StatelessWidget {
  const _HomeTabs();
  @override
  Widget build(BuildContext context) => Container(
    height: 64,
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: GroupDesign.fill)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      children: [
        for (final tab in const [
          ('home', '홈'),
          ('home_calendar', '일정'),
          ('home_megaphone', '공지'),
          ('wallet', '회비'),
          ('user', '내 정보'),
        ])
          Expanded(
            child: Tooltip(
              message: tab.$2 == '홈' ? '홈' : '${tab.$2} · 준비 중',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GroupIcon(
                    tab.$1,
                    size: 24,
                    color: tab.$2 == '홈' ? GroupDesign.ink : GroupDesign.muted,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    tab.$2,
                    style: GroupDesign.caption.copyWith(
                      fontSize: 11,
                      color: tab.$2 == '홈'
                          ? GroupDesign.ink
                          : GroupDesign.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
