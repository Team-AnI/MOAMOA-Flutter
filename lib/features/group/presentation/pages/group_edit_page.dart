import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_providers.dart';
import '../viewmodels/group_state.dart';
import '../widgets/group_design.dart';
import '../widgets/group_field.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';
import '../widgets/group_primary_button.dart';

class GroupEditPage extends ConsumerWidget {
  const GroupEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(groupProvider);
    final current = state.currentGroup;
    if (current == null || !state.canManageCurrentGroup) {
      return GroupPageLayout(
        isBack: true,
        onClose: () => context.go('/groups'),
        child: const Text('모임 관리자 권한이 필요합니다.', style: GroupDesign.body),
      );
    }
    return _EditForm(key: ValueKey(current.group.id), initial: current);
  }
}

class _EditForm extends ConsumerStatefulWidget {
  const _EditForm({super.key, required this.initial});
  final CurrentGroup initial;

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  late final _name = TextEditingController(text: widget.initial.group.name);
  late final _description = TextEditingController(
    text: widget.initial.group.description ?? '',
  );
  final _form = GlobalKey<FormState>();
  bool get _changed =>
      _name.text.trim() != widget.initial.group.name ||
      _description.text != (widget.initial.group.description ?? '');

  bool get _canSave =>
      _changed &&
      _name.text.trim().isNotEmpty &&
      _name.text.trim().length <= 20;

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final saved = await ref
        .read(groupProvider.notifier)
        .update(name: _name.text, description: _description.text);
    if (!mounted || saved == null) return;
    context.go('/groups/home');
  }

  @override
  Widget build(BuildContext context) {
    final busy = ref.watch(groupProvider.select((state) => state.isBusy));
    final error = ref.watch(
      groupProvider.select((state) => state.errorMessage),
    );
    return PopScope(
      canPop: !busy,
      child: GroupPageLayout(
        isBack: true,
        onClose: busy ? null : () => context.go('/groups/settings'),
        bottom: GroupPrimaryButton(
          label: busy ? '저장 중…' : '저장',
          onPressed: busy || !_canSave ? null : _save,
        ),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const GroupPageTitle(
                title: '모임 정보 수정',
                subtitle: '모임 이름과 소개를 변경할 수 있어요.',
              ),
              GroupField(
                controller: _name,
                label: '모임 이름',
                hint: '모임 이름을 입력해주세요',
                requiredValue: true,
                maxLength: 20,
                enabled: !busy,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),
              GroupField(
                controller: _description,
                label: '모임 소개',
                hint: '모임을 소개해주세요',
                multiline: true,
                enabled: !busy,
                onChanged: (_) => setState(() {}),
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    error,
                    style: GroupDesign.body,
                    semanticsLabel: '저장 실패: $error',
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
