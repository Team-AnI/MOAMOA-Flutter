import 'package:flutter/material.dart';

import '../../domain/entities/current_group.dart';
import 'group_design.dart';
import 'group_icon.dart';
import 'group_list_menu.dart';
import 'group_mark.dart';

class GroupListSection extends StatelessWidget {
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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _SectionHeading(
        title: title,
        count: groups.length,
        topPadding: topPadding,
      ),
      for (final current in groups)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _GroupCard(current: current, onSelect: onSelect),
        ),
    ],
  );
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.count,
    required this.topPadding,
  });
  final String title;
  final int count;
  final double topPadding;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(top: topPadding, bottom: 12, left: 4),
    child: Row(
      children: [
        Flexible(child: Text(title, style: GroupDesign.heading)),
        const SizedBox(width: 8),
        Text(
          '$count',
          style: GroupDesign.heading.copyWith(color: GroupDesign.muted),
        ),
      ],
    ),
  );
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.current, required this.onSelect});
  final CurrentGroup current;
  final ValueChanged<int>? onSelect;
  @override
  Widget build(BuildContext context) => Material(
    color: GroupDesign.fill,
    borderRadius: BorderRadius.circular(24),
    child: InkWell(
      onTap: onSelect == null ? null : () => onSelect!(current.group.id),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            GroupMark(name: current.group.name, photo: null),
            const SizedBox(width: 14),
            Expanded(child: _GroupSummary(current: current)),
            _GroupMenuButton(current: current, enabled: onSelect != null),
          ],
        ),
      ),
    ),
  );
}

class _GroupSummary extends StatelessWidget {
  const _GroupSummary({required this.current});
  final CurrentGroup current;
  @override
  Widget build(BuildContext context) => Column(
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
  );
}

class _GroupMenuButton extends StatelessWidget {
  const _GroupMenuButton({required this.current, required this.enabled});
  final CurrentGroup current;
  final bool enabled;
  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: '${current.group.name} 메뉴',
    onPressed: !enabled
        ? null
        : () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
            builder: (context) => GroupListMenu(current: current),
          ),
    icon: const GroupIcon('list_more', size: 18),
  );
}
