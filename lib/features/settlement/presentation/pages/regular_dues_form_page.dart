import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_format.dart';
import '../regular_due_changes.dart';
import '../regular_due_application_message.dart';
import '../../domain/usecases/settlement_input_validation.dart';

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
        appBar: AppBar(title: const Text('정기 회비')),
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
        appBar: AppBar(title: const Text('정기 회비')),
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
        appBar: AppBar(title: const Text('정기 회비 수정')),
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

  RegularDueInput get _input => RegularDueInput(
    title: _title.text.trim(),
    amount: int.parse(_amount.text),
    cycle: _cycle,
    cycleDay: _cycleDay,
    sendTime:
        '${_sendTime.hour.toString().padLeft(2, '0')}:${_sendTime.minute.toString().padLeft(2, '0')}',
    dueDays: int.parse(_dueDays.text),
    bankName: _bank.text.trim(),
    accountNumber: _account.text.trim(),
    accountHolder: _holder.text.trim(),
    postNotice: _postNotice,
    isActive: _isActive,
  );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final input = _input;
    final original = widget.initial;
    final changes = original == null
        ? null
        : input.changesFrom(original, applyToCurrentSettlement: _applyCurrent);
    if (changes?.isEmpty == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('변경된 내용이 없어요.')));
      return;
    }
    try {
      final actions = ref.read(
        regularDueActionsProvider(widget.meetingId).notifier,
      );
      String message;
      if (original == null) {
        final result = await actions.create(input);
        if (result == null) return;
        message = '정기 회비를 저장했어요.';
      } else {
        final result = await actions.update(original.id, changes!);
        if (result == null) return;
        message = result.message;
      }
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      context.pop();
      messenger.showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error is ApiException ? error.userMessage : '정기 회비를 저장하지 못했어요.',
          ),
        ),
      );
    }
  }

  Future<void> _delete() async {
    final original = widget.initial;
    if (original == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('정기 회비를 삭제할까요?'),
        content: const Text('이후 자동 청구는 중단됩니다. 이미 청구된 회차 정산은 바뀌지 않습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      final deleted = await ref
          .read(regularDueActionsProvider(widget.meetingId).notifier)
          .delete(original.id);
      if (!mounted || deleted != true) return;
      context.pop();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error is ApiException ? error.userMessage : '정기 회비를 삭제하지 못했어요.',
          ),
        ),
      );
    }
  }

  List<String> get _cycleDays {
    final days = _cycle == DuesCycle.weekly
        ? <String>['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
        : <String>[...List.generate(28, (i) => '${i + 1}'), 'LAST'];
    // 알 수 없는 응답 값을 build에서 임의로 고치지 않고 선택값으로 보존합니다.
    if (!days.contains(_cycleDay)) days.insert(0, _cycleDay);
    return days;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(regularDueActionsProvider(widget.meetingId));
    if (widget.missing) {
      return Scaffold(
        appBar: AppBar(title: const Text('정기 회비')),
        body: const Center(child: Text('해당 정기 회비를 찾을 수 없어요.')),
      );
    }
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: AppBar(
        title: const Text('정기 회비'),
        backgroundColor: MoaColors.page,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 36),
          children: [
            _field(_title, '이름'),
            _field(_amount, '1인당 금액', numeric: true, max: 5000000),
            Text('반복', style: MoaText.subStrong),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<DuesCycle>(
                    isExpanded: true,
                    initialValue: _cycle,
                    decoration: _inputDecoration(),
                    items: const [
                      DropdownMenuItem(
                        value: DuesCycle.unknown,
                        child: Text('주기 다시 선택'),
                      ),
                      DropdownMenuItem(
                        value: DuesCycle.monthly,
                        child: Text('매월'),
                      ),
                      DropdownMenuItem(
                        value: DuesCycle.weekly,
                        child: Text('매주'),
                      ),
                    ],
                    onChanged: (value) => setState(() {
                      _cycle = value ?? DuesCycle.monthly;
                      _cycleDay = _cycle == DuesCycle.monthly ? '10' : 'MON';
                    }),
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
                            child: Text(
                              regularDuesCycleLabel(_cycle, day).replaceFirst(
                                _cycle == DuesCycle.weekly ? '매주 ' : '매월 ',
                                '',
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _cycleDay = value ?? _cycleDays.first),
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
                title: Text(_sendTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final value = await showTimePicker(
                    context: context,
                    initialTime: _sendTime,
                  );
                  if (!mounted) return;
                  if (value != null) setState(() => _sendTime = value);
                },
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
            _field(_dueDays, '납부 기한 (발송 후 일수)', numeric: true, min: 0),
            _field(_bank, '은행'),
            _field(_account, '계좌번호'),
            _field(_holder, '예금주'),
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

  Widget _field(
    TextEditingController controller,
    String label, {
    bool numeric = false,
    int min = 1,
    int? max,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: MoaText.subStrong),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: numeric ? TextInputType.number : TextInputType.text,
          decoration: _inputDecoration(),
          validator: (value) {
            final text = value?.trim() ?? '';
            if (text.isEmpty) return '$label을 입력해 주세요.';
            final maxLength = switch (label) {
              '이름' => 50,
              '은행' => 20,
              '계좌번호' => 30,
              '예금주' => 20,
              _ => null,
            };
            if (maxLength != null) {
              final error = SettlementInputValidation.text(
                text,
                label,
                maxLength,
              );
              if (error != null) return error;
            }
            if (numeric) {
              final number = int.tryParse(text);
              if (number == null ||
                  number < min ||
                  (max != null && number > max)) {
                return '$min~${max ?? '이상'} 범위로 입력해 주세요.';
              }
            }
            return null;
          },
        ),
      ],
    ),
  );

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
