import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../viewmodels/group_notifier.dart';

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
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  state.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.errorMessage != null && state.groups.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(state.errorMessage!),
                          TextButton(
                            onPressed: () =>
                                ref.read(groupProvider.notifier).loadGroups(),
                            child: const Text('다시 시도'),
                          ),
                        ],
                      ),
                    )
                  : state.groups.isEmpty
                  ? const Center(
                      child: Text(
                        '아직 가입한 모임이 없어요.\n모임을 만들거나 초대 코드로 가입해보세요.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.groups.length,
                      itemBuilder: (context, index) {
                        final current = state.groups[index];
                        return ListTile(
                          title: Text(current.group.name),
                          subtitle: Text(current.group.description),
                          trailing: Text(
                            current.canViewInviteCode ? '관리자' : '구성원',
                          ),
                          onTap: () async {
                            final selected = await ref
                                .read(groupProvider.notifier)
                                .selectGroup(current.group.id);
                            if (context.mounted && selected) {
                              context.go('/groups/home');
                            }
                          },
                        );
                      },
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
