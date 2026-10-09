import '../widgets/group_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_primary_button.dart';

class GroupJoinedPage extends ConsumerWidget {
  const GroupJoinedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(groupProvider).currentGroup;
    return GroupPageLayout(
      onClose: () => context.go('/groups'),
      bottom: GroupPrimaryButton(
        label: '내 모임으로',
        secondary: true,
        onPressed: () => context.go('/groups'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: GroupDesign.tint,
              shape: BoxShape.circle,
            ),
            child: const Center(child: GroupIcon('check', size: 34)),
          ),
          const SizedBox(height: 10),
          const Text('모임에 가입했어요', style: GroupDesign.title),
          const SizedBox(height: 10),
          const Text(
            '일반 구성원으로 가입했어요. 이제 모임에서 함께할 수 있어요.',
            style: GroupDesign.body,
          ),
          const SizedBox(height: 28),
          if (current != null)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: GroupDesign.fill,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  GroupMark(name: current.group.name, size: 48),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(current.group.name, style: GroupDesign.strong),
                        const Text('일반 구성원', style: GroupDesign.sub),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: GroupDesign.tint,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '가입 완료',
                      style: GroupDesign.caption.copyWith(
                        color: GroupDesign.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
