import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/group_providers.dart';
import '../viewmodels/group_state.dart';

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

  Future<void> _select(String id) async {
    final selected = await ref.read(groupProvider.notifier).selectGroup(id);
    if (mounted && selected) context.go('/groups/home');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groupProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('내 모임')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.errorMessage != null && state.groups.isNotEmpty)
              Text(
                state.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            Expanded(
              child: _GroupListContent(
                state: state,
                onRetry: () => ref.read(groupProvider.notifier).loadGroups(),
                onSelect: _select,
              ),
            ),
            FilledButton(
              onPressed: state.isLoading
                  ? null
                  : () => context.push('/groups/create'),
              child: const Text('모임 만들기'),
            ),
            OutlinedButton(
              onPressed: state.isLoading
                  ? null
                  : () => context.push('/groups/join'),
              child: const Text('초대 코드로 가입하기'),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupListContent extends StatelessWidget {
  const _GroupListContent({
    required this.state,
    required this.onRetry,
    required this.onSelect,
  });
  final GroupState state;
  final VoidCallback onRetry;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.groups.isEmpty) {
      if (state.errorMessage != null) {
        return _LoadError(message: state.errorMessage!, onRetry: onRetry);
      }
      return const Center(
        child: Text(
          '아직 가입한 모임이 없어요.\n모임을 만들거나 초대 코드로 가입해보세요.',
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemCount: state.groups.length,
      itemBuilder: (context, index) {
        final current = state.groups[index];
        return ListTile(
          title: Text(current.group.name),
          subtitle: Text(current.group.description),
          trailing: Text(current.canViewInviteCode ? '관리자' : '구성원'),
          onTap: () => onSelect(current.group.id),
        );
      },
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        TextButton(onPressed: onRetry, child: const Text('다시 시도')),
      ],
    ),
  );
}
