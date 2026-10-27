import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_list_preferences_provider.dart';
import '../providers/group_providers.dart';
import '../viewmodels/group_list_preferences.dart';
import '../widgets/group_design.dart';
import '../widgets/group_empty_state.dart';
import '../widgets/group_entry_choices.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_list_section.dart';
import '../widgets/group_tab_bar.dart';
import 'group_list_manage_page.dart';

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
    final name = ref.watch(groupCurrentUserNameProvider)?.trim();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name == null || name.isEmpty ? '안녕하세요' : '$name님, 안녕하세요',
                  style: GroupDesign.sub,
                ),
                const SizedBox(height: 4),
                const Text('내 모임', style: GroupDesign.title),
              ],
            ),
          ),
          IconButton(
            tooltip: '알림 (연결 예정)',
            onPressed: null,
            style: IconButton.styleFrom(
              disabledBackgroundColor: GroupDesign.fill,
            ),
            icon: const GroupIcon('list_bell', size: 20),
          ),
          const SizedBox(width: 8),
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
    final preferences = ref.watch(groupListPreferencesProvider);
    final visible = preferences.arrange(
      state.groups.where(
        (current) => !preferences.archivedIds.contains(current.group.id),
      ),
    );
    final admins = visible.where((group) => group.canViewInviteCode).toList();
    final members = visible.where((group) => !group.canViewInviteCode).toList();
    return RefreshIndicator(
      onRefresh: () => ref.read(groupProvider.notifier).loadGroups(),
      color: GroupDesign.ink,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const _ListStatus(),
          if (state.groups.isNotEmpty &&
              visible.isEmpty &&
              !state.isLoading &&
              state.errorMessage == null)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('표시할 모임이 없어요.', style: GroupDesign.heading),
                  SizedBox(height: 8),
                  Text(
                    '보관한 모임은 아래 모임 관리에서 다시 표시할 수 있어요.',
                    style: GroupDesign.body,
                  ),
                ],
              ),
            ),
          Column(
            children: [
              if (admins.isNotEmpty)
                GroupListSection(
                  title: '관리 중인 모임',
                  topPadding: 20,
                  groups: admins,
                  onSelect: state.isLoading ? null : onSelect,
                ),
              if (members.isNotEmpty)
                GroupListSection(
                  title: '참여 중인 모임',
                  topPadding: admins.isEmpty ? 20 : 24,
                  groups: members,
                  onSelect: state.isLoading ? null : onSelect,
                ),
            ],
          ),
          if (state.groups.isNotEmpty)
            _ManageFooter(archivedCount: state.groups.length - visible.length),
        ],
      ),
    );
  }
}

class _ManageFooter extends StatelessWidget {
  const _ManageFooter({required this.archivedCount});
  final int archivedCount;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20),
    child: TextButton(
      onPressed: () => Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => const GroupListManagePage()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const GroupIcon('list_sort', size: 16),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              '모임 관리 · 보관한 모임 $archivedCount',
              style: GroupDesign.sub,
            ),
          ),
        ],
      ),
    ),
  );
}

/// 목록 조회 상태와 첫 모임 진입 선택지를 표시합니다.
class _ListStatus extends ConsumerWidget {
  const _ListStatus();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
            state.errorMessage == null) ...[
          const GroupEmptyState(),
          const SizedBox(height: 12),
        ],
        if (state.groups.isEmpty) const GroupEntryChoices(),
      ],
    );
  }
}
