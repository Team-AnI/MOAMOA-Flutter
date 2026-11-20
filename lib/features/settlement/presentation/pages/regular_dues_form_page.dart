import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/utils/moa_dialogs.dart';
import '../../../../core/utils/moa_snack_bar.dart';
import '../../../../core/widgets/moa_app_bar.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/usecases/regular_due_validation.dart';
import '../../domain/usecases/settlement_input_validation.dart';
import '../providers/settlement_providers.dart';
import '../regular_due_changes.dart';
import '../settlement_format.dart';
import '../viewmodels/regular_due_action_state.dart';
import '../widgets/settlement_text_field.dart';

class RegularDuesFormPage extends ConsumerWidget {
  const RegularDuesFormPage({
    super.key,
    required this.meetingId,
    this.regularDuesId,
  });

  final int meetingId;
  final int? regularDuesId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    if (role.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (role.hasError) {
      return Scaffold(
        appBar: MoaAppBar(title: '정기 회비'),
        body: Center(
          child: TextButton(
            onPressed: () => ref.invalidate(groupMyRoleProvider(meetingId)),
            child: const Text('권한 정보를 불러오지 못했어요. 다시 시도'),
          ),
        ),
      );
    }
    if (role.asData?.value.canManageGroup != true) {
      return Scaffold(
        appBar: MoaAppBar(title: '정기 회비'),
        body: const Center(child: Text('관리자만 정기 회비를 설정할 수 있어요.')),
      );
    }
    if (regularDuesId == null) {
      return _Form(meetingId: meetingId);
    }
    final dues = ref.watch(regularDuesProvider(meetingId));
    return switch (dues) {
      AsyncLoading() => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      AsyncError() => Scaffold(
        appBar: MoaAppBar(title: '정기 회비 수정'),
        body: Center(
          child: TextButton(
            onPressed: () => ref.invalidate(regularDuesProvider(meetingId)),
            child: const Text('회비 정보를 불러오지 못했어요. 다시 시도'),
          ),
        ),
      ),
      AsyncData(value: final items) => _Form(
        meetingId: meetingId,
        initial: items.where((item) => item.id == regularDuesId).firstOrNull,
        missing: !items.any((item) => item.id == regularDuesId),
      ),
    };
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.meetingId, this.initial, this.missing = false});
  final int meetingId;
  final RegularDue? initial;
  final bool missing;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _amount;
  late final TextEditingController _dueDays;
  late final TextEditingController _bank;
  late final TextEditingController _account;
  late final TextEditingController _holder;
  late DuesCycle _cycle;
  late String _cycleDay;
  late TimeOfDay _sendTime;
  late bool _postNotice;
  late bool _isActive;
  bool _applyCurrent = false;
  bool get _busy =>
      ref.read(regularDueActionsProvider(widget.meetingId)).isSubmitting;

  @override
  void initState() {
    super.initState();
    final due = widget.initial;
    _title = TextEditingController(text: due?.title ?? '');
    _amount = TextEditingController(text: due?.amount.toString() ?? '');
    _dueDays = TextEditingController(text: due?.dueDays.toString() ?? '7');
    _bank = TextEditingController(text: due?.bankName ?? '');
    _account = TextEditingController(text: due?.accountNumber ?? '');
    _holder = TextEditingController(text: due?.accountHolder ?? '');
    _cycle = due?.cycle ?? DuesCycle.monthly;
    _cycleDay = due?.cycleDay ?? '10';
    final parts = (due?.sendTime ?? '09:00').split(':');
    _sendTime = TimeOfDay(
      hour: int.tryParse(parts.first) ?? 9,
      minute: int.tryParse(parts.last) ?? 0,
    );
    _postNotice = due?.postNotice ?? false;
    _isActive = due?.isActive ?? true;
  }

  @override
  void dispose() {
    for (final controller in [
      _title,
      _amount,
      _dueDays,
      _bank,
      _account,
      _holder,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String get _sendTimeLabel =>
      '${_sendTime.hour.toString().padLeft(2, '0')}:${_sendTime.minute.toString().padLeft(2, '0')}';

  RegularDueInput get _input => RegularDueInput(
    title: _title.text.trim(),
    amount: int.parse(_amount.text),
    cycle: _cycle,
    cycleDay: _cycleDay,
    sendTime: _sendTimeLabel,
    dueDays: int.parse(_dueDays.text),
    bankName: _bank.text.trim(),
    accountNumber: _account.text.trim(),
    accountHolder: _holder.text.trim(),
    postNotice: _postNotice,
    isActive: _isActive,
  );

  void _onAction(RegularDueActionState? previous, RegularDueActionState next) {
    if (next.isSubmitting || next.action == null) return;
    if (ModalRoute.of(context)?.isCurrent == false) return;
    if (next.failure case final error?) {
      showMoaSnackBar(context, message: error.userMessage);
      return;
    }
    showMoaSnackBar(context, message: next.message);
    _close();
  }

  void _close() => context.canPop()
      ? context.pop()
      : context.go('/meetings/${widget.meetingId}/settlements');
  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final input = _input;
    final original = widget.initial;
    final changes = original == null
        ? null
        : input.changesFrom(original, applyToCurrentSettlement: _applyCurrent);
    if (changes?.isEmpty == true) {
      showMoaSnackBar(context, message: '변경된 내용이 없어요.');
      return;
    }
    final actions = ref.read(
      regularDueActionsProvider(widget.meetingId).notifier,
    );
    if (original == null) {
      actions.create(input);
    } else {
      actions.update(original.id, changes!);
    }
  }

  Future<void> _delete() async {
    final original = widget.initial;
    if (original == null) return;
    final shouldDelete = await showMoaConfirmDialog(
      context,
      title: '정기 회비를 삭제할까요?',
      message: '이후 자동 청구는 중단됩니다. 이미 청구된 회차 정산은 바뀌지 않습니다.',
      confirmLabel: '삭제',
    );
    if (shouldDelete != true || !mounted) return;
    ref
        .read(regularDueActionsProvider(widget.meetingId).notifier)
        .delete(original.id);
  }

  Future<void> _pickSendTime() async {
    final value = await showTimePicker(
      context: context,
      initialTime: _sendTime,
    );
    if (!mounted || value == null) return;
    setState(() => _sendTime = value);
  }

  void _changeCycle(DuesCycle? value) {
    if (value == null || value == DuesCycle.unknown) return;
    setState(() {
      _cycle = value;
      _cycleDay = value == DuesCycle.monthly ? '10' : 'MON';
    });
  }

  void _changeDay(String? value) {
    if (value != null) setState(() => _cycleDay = value);
  }

  List<String> get _cycleDays {
    if (_cycle == DuesCycle.unknown) return [_cycleDay];
    final days = _cycle == DuesCycle.weekly
        ? <String>['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
        : <String>[...List.generate(28, (i) => '${i + 1}'), 'LAST'];
    // 알 수 없는 응답 값을 build에서 임의로 고치지 않고 선택값으로 보존합니다.
    if (!days.contains(_cycleDay)) days.insert(0, _cycleDay);
    return days;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(regularDueActionsProvider(widget.meetingId), _onAction);
    ref.watch(regularDueActionsProvider(widget.meetingId));
    if (widget.missing) {
      return Scaffold(
        appBar: MoaAppBar(title: '정기 회비'),
        body: const Center(child: Text('해당 정기 회비를 찾을 수 없어요.')),
      );
    }
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(title: '정기 회비', showClose: true, onBack: _close),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 36),
          children: [
            SettlementTextField(
              controller: _title,
              label: '이름',
              validator: RegularDueValidation.title,
            ),
            SettlementTextField(
              controller: _amount,
              label: '1인당 금액',
              numeric: true,
              validator: RegularDueValidation.amount,
            ),
            Text('반복', style: MoaText.subStrong),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<DuesCycle>(
                    isExpanded: true,
                    initialValue: _cycle,
                    decoration: _inputDecoration(),
                    items: [
                      if (_cycle == DuesCycle.unknown)
                        const DropdownMenuItem(
                          value: DuesCycle.unknown,
                          child: Text('주기 다시 선택'),
                        ),
                      const DropdownMenuItem(
                        value: DuesCycle.monthly,
                        child: Text('매월'),
                      ),
                      const DropdownMenuItem(
                        value: DuesCycle.weekly,
                        child: Text('매주'),
                      ),
                    ],
                    onChanged: _busy ? null : _changeCycle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    key: ValueKey(_cycle),
                    initialValue: _cycleDay,
                    decoration: _inputDecoration(),
                    items: _cycleDays
                        .map(
                          (day) => DropdownMenuItem(
                            value: day,
                            child: Text(_cycle.dayLabel(day)),
                          ),
                        )
                        .toList(),
                    onChanged: _busy || _cycle == DuesCycle.unknown
                        ? null
                        : _changeDay,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('발송 시간', style: MoaText.subStrong),
            const SizedBox(height: 8),
            Material(
              color: MoaColors.fill,
              borderRadius: BorderRadius.circular(18),
              child: ListTile(
                title: Text(_sendTimeLabel),
                trailing: const Icon(Icons.access_time),
                onTap: _busy ? null : _pickSendTime,
              ),
            ),
            const SizedBox(height: 18),
            Text('대상', style: MoaText.subStrong),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MoaColors.fill,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text('구성원 전체 · 새로 들어온 사람 포함', style: MoaText.body),
            ),
            const SizedBox(height: 18),
            SettlementTextField(
              controller: _dueDays,
              label: '납부 기한 (발송 후 일수)',
              numeric: true,
              validator: RegularDueValidation.dueDays,
            ),
            SettlementTextField(
              controller: _bank,
              label: '은행',
              validator: SettlementInputValidation.bankName,
            ),
            SettlementTextField(
              controller: _account,
              label: '계좌번호',
              validator: SettlementInputValidation.accountNumber,
            ),
            SettlementTextField(
              controller: _holder,
              label: '예금주',
              validator: SettlementInputValidation.accountHolder,
            ),
            SwitchListTile(
              value: _postNotice,
              onChanged: (value) => setState(() => _postNotice = value),
              title: const Text('요청할 때마다 공지에도 올리기'),
              subtitle: const Text('공지 탭에 이번 달 회비 안내가 올라가요'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            if (widget.initial != null) ...[
              SwitchListTile(
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
                title: const Text('자동 청구 사용'),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: _applyCurrent,
                onChanged: (value) =>
                    setState(() => _applyCurrent = value ?? false),
                title: const Text('이번 회차에도 변경 적용'),
                subtitle: const Text('이미 납부 제출한 구성원이 있으면 이번 회차에는 적용되지 않습니다.'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 18),
              OutlinedButton(
                onPressed: _busy ? null : _delete,
                child: const Text('정기 회비 삭제'),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FilledButton(
            onPressed: _busy ? null : _save,
            style: FilledButton.styleFrom(
              backgroundColor: MoaColors.textPrimary,
              minimumSize: const Size.fromHeight(54),
            ),
            child: Text(
              _busy
                  ? '저장 중…'
                  : widget.initial == null
                  ? '정기 회비 시작하기'
                  : '변경사항 저장',
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() => InputDecoration(
    filled: true,
    fillColor: MoaColors.fill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),
  );
}
