import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/entities/member_role.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_field.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';
import '../widgets/group_primary_button.dart';

class GroupEditPage extends ConsumerWidget {
  const GroupEditPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(
      groupProvider.select((state) => state.currentGroup),
    );
    if (current == null || current.membership.role != MemberRole.admin) {
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
    final busy = ref.watch(
      groupProvider.select((state) => state.isSubmitting || state.isLoading),
    );
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
          onPressed: busy || !_changed || _name.text.trim().isEmpty
              ? null
              : _save,
        ),
        child: Form(
          key: _form,
          child: _EditFields(
            name: _name,
            description: _description,
            busy: busy,
            error: error,
            onChanged: (_) => setState(() {}),
          ),
        ),
      ),
    );
  }
}

class _EditFields extends StatelessWidget {
  const _EditFields({
    required this.name,
    required this.description,
    required this.busy,
    required this.error,
    required this.onChanged,
  });
  final TextEditingController name, description;
  final bool busy;
  final String? error;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const GroupPageTitle(
        title: '모임 정보 수정',
        subtitle: '모임 이름과 소개를 변경할 수 있어요.',
      ),
      GroupField(
        controller: name,
        label: '모임 이름',
        hint: '모임 이름을 입력해주세요',
        requiredValue: true,
        enabled: !busy,
        onChanged: onChanged,
      ),
      const SizedBox(height: 20),
      GroupField(
        controller: description,
        label: '모임 소개',
        hint: '모임을 소개해주세요',
        multiline: true,
        enabled: !busy,
        onChanged: onChanged,
      ),
      if (error != null)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            error!,
            style: GroupDesign.body,
            semanticsLabel: '저장 실패: $error',
          ),
        ),
      const SizedBox(height: 24),
    ],
  );
}
