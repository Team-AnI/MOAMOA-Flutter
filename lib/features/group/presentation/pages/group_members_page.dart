import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/group_failure_reason.dart';
import '../../domain/entities/group_member_profile.dart';
import '../../domain/entities/group_profile_color.dart';
import '../providers/group_members_providers.dart';
import '../viewmodels/group_members_state.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';

class GroupMembersPage extends ConsumerWidget {
  const GroupMembersPage({super.key, required this.groupId});
  final int groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(groupMembersProvider(groupId));
    final viewModel = ref.read(groupMembersProvider(groupId).notifier);
    final state = result.hasError
        ? const GroupMembersState(failureReason: GroupFailureReason.unavailable)
        : result.value;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text('구성원', style: GroupDesign.strong),
        centerTitle: true,
        leading: IconButton(
          tooltip: '뒤로',
          icon: const GroupIcon('back', size: 20),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/groups'),
        ),
      ),
      body: SafeArea(
        top: false,
        child: switch (state) {
          null => const Center(child: CircularProgressIndicator()),
          final GroupMembersState data when data.hasFailed => _MembersMessage(
            message: data.message,
            onRetry: data.canRetry ? viewModel.refresh : null,
          ),
          final GroupMembersState data => RefreshIndicator(
            onRefresh: viewModel.refresh,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              itemCount: data.members.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.countLabel, style: GroupDesign.heading),
                      if (data.members.isEmpty) ...[
                        const SizedBox(height: 24),
                        const Text('표시할 구성원이 없어요.', style: GroupDesign.body),
                      ],
                    ],
                  );
                }
                final member = data.members[index - 1];
                return Material(
                  color: GroupDesign.fill,
                  borderRadius: BorderRadius.circular(24),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                    minVerticalPadding: 18,
                    horizontalTitleGap: 12,
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: member.avatarBackground,
                      child: Text(
                        member.initial,
                        style: GroupDesign.strong.copyWith(
                          color: member.avatarForeground,
                        ),
                      ),
                    ),
                    title: Text(member.displayName, style: GroupDesign.strong),
                    subtitle: Text(member.roleLabel, style: GroupDesign.sub),
                  ),
                );
              },
            ),
          ),
        },
      ),
    );
  }
}

class _MembersMessage extends StatelessWidget {
  const _MembersMessage({required this.message, this.onRetry});
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: GroupDesign.body, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('다시 시도')),
          ],
        ],
      ),
    ),
  );
}

/// 프로필 색의 화면 표현은 domain에 Flutter Color를 노출하지 않고 여기서 정합니다.
extension MemberProfileStyleX on GroupMemberProfile {
  Color get avatarBackground => switch (profileColor) {
    GroupProfileColor.lightBlue => GroupDesign.tint,
    GroupProfileColor.gray => const Color(0xffd2d2d7),
    GroupProfileColor.blue => const Color(0xffb8d4f2),
    GroupProfileColor.dark => GroupDesign.ink,
  };
  Color get avatarForeground => switch (profileColor) {
    GroupProfileColor.lightBlue => GroupDesign.blue,
    GroupProfileColor.dark => Colors.white,
    _ => GroupDesign.ink,
  };
}
