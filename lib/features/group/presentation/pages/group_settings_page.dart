import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/group_providers.dart';
import '../viewmodels/group_state.dart';
import '../widgets/group_design.dart';
import '../widgets/group_delete_dialog.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';

class GroupSettingsPage extends ConsumerWidget {
  const GroupSettingsPage({super.key});

  Future<bool?> _showDeleteDialog(
    BuildContext context,
    GroupDeleteDialog dialog,
  ) => showDialog<bool>(
    context: context,
    barrierColor: GroupDesign.barrier,
    builder: (_) => dialog,
  );

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final current = ref.read(groupProvider).currentGroup;
    if (current == null) return;
    final confirmed = await _showDeleteDialog(
      context,
      GroupDeleteDialog.confirm(name: current.group.name),
    );
    if (confirmed != true) return;

    // 최초 확인 후 삭제를 요청하고, 결과 안내에서 재시도를 선택한 경우만 반복합니다.
    while (context.mounted) {
      // 다이얼로그를 기다리는 동안 선택 모임이 바뀌면 새 모임을 삭제하지 않습니다.
      if (ref.read(groupProvider).currentGroup?.group.id != current.group.id) {
        return;
      }
      final deleted = await ref
          .read(groupProvider.notifier)
          .deleteCurrentGroup();
      if (!context.mounted) return;
      if (deleted) {
        context.go('/groups');
        return;
      }

      final failure = ref.read(groupProvider);
      final shouldRetry = await _showDeleteDialog(
        context,
        GroupDeleteDialog.failure(
          message: failure.deleteFailureMessage,
          canRetry: failure.canRetryFailure,
        ),
      );
      // 닫기·바깥 영역 터치·뒤로 가기는 모두 재요청 없이 종료합니다.
      if (shouldRetry != true) return;
    }
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
                color: destructive ? GroupDesign.dangerTint : Colors.white,
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
                  color: destructive ? GroupDesign.danger : GroupDesign.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
