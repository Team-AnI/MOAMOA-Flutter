import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/group_providers.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/current_group.dart';
import 'group_design.dart';
import 'group_icon.dart';
import 'group_mark.dart';

class GroupListSection extends ConsumerWidget {
  const GroupListSection({
    super.key,
    required this.title,
    required this.groups,
    required this.onSelect,
  });
  final String title;
  final List<CurrentGroup> groups;
  final ValueChanged<int>? onSelect;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 12, left: 4),
        child: Text('$title  ${groups.length}', style: GroupDesign.heading),
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
                    GroupMark(
                      name: current.group.name,
                      photo: ref.watch(groupUseMockProvider)
                          ? ref.watch(groupMockPhotosProvider)[current.group.id]
                          : null,
                    ),
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
                    const GroupIcon('chevron', size: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
