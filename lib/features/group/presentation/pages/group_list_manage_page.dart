import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_list_preferences_provider.dart';
import '../providers/group_providers.dart';
import '../viewmodels/group_list_preferences.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_tab_bar.dart';

class GroupListManagePage extends StatelessWidget {
  const GroupListManagePage({super.key, this.archivedOnly = false});
  final bool archivedOnly;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    bottomNavigationBar: const GroupTabBar(),
    body: SafeArea(
      bottom: false,
      child: Column(
        children: [
          _ManageHeader(archivedOnly: archivedOnly),
          Expanded(child: _ManageContent(archivedOnly: archivedOnly)),
        ],
      ),
    ),
  );
}

class _ManageHeader extends StatelessWidget {
  const _ManageHeader({required this.archivedOnly});
  final bool archivedOnly;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                archivedOnly ? '목록에 다시 표시할 수 있어요' : '섹션 안에서 끌어서 순서를 바꿔요',
                style: GroupDesign.sub,
              ),
              const SizedBox(height: 4),
              Text(archivedOnly ? '보관한 모임' : '모임 관리', style: GroupDesign.title),
            ],
          ),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          style: FilledButton.styleFrom(
            backgroundColor: GroupDesign.ink,
            foregroundColor: Colors.white,
            minimumSize: const Size(58, 40),
          ),
          child: Text(
            '완료',
            style: GroupDesign.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

class _ManageContent extends ConsumerWidget {
  const _ManageContent({required this.archivedOnly});
  final bool archivedOnly;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(groupListPreferencesProvider);
    final groups = ref
        .watch(groupProvider)
        .groups
        .where(
          (current) =>
              preferences.archivedIds.contains(current.group.id) ==
              archivedOnly,
        )
        .toList();
    final archivedCount = ref
        .watch(groupProvider)
        .groups
        .where((current) => preferences.archivedIds.contains(current.group.id))
        .length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      children: [
        if (groups.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Text(
              archivedOnly ? '보관한 모임이 없어요.' : '표시할 모임이 없어요.',
              style: GroupDesign.body,
            ),
          ),
        for (final admin in [true, false])
          if (groups.any((current) => current.canViewInviteCode == admin))
            _ManageSection(
              title: admin ? '관리 중인 모임' : '참여 중인 모임',
              topPadding:
                  admin || !groups.any((group) => group.canViewInviteCode)
                  ? 4
                  : 16,
              groups: groups
                  .where((current) => current.canViewInviteCode == admin)
                  .toList(),
              archivedOnly: archivedOnly,
            ),
        if (!archivedOnly) ...[
          const SizedBox(height: 12),
          _ArchivedLink(count: archivedCount),
          const SizedBox(height: 16),
          const Text(
            '고정한 모임은 목록 맨 위에 보여요. 보관한 모임의 기록은 그대로 남아요.',
            style: GroupDesign.sub,
          ),
        ],
      ],
    );
  }
}

class _ArchivedLink extends StatelessWidget {
  const _ArchivedLink({required this.count});
  final int count;
  @override
  Widget build(BuildContext context) => Material(
    color: GroupDesign.fill,
    borderRadius: BorderRadius.circular(24),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      leading: const GroupIcon('list_archive', size: 20),
      title: const Text('보관한 모임', style: GroupDesign.strong),
      subtitle: Text('$count개 · 목록에서 숨겨져요', style: GroupDesign.sub),
      trailing: const GroupIcon('chevron', size: 16),
      onTap: () => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const GroupListManagePage(archivedOnly: true),
        ),
      ),
    ),
  );
}

class _ManageSection extends ConsumerWidget {
  const _ManageSection({
    required this.title,
    required this.groups,
    required this.archivedOnly,
    required this.topPadding,
  });
  final double topPadding;
  final String title;
  final List<CurrentGroup> groups;
  final bool archivedOnly;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(groupListPreferencesProvider);
    final ordered = preferences.arrange(groups, pinnedFirst: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4, topPadding, 4, 12),
          child: Text('$title  ${groups.length}', style: GroupDesign.heading),
        ),
        Material(
          color: GroupDesign.fill,
          borderRadius: BorderRadius.circular(24),
          clipBehavior: Clip.antiAlias,
          child: ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: ordered.length,
            onReorderItem: (oldIndex, newIndex) {
              // Flutter가 삭제 후의 인덱스로 보정하므로 다시 감소시키지 않습니다.
              final reordered = [...ordered];
              reordered.insert(newIndex, reordered.removeAt(oldIndex));
              ref
                  .read(groupListPreferencesProvider.notifier)
                  .reorder(
                    reordered.map((current) => current.group.id).toList(),
                  );
            },
            itemBuilder: (context, index) => _ManageRow(
              key: ValueKey(ordered[index].group.id),
              current: ordered[index],
              index: index,
              archivedOnly: archivedOnly,
            ),
          ),
        ),
      ],
    );
  }
}

class _ManageRow extends StatelessWidget {
  const _ManageRow({
    super.key,
    required this.current,
    required this.index,
    required this.archivedOnly,
  });
  final CurrentGroup current;
  final int index;
  final bool archivedOnly;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Row(
      children: [
        if (!archivedOnly)
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: GroupIcon('list_drag', size: 16),
            ),
          ),
        GroupMark(name: current.group.name, size: 44),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                current.group.name,
                style: GroupDesign.body.copyWith(fontWeight: FontWeight.w600),
              ),
              if (current.group.memberCount != null)
                Text(
                  '구성원 ${current.group.memberCount}명',
                  style: GroupDesign.sub,
                ),
            ],
          ),
        ),
        if (!archivedOnly) _PinButton(groupId: current.group.id),
        _ArchiveButton(groupId: current.group.id, archivedOnly: archivedOnly),
      ],
    ),
  );
}

class _PinButton extends ConsumerWidget {
  const _PinButton({required this.groupId});
  final int groupId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinned = ref
        .watch(groupListPreferencesProvider)
        .pinnedIds
        .contains(groupId);
    return IconButton(
      tooltip: pinned ? '고정 해제' : '맨 위에 고정',
      onPressed: () =>
          ref.read(groupListPreferencesProvider.notifier).togglePin(groupId),
      style: IconButton.styleFrom(
        backgroundColor: pinned ? GroupDesign.tint : Colors.white,
      ),
      icon: GroupIcon(
        'list_pin',
        size: 18,
        color: pinned ? GroupDesign.blue : GroupDesign.ink,
      ),
    );
  }
}

class _ArchiveButton extends ConsumerWidget {
  const _ArchiveButton({required this.groupId, required this.archivedOnly});
  final int groupId;
  final bool archivedOnly;
  @override
  Widget build(BuildContext context, WidgetRef ref) => IconButton(
    tooltip: archivedOnly ? '목록에 다시 표시' : '보관하기',
    onPressed: () =>
        ref.read(groupListPreferencesProvider.notifier).toggleArchive(groupId),
    style: IconButton.styleFrom(backgroundColor: Colors.white),
    icon: const GroupIcon('list_archive', size: 18),
  );
}
