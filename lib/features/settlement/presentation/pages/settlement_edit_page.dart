import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../group/domain/entities/group_member_profile.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_members_providers.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/presentation/viewmodels/group_members_state.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_format.dart';

class SettlementEditPage extends ConsumerWidget {
  const SettlementEditPage({
    super.key,
    required this.meetingId,
    required this.settlementId,
  });

  final int meetingId;
  final int settlementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    final detail = ref.watch(
      settlementDetailProvider((meetingId, settlementId)),
    );
    final members = ref.watch(groupMembersProvider(meetingId));
    if (role.isLoading ||
        detail.isLoading ||
        (members.isLoading && !members.hasLoaded)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (role.asData?.value.canManageGroup != true) {
      return Scaffold(
        appBar: AppBar(title: const Text('정산 수정')),
        body: const Center(child: Text('관리자만 정산을 수정할 수 있어요.')),
      );
    }
    final value = detail.asData?.value;
    if (value == null || members.hasFailed || members.hasInvalidMemberIds) {
      return Scaffold(
        appBar: AppBar(title: const Text('정산 수정')),
        body: Center(
          child: TextButton(
            onPressed: () {
              ref.invalidate(
                settlementDetailProvider((meetingId, settlementId)),
              );
              ref.read(groupMembersProvider(meetingId).notifier).refresh();
            },
            child: const Text('정산 정보를 불러오지 못했어요. 다시 시도'),
          ),
        ),
      );
    }
    if (value.status != SettlementStatus.inProgress) {
      return Scaffold(
        appBar: AppBar(title: const Text('정산 수정')),
        body: const Center(child: Text('진행 중인 정산만 수정할 수 있어요.')),
      );
    }
    return _EditForm(
      meetingId: meetingId,
      settlement: value,
      members: members.members,
    );
  }
}

class _EditForm extends ConsumerStatefulWidget {
  const _EditForm({
    required this.meetingId,
    required this.settlement,
    required this.members,
  });
  final int meetingId;
  final SettlementDetail settlement;
  final List<GroupMemberProfile> members;

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _amount;
  late final TextEditingController _bank;
  late final TextEditingController _account;
  late final TextEditingController _holder;
  late final Set<int> _selected;
  late DateTime _dueAt;
  bool _unlinkSchedule = false;
  bool _busy = false;

  bool get _hasSubmission => widget.settlement.payments.any(
    (item) => item.submittedAt != null || item.status != PaymentStatus.unpaid,
  );

  @override
  void initState() {
    super.initState();
    final item = widget.settlement;
    _title = TextEditingController(text: item.title);
    _amount = TextEditingController(text: item.totalAmount.toString());
    _bank = TextEditingController(text: item.bankName);
    _account = TextEditingController(text: item.accountNumber);
    _holder = TextEditingController(text: item.accountHolder);
    _dueAt = item.dueAt;
    _selected = item.payments
        .map((payment) => payment.memberId)
        .whereType<int>()
        .toSet();
  }

  @override
  void dispose() {
    for (final controller in [_title, _amount, _bank, _account, _holder]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final item = widget.settlement;
    final amount = int.parse(_amount.text);
    final originalIds = item.payments
        .map((payment) => payment.memberId)
        .whereType<int>()
        .toSet();
    final changedMembers =
        !_selected.containsAll(originalIds) ||
        !originalIds.containsAll(_selected);
    if (changedMembers && _selected.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('정산 대상자를 선택해 주세요.')));
      return;
    }
    if ((changedMembers || amount != item.totalAmount) &&
        amount < _selected.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('총 금액은 정산 대상 인원보다 적을 수 없어요.')),
      );
      return;
    }
    final input = SettlementEditInput(
      title: _title.text.trim() == item.title ? null : _title.text.trim(),
      totalAmount: amount == item.totalAmount ? null : amount,
      memberIds: changedMembers ? (_selected.toList()..sort()) : null,
      bankName: _bank.text.trim() == item.bankName ? null : _bank.text.trim(),
      accountNumber: _account.text.trim() == item.accountNumber
          ? null
          : _account.text.trim(),
      accountHolder: _holder.text.trim() == item.accountHolder
          ? null
          : _holder.text.trim(),
      dueAt: _dueAt.isAtSameMomentAs(item.dueAt) ? null : _dueAt,
      unlinkSchedule: _unlinkSchedule,
    );
    if (input.title == null &&
        input.totalAmount == null &&
        input.memberIds == null &&
        input.bankName == null &&
        input.accountNumber == null &&
        input.accountHolder == null &&
        input.dueAt == null &&
        !input.unlinkSchedule) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('변경된 내용이 없어요.')));
      return;
    }
    setState(() => _busy = true);
    try {
      await ref
          .read(settlementRepositoryProvider)
          .updateSettlement(widget.meetingId, item.id, input);
      if (!mounted) return;
      ref.invalidate(settlementDetailProvider((widget.meetingId, item.id)));
      ref.invalidate(settlementListProvider(widget.meetingId));
      final messenger = ScaffoldMessenger.of(context);
      context.pop();
      messenger.showSnackBar(const SnackBar(content: Text('정산을 수정했어요.')));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error is ApiException ? error.userMessage : '정산을 수정하지 못했어요.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.settlement;
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: AppBar(
        title: const Text('정산 수정'),
        backgroundColor: MoaColors.page,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
          children: [
            Text('정산 정보 수정', style: MoaText.titleXl),
            const SizedBox(height: 16),
            _field(_title, '정산 이름'),
            if (_hasSubmission)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  '납부 제출 기록이 있어 금액과 대상 구성원을 바꿀 수 없어요. 변경이 필요하면 정산을 취소한 뒤 새로 등록해 주세요.',
                ),
              ),
            _field(_amount, '총 정산 금액', numeric: true, enabled: !_hasSubmission),
            Text('정산 대상', style: MoaText.titleS),
            for (final member in widget.members)
              CheckboxListTile(
                value: _selected.contains(member.memberId),
                onChanged: _hasSubmission
                    ? null
                    : (value) => setState(() {
                        if (value ?? false) {
                          _selected.add(member.memberId);
                        } else {
                          _selected.remove(member.memberId);
                        }
                      }),
                title: Text(member.userName ?? '이름 미설정'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            const SizedBox(height: 12),
            _field(_bank, '은행'),
            _field(_account, '계좌번호'),
            _field(_holder, '예금주'),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('납부 기한'),
              subtitle: Text(shortDate(_dueAt)),
              onTap: () async {
                final now = DateTime.now();
                final value = await showDatePicker(
                  context: context,
                  initialDate: _dueAt,
                  firstDate: DateTime(2020),
                  lastDate: now.add(const Duration(days: 3650)),
                );
                if (value != null) {
                  setState(
                    () => _dueAt = DateTime(
                      value.year,
                      value.month,
                      value.day,
                      23,
                      59,
                    ),
                  );
                }
              },
            ),
            if (item.scheduleId != null)
              CheckboxListTile(
                value: _unlinkSchedule,
                onChanged: (value) =>
                    setState(() => _unlinkSchedule = value ?? false),
                title: const Text('연결된 일정 해제'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
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
            child: Text(_busy ? '저장 중…' : '저장하기'),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool numeric = false,
    bool enabled = true,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (!enabled) return null;
        final text = value?.trim() ?? '';
        if (text.isEmpty) return '$label을 입력해 주세요.';
        if (numeric && (int.tryParse(text) ?? 0) < 1) return '1원 이상 입력해 주세요.';
        return null;
      },
    ),
  );
}
