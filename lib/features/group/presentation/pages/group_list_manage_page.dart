import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_list_preferences_provider.dart';
import '../viewmodels/group_list_display_state.dart';
import '../viewmodels/group_display.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_tab_bar.dart';
import 'group_archived_page.dart';

class GroupListManagePage extends ConsumerWidget {
  const GroupListManagePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final display = ref.watch(groupListDisplayProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const GroupTabBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('섹션 안에서 끌어서 순서를 바꿔요', style: GroupDesign.sub),
                        SizedBox(height: 4),
                        Text('모임 관리', style: GroupDesign.title),
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
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                children: [
                  if (display.isManageEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 28),
                      child: Text('표시할 모임이 없어요.', style: GroupDesign.body),
                    ),
                  if (display.manageAdminGroups.isNotEmpty)
                    _ManageSection(
                      title: '관리 중인 모임',
                      topPadding: 4,
                      groups: display.manageAdminGroups,
                      display: display,
                    ),
                  if (display.manageMemberGroups.isNotEmpty)
                    _ManageSection(
                      title: '참여 중인 모임',
                      topPadding: display.manageMemberSectionPadding,
                      groups: display.manageMemberGroups,
                      display: display,
                    ),
                  const SizedBox(height: 12),
                  Material(
                    color: GroupDesign.fill,
                    borderRadius: BorderRadius.circular(24),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      leading: const GroupIcon('list_archive', size: 20),
                      title: const Text('보관한 모임', style: GroupDesign.strong),
                      subtitle: Text(
                        '${display.archivedCount}개 · 목록에서 숨겨져요',
                        style: GroupDesign.sub,
                      ),
                      trailing: const GroupIcon('chevron', size: 16),
                      onTap: () => Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => const GroupArchivedPage(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '고정한 모임은 목록 맨 위에 보여요. 보관한 모임의 기록은 그대로 남아요.',
                    style: GroupDesign.sub,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ManageSection extends ConsumerWidget {
  const _ManageSection({
    required this.title,
    required this.groups,
    required this.topPadding,
    required this.display,
  });
  final GroupListDisplayState display;
  final double topPadding;
  final String title;
  final List<CurrentGroup> groups;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            itemCount: groups.length,
            onReorderItem: (oldIndex, newIndex) => ref
                .read(groupListPreferencesProvider.notifier)
                .reorderSection(groups, oldIndex, newIndex),
            itemBuilder: (context, index) {
              final current = groups[index];
              return Padding(
                key: ValueKey(current.group.id),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Row(
                  children: [
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
                            style: GroupDesign.body.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (current.group.memberCountLabel case final label?)
                            Text(label, style: GroupDesign.sub),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: display.isPinned(current.group.id)
                          ? '고정 해제'
                          : '맨 위에 고정',
                      onPressed: () => ref
                          .read(groupListPreferencesProvider.notifier)
                          .togglePin(current.group.id),
                      style: IconButton.styleFrom(
                        backgroundColor: display.isPinned(current.group.id)
                            ? GroupDesign.tint
                            : Colors.white,
                      ),
                      icon: GroupIcon(
                        'list_pin',
                        size: 18,
                        color: display.isPinned(current.group.id)
                            ? GroupDesign.blue
                            : GroupDesign.ink,
                      ),
                    ),
                    IconButton(
                      tooltip: '보관하기',
                      onPressed: () => ref
                          .read(groupListPreferencesProvider.notifier)
                          .toggleArchive(current.group.id),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      icon: const GroupIcon('list_archive', size: 18),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
