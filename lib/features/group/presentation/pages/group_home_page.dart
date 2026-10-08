import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/group_providers.dart';

class GroupHomePage extends ConsumerStatefulWidget {
  const GroupHomePage({super.key});

  @override
  ConsumerState<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends ConsumerState<GroupHomePage> {
  bool _loadingCode = false;

  Future<void> _showCode() async {
    if (_loadingCode) return;
    final current = ref.read(groupProvider).currentGroup;
    if (current == null || !current.canViewInviteCode) return;
    setState(() => _loadingCode = true);
    try {
      final code = await ref.read(groupProvider.notifier).getInviteCode();
      if (code == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ref.read(groupProvider).errorMessage ?? '초대 코드를 불러오지 못했습니다.',
              ),
            ),
          );
        }
        return;
      }
      if (!mounted || ref.read(groupProvider).currentGroup != current) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('초대 코드'),
          content: SelectableText(code),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
          ],
        ),
      );
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('초대 코드를 불러오지 못했습니다. 다시 시도해주세요.')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingCode = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(
      groupProvider.select((state) => state.currentGroup),
    );
    return Scaffold(
      appBar: AppBar(title: Text(current?.group.name ?? '모임 홈')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (current != null) ...[
              Text(current.group.description),
              const SizedBox(height: 24),
              if (current.canViewInviteCode)
                FilledButton(
                  onPressed: _loadingCode ? null : _showCode,
                  child: Text(_loadingCode ? '불러오는 중…' : '초대 코드 확인'),
                ),
            ] else
              const Text('내 모임 목록에서 모임을 선택해주세요.'),
            OutlinedButton(
              onPressed: () => context.go('/groups'),
              child: const Text('내 모임 목록'),
            ),
          ],
        ),
      ),
    );
  }
}
