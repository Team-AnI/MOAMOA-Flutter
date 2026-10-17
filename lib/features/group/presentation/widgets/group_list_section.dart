import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import 'group_design.dart';
import 'group_icon.dart';
import 'group_mark.dart';
import 'group_list_menu.dart';

class GroupListSection extends ConsumerWidget {
  const GroupListSection({
    super.key,
    required this.title,
    required this.groups,
    required this.onSelect,
    this.topPadding = 24,
  });
  final String title;
  final List<CurrentGroup> groups;
  final ValueChanged<int>? onSelect;
  final double topPadding;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: 12, left: 4),
        child: Row(
          children: [
            Flexible(child: Text(title, style: GroupDesign.heading)),
            const SizedBox(width: 8),
            Text(
              '${groups.length}',
              style: GroupDesign.heading.copyWith(color: GroupDesign.muted),
            ),
          ],
        ),
      ),
      for (final current in groups)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: GroupDesign.fill,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: onSelect == null
                  ? null
                  : () => onSelect!(current.group.id),
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    GroupMark(name: current.group.name, photo: null),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(current.group.name, style: GroupDesign.strong),
                          const SizedBox(height: 4),
                          Text(
                            current.group.memberCount == null
                                ? current.canViewInviteCode
                                      ? '관리자'
                                      : '구성원'
                                : '구성원 ${current.group.memberCount}명',
                            style: GroupDesign.sub,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: '${current.group.name} 메뉴',
                      onPressed: onSelect == null
                          ? null
                          : () => showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              showDragHandle: true,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(),
                              builder: (context) =>
                                  GroupListMenu(current: current),
                            ),
                      icon: const GroupIcon('list_more', size: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
