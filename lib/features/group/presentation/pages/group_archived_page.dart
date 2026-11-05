import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_archived_provider.dart';
import '../providers/group_list_preferences_provider.dart';
import '../viewmodels/group_list_display_state.dart';
import '../widgets/group_design.dart';
import '../widgets/group_feedback_card.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';

class GroupArchivedPage extends ConsumerWidget {
  const GroupArchivedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restoredName = ref.watch(groupArchivedProvider);
    final display = ref.watch(groupListDisplayProvider);
    return GroupPageLayout(
      isBack: true,
      onClose: () => Navigator.pop(context),
      bottom: restoredName == null
          ? null
          : GroupFeedbackCard(
              title: '“$restoredName” 모임을 목록으로 돌려놨어요',
              message: '내 모임 목록에서 다시 볼 수 있어요',
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GroupPageTitle(
            title: '보관한 모임',
            subtitle: '목록에서 숨긴 모임을 다시 표시할 수 있어요.',
          ),
          if (display.isArchiveEmpty) const _ArchiveEmpty(),
          for (final current in display.archivedGroups)
            _ArchivedGroupTile(
              current: current,
              onRestore: () =>
                  ref.read(groupArchivedProvider.notifier).restore(current),
            ),
        ],
      ),
    );
  }
}

class _ArchiveEmpty extends StatelessWidget {
  const _ArchiveEmpty();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 229),
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: GroupDesign.tint,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(child: GroupIcon('archive_empty', size: 32)),
        ),
        const SizedBox(height: 16),
        const Text(
          '보관한 모임이 없어요',
          style: GroupDesign.heading,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        const Text(
          '모임을 보관하면 여기에 모여요',
          style: GroupDesign.body,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _ArchivedGroupTile extends StatelessWidget {
  const _ArchivedGroupTile({required this.current, required this.onRestore});

  final CurrentGroup current;
  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Material(
      color: GroupDesign.fill,
      borderRadius: BorderRadius.circular(24),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        minVerticalPadding: 18,
        horizontalTitleGap: 12,
        leading: GroupMark(name: current.group.name, size: 44),
        title: Text(current.group.name, style: GroupDesign.strong),
        subtitle: current.group.memberCount == null
            ? null
            : Text('구성원 ${current.group.memberCount}명', style: GroupDesign.sub),
        trailing: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: GroupDesign.ink,
            foregroundColor: Colors.white,
          ),
          onPressed: onRestore,
          child: const Text('복원'),
        ),
      ),
    ),
  );
}
