import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/group_providers.dart';
import '../viewmodels/group_state.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';

class GroupSettingsPage extends ConsumerWidget {
  const GroupSettingsPage({super.key});

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final current = ref.read(groupProvider).currentGroup;
    if (current == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GroupDesign.heading,
        contentTextStyle: GroupDesign.body,
        title: const Text('모임을 삭제할까요?'),
        content: Text(
          '“${current.group.name}” 모임을 삭제합니다. 삭제하면 이 모임을 더 이상 이용할 수 없어요.',
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: GroupDesign.ink),
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xffe30000),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    // 확인창이 열린 동안 선택 대상이 바뀌었다면 다른 모임을 삭제하지 않습니다.
    if (ref.read(groupProvider).currentGroup?.group.id != current.group.id) {
      return;
    }
    final deleted = await ref.read(groupProvider.notifier).deleteCurrentGroup();
    if (deleted && context.mounted) context.go('/groups');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupProvider);
    final current = state.currentGroup;
    return PopScope(
      canPop: !state.isBusy,
      child: GroupPageLayout(
        isBack: true,
        onClose: state.isBusy
            ? null
            : () => context.go(current == null ? '/groups' : '/groups/home'),
        child: !state.canManageCurrentGroup || current == null
            ? const Text('모임 관리자 권한이 필요합니다.', style: GroupDesign.body)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const GroupPageTitle(
                    title: '모임 설정',
                    subtitle: '관리자에게만 보이는 화면이에요.',
                  ),
                  Material(
                    color: GroupDesign.fill,
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      onTap: state.isBusy
                          ? null
                          : () => context.push('/groups/edit'),
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            GroupMark(name: current.group.name, size: 56),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    current.group.name,
                                    style: GroupDesign.strong,
                                  ),
                                  const SizedBox(height: 2),
                                  const Text('이름, 소개', style: GroupDesign.sub),
                                ],
                              ),
                            ),
                            const GroupIcon('chevron', size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _SettingsAction(
                    icon: 'settings_ticket',
                    label: '초대 코드 확인',
                    onTap: state.isBusy
                        ? null
                        : () => context.push('/groups/invite'),
                  ),
                  const SizedBox(height: 14),
                  _SettingsAction(
                    icon: 'settings_trash',
                    label: state.isBusy ? '처리 중…' : '모임 삭제',
                    destructive: true,
                    onTap: state.isBusy ? null : () => _delete(context, ref),
                  ),
                  if (state.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(state.errorMessage!, style: GroupDesign.body),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
      ),
    );
  }
}

class _SettingsAction extends StatelessWidget {
  const _SettingsAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });
  final String icon, label;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) => Material(
    color: GroupDesign.fill,
    borderRadius: BorderRadius.circular(24),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: destructive ? const Color(0xfffdecec) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: GroupIcon(icon, size: 18)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GroupDesign.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: destructive
                      ? const Color(0xffe30000)
                      : GroupDesign.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
