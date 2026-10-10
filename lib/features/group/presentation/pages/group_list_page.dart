import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_empty_state.dart';
import '../widgets/group_entry_choices.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_list_section.dart';
import '../widgets/group_tab_bar.dart';

class GroupListPage extends ConsumerStatefulWidget {
  const GroupListPage({super.key});
  @override
  ConsumerState<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends ConsumerState<GroupListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) ref.read(groupProvider.notifier).loadGroups();
    });
  }

  Future<void> _select(int id) async {
    final selected = await ref.read(groupProvider.notifier).selectGroup(id);
    if (mounted && selected) context.go('/groups/home');
  }

  void _add() => showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(),
    builder: (context) => const SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('모임 추가', style: GroupDesign.heading),
            SizedBox(height: 16),
            GroupEntryChoices(isSheet: true),
          ],
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const GroupTabBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ListHeader(onAdd: _add),
            Expanded(child: _ListBody(onSelect: _select)),
          ],
        ),
      ),
    );
  }
}

/// 내 모임 제목과 추가 버튼. 목록 상태는 직접 구독합니다.
class _ListHeader extends ConsumerWidget {
  const _ListHeader({required this.onAdd});
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        children: [
          const Expanded(child: Text('내 모임', style: GroupDesign.title)),
          if (state.groups.isNotEmpty)
            IconButton(
              tooltip: '모임 추가',
              onPressed: state.isLoading ? null : onAdd,
              style: IconButton.styleFrom(backgroundColor: GroupDesign.ink),
              icon: const GroupIcon('header_plus'),
            ),
        ],
      ),
    );
  }
}

/// 새로고침·오류·승인 대기·역할별 목록을 구성합니다.
class _ListBody extends ConsumerWidget {
  const _ListBody({required this.onSelect});
  final ValueChanged<int> onSelect;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupProvider);
    final pending = ref.watch(groupMockPendingProvider);
    final admins = state.groups
        .where((group) => group.canViewInviteCode)
        .toList();
    final members = state.groups
        .where((group) => !group.canViewInviteCode)
        .toList();
    return RefreshIndicator(
      onRefresh: () => ref.read(groupProvider.notifier).loadGroups(),
      color: GroupDesign.ink,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: CircularProgressIndicator(color: GroupDesign.ink),
              ),
            ),
          if (state.errorMessage != null) ...[
            Text(state.errorMessage!, style: GroupDesign.body),
            TextButton(
              onPressed: () => ref.read(groupProvider.notifier).loadGroups(),
              child: const Text('다시 시도'),
            ),
          ],
          if (!state.isLoading &&
              state.groups.isEmpty &&
              pending.isEmpty &&
              state.errorMessage == null) ...[
            const GroupEmptyState(),
            const SizedBox(height: 12),
          ],
          if (state.groups.isEmpty) const GroupEntryChoices(),
          if (pending.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('승인 대기', style: GroupDesign.heading),
            ),
            for (final group in pending) _PendingCard(name: group.name),
          ],
          if (admins.isNotEmpty)
            GroupListSection(
              title: '관리 중인 모임',
              groups: admins,
              onSelect: state.isLoading ? null : onSelect,
            ),
          if (members.isNotEmpty)
            GroupListSection(
              title: '참여 중인 모임',
              groups: members,
              onSelect: state.isLoading ? null : onSelect,
            ),
        ],
      ),
    );
  }
}

class _PendingCard extends StatelessWidget {
  const _PendingCard({required this.name});
  final String name;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: GroupDesign.fill,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Expanded(child: Text(name, style: GroupDesign.strong)),
        Text(
          '승인 대기',
          style: GroupDesign.caption.copyWith(color: GroupDesign.blue),
        ),
      ],
    ),
  );
}
