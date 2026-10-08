import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/repositories/group_repository.dart';
import '../viewmodels/group_notifier.dart';

class GroupFormPage extends ConsumerStatefulWidget {
  const GroupFormPage({super.key, required this.isJoining});
  final bool isJoining;

  @override
  ConsumerState<GroupFormPage> createState() => _GroupFormPageState();
}

class _GroupFormPageState extends ConsumerState<GroupFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameOrCode = TextEditingController();
  final _description = TextEditingController();
  String? _error;
  bool _alreadyJoined = false;

  @override
  void dispose() {
    _nameOrCode.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _error = null;
      _alreadyJoined = false;
    });
    final notifier = ref.read(groupProvider.notifier);
    final result = widget.isJoining
        ? await notifier.join(_nameOrCode.text)
        : await notifier.create(
            name: _nameOrCode.text,
            description: _description.text,
          );
    if (!mounted) return;
    if (result != null) {
      context.go('/groups/home');
    } else {
      setState(() {
        final state = ref.read(groupProvider);
        _error = state.errorMessage;
        _alreadyJoined =
            state.failureReason == GroupFailureReason.alreadyJoined;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitting = ref.watch(
      groupProvider.select((state) => state.isSubmitting),
    );
    return Scaffold(
      appBar: AppBar(title: Text(widget.isJoining ? '모임 가입하기' : '모임 만들기')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _nameOrCode,
              enabled: !submitting,
              decoration: InputDecoration(
                labelText: widget.isJoining ? '초대 코드' : '모임명',
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? '필수 항목을 입력해주세요.'
                  : null,
            ),
            if (!widget.isJoining)
              TextFormField(
                controller: _description,
                enabled: !submitting,
                decoration: const InputDecoration(labelText: '모임 소개 (선택)'),
                minLines: 2,
                maxLines: 4,
              ),
            const SizedBox(height: 24),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            if (_alreadyJoined)
              TextButton(
                onPressed: () => context.go('/groups'),
                child: const Text('기존 모임 목록으로 이동'),
              ),
            FilledButton(
              onPressed: submitting ? null : _submit,
              child: Text(
                submitting
                    ? '처리 중…'
                    : widget.isJoining
                    ? '가입하기'
                    : '만들기',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
