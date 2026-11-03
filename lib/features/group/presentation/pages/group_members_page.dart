import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
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
      child: ref
          .watch(groupMembersProvider(groupId))
          .when(
            skipLoadingOnRefresh: false,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => _MembersMessage(
              message: '구성원 목록을 불러오지 못했어요.',
              onRetry: () => ref.invalidate(groupMembersProvider(groupId)),
            ),
            data: (state) => state.hasFailed
                ? _MembersMessage(
                    message: state.message,
                    onRetry: state.canRetry
                        ? () => ref.invalidate(groupMembersProvider(groupId))
                        : null,
                  )
                : _MembersList(
                    state: state,
                    onRefresh: () async {
                      ref.invalidate(groupMembersProvider(groupId));
                      await ref.read(groupMembersProvider(groupId).future);
                    },
                  ),
          ),
    ),
  );
}

class _MembersList extends StatelessWidget {
  const _MembersList({required this.state, required this.onRefresh});
  final GroupMembersState state;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: onRefresh,
    child: ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: state.members.length + 1,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) => index == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.countLabel, style: GroupDesign.heading),
                if (state.members.isEmpty) ...[
                  const SizedBox(height: 24),
                  const Text('표시할 구성원이 없어요.', style: GroupDesign.body),
                ],
              ],
            )
          : _MemberTile(member: state.members[index - 1]),
    ),
  );
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member});
  final GroupMemberProfile member;

  @override
  Widget build(BuildContext context) => Material(
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
          style: GroupDesign.strong.copyWith(color: member.avatarForeground),
        ),
      ),
      title: Text(member.displayName, style: GroupDesign.strong),
      subtitle: Text(member.roleLabel, style: GroupDesign.sub),
    ),
  );
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
extension _MemberProfileStyle on GroupMemberProfile {
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
