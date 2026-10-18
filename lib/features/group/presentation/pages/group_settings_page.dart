import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/entities/member_role.dart';
import '../providers/group_providers.dart';
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
        content: Text('“${current.group.name}” 모임을 삭제합니다. 삭제 후 되돌릴 수 없어요.'),
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
    final busy = state.isSubmitting || state.isLoading;
    final admin = current?.membership.role == MemberRole.admin;
    return PopScope(
      canPop: !busy,
      child: GroupPageLayout(
        isBack: true,
        onClose: busy
            ? null
            : () => context.go(current == null ? '/groups' : '/groups/home'),
        child: !admin || current == null
            ? const Text('모임 관리자 권한이 필요합니다.', style: GroupDesign.body)
            : _SettingsContent(
                current: current,
                busy: busy,
                error: state.errorMessage,
                onDelete: () => _delete(context, ref),
              ),
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({
    required this.current,
    required this.busy,
    required this.error,
    required this.onDelete,
  });
  final CurrentGroup current;
  final bool busy;
  final String? error;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const GroupPageTitle(title: '모임 설정', subtitle: '관리자에게만 보이는 화면이에요.'),
      _SettingsCard(
        onTap: busy ? null : () => context.push('/groups/edit'),
        child: _ProfileSummary(current: current),
      ),
      const SizedBox(height: 14),
      _SettingsCard(
        onTap: busy ? null : () => context.push('/groups/invite'),
        child: const _SettingsRow(icon: 'settings_ticket', label: '초대 코드 확인'),
      ),
      const SizedBox(height: 14),
      _SettingsCard(
        onTap: busy ? null : onDelete,
        child: _SettingsRow(
          icon: 'settings_trash',
          label: busy ? '처리 중…' : '모임 삭제',
          destructive: true,
        ),
      ),
      if (error != null)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(error!, style: GroupDesign.body),
        ),
      const SizedBox(height: 24),
    ],
  );
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({required this.current});
  final CurrentGroup current;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      GroupMark(name: current.group.name, size: 56, photo: null),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(current.group.name, style: GroupDesign.strong),
            const SizedBox(height: 2),
            const Text('이름, 소개', style: GroupDesign.sub),
          ],
        ),
      ),
      const GroupIcon('chevron', size: 16),
    ],
  );
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.destructive = false,
  });
  final String icon, label;
  final bool destructive;

  @override
  Widget build(BuildContext context) => Row(
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
            color: destructive ? const Color(0xffe30000) : GroupDesign.ink,
          ),
        ),
      ),
    ],
  );
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child, this.onTap});
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: GroupDesign.fill,
    borderRadius: BorderRadius.circular(24),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    ),
  );
}
