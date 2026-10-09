import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/group_providers.dart';
import '../widgets/group_code_card.dart';
import '../widgets/group_design.dart';
import '../widgets/group_icon.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';
import '../widgets/group_primary_button.dart';
import '../widgets/group_created_actions.dart';
import '../widgets/group_created_title.dart';

class GroupInvitePage extends ConsumerStatefulWidget {
  const GroupInvitePage({super.key, this.created = false});
  final bool created;
  @override
  ConsumerState<GroupInvitePage> createState() => _GroupInvitePageState();
}

class _GroupInvitePageState extends ConsumerState<GroupInvitePage> {
  String? _code;
  String? _error;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    Future.microtask(_load);
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final code = await ref.read(groupProvider.notifier).getInviteCode();
    if (!mounted) return;
    setState(() {
      _code = code;
      _loading = false;
      _error = code == null
          ? ref.read(groupProvider).errorMessage ?? '초대 코드를 불러오지 못했습니다.'
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = ref.watch(
      groupProvider.select((state) => state.currentGroup),
    );
    final allowed = current?.canViewInviteCode ?? false;
    return GroupPageLayout(
      isBack: !widget.created,
      onClose: () => context.go(widget.created ? '/groups' : '/groups/home'),
      bottom: widget.created
          ? GroupPrimaryButton(
              label: '모임 홈으로',
              onPressed: () => context.go('/groups/home'),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.created) ...[
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: GroupDesign.tint,
                  borderRadius: BorderRadius.circular(36),
                ),
                child: const GroupIcon('check', size: 34),
              ),
            ),
            const SizedBox(height: 10),
          ],
          GroupPageTitle(
            title: widget.created
                ? groupCreatedTitle(current?.group.name ?? '모임')
                : '구성원 초대',
            subtitle: '구성원에게 초대 코드를 보내면 바로 함께할 수 있어요.',
          ),
          if (!allowed)
            const Text('관리자만 초대 코드를 확인할 수 있습니다.', style: GroupDesign.body)
          else if (_loading)
            const Center(
              child: CircularProgressIndicator(color: GroupDesign.ink),
            )
          else if (_code != null)
            GroupCodeCard(code: _code!)
          else ...[
            Text(_error!, style: GroupDesign.body),
            TextButton(onPressed: _load, child: const Text('다시 시도')),
          ],
          if (widget.created && allowed) ...[
            const SizedBox(height: 16),
            const GroupCreatedActions(),
          ],
        ],
      ),
    );
  }
}
