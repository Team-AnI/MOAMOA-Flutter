import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/utils/moa_snack_bar.dart';
import '../../../../core/widgets/moa_app_bar.dart';
import '../../../../core/widgets/moa_error_widget.dart';
import '../../../group/domain/entities/group_member_profile.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_members_providers.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/presentation/viewmodels/group_members_state.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/usecases/settlement_input_validation.dart';
import '../providers/settlement_providers.dart';
import '../settlement_detail_display.dart';
import '../settlement_edit_changes.dart';
import '../settlement_format.dart';
import '../viewmodels/settlement_action.dart';
import '../viewmodels/settlement_action_state.dart';
import '../widgets/settlement_text_field.dart';

class SettlementEditPage extends StatelessWidget {
  const SettlementEditPage({
    super.key,
    required this.meetingId,
    required this.settlementId,
  });
  final int meetingId, settlementId;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MoaColors.page,
    appBar: MoaAppBar(
      title: '정산 수정',
      onBack: () => context.canPop()
          ? context.pop()
          : context.go('/meetings/$meetingId/settlements'),
    ),
    body: _EditData(meetingId: meetingId, settlementId: settlementId),
  );
}

class _EditData extends ConsumerWidget {
  const _EditData({required this.meetingId, required this.settlementId});
  final int meetingId, settlementId;
  SettlementDetailRequest get _request =>
      SettlementDetailRequest(meetingId: meetingId, settlementId: settlementId);
  void _retry(WidgetRef ref) {
    ref.invalidate(settlementDetailProvider(_request));
    ref.read(groupMembersProvider(meetingId).notifier).refresh();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    if (role.isLoading) return const Center(child: CircularProgressIndicator());
    if (role.hasError) {
      return Center(
        child: TextButton(
          onPressed: () => ref.invalidate(groupMyRoleProvider(meetingId)),
          child: const Text('권한 정보를 불러오지 못했어요. 다시 시도'),
        ),
      );
    }
    if (role.asData?.value.canManageGroup != true) {
      return const Center(child: Text('관리자만 정산을 수정할 수 있어요.'));
    }
    final detail = ref.watch(settlementDetailProvider(_request));
    final members = ref.watch(groupMembersProvider(meetingId));
    if (detail.isLoading || (members.isLoading && !members.hasLoaded)) {
      return const Center(child: CircularProgressIndicator());
    }
    final value = detail.asData?.value;
    if (value == null ||
        detail.hasError ||
        members.hasFailed ||
        members.hasInvalidMemberIds) {
      return MoaErrorWidget(
        message: '정산 정보를 불러오지 못했어요.',
        actionLabel: '다시 시도',
        onAction: () => _retry(ref),
      );
    }
    if (!value.canEdit) {
      return const Center(child: Text('진행 중인 정산만 수정할 수 있어요.'));
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
  bool get _busy =>
      ref.read(settlementActionsProvider(widget.meetingId)).isSubmitting;

  bool get _hasSubmission => widget.settlement.hasSubmission;

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

  SettlementEditInput get _input => SettlementEditInput(
    title: _title.text.trim(),
    totalAmount: int.parse(_amount.text),
    memberIds: _selected.toList()..sort(),
    bankName: _bank.text.trim(),
    accountNumber: _account.text.trim(),
    accountHolder: _holder.text.trim(),
    dueAt: _dueAt,
    unlinkSchedule: _unlinkSchedule,
  );
  void _onAction(SettlementActionState? previous, SettlementActionState next) {
    if (next.action != SettlementAction.update ||
        next.settlementId != widget.settlement.id ||
        next.isSubmitting) {
      return;
    }
    if (ModalRoute.of(context)?.isCurrent == false) return;
    if (next.failure case final error?) {
      showMoaSnackBar(context, message: error.userMessage);
      return;
    }
    showMoaSnackBar(context, message: '정산을 수정했어요.');
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/meetings/${widget.meetingId}/settlements');
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final changes = _input.changesFrom(widget.settlement);
    if (changes.isEmpty) {
      showMoaSnackBar(context, message: '변경된 내용이 없어요.');
      return;
    }
    ref
        .read(settlementActionsProvider(widget.meetingId).notifier)
        .update(
          widget.settlement.id,
          changes,
          memberCount: widget.settlement.summary.totalCount,
        );
  }

  Future<void> _pickDueAt() async {
    final now = DateTime.now();
    final value = await showDatePicker(
      context: context,
      initialDate: _dueAt,
      firstDate: DateTime(2020),
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (!mounted || value == null) return;
    setState(
      () => _dueAt = DateTime(value.year, value.month, value.day, 23, 59),
    );
  }

  void _toggleMember(int id, bool? value) {
    setState(() {
      if (value == true) {
        _selected.add(id);
      } else {
        _selected.remove(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(settlementActionsProvider(widget.meetingId), _onAction);
    ref.watch(settlementActionsProvider(widget.meetingId));
    final item = widget.settlement;
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
              children: [
                Text('정산 정보 수정', style: MoaText.titleXl),
                const SizedBox(height: 16),
                SettlementTextField(
                  controller: _title,
                  label: '정산 이름',
                  validator: SettlementInputValidation.title,
                ),
                if (_hasSubmission)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text(
                      '납부 제출 기록이 있어 금액과 대상 구성원을 바꿀 수 없어요. 변경이 필요하면 정산을 취소한 뒤 새로 등록해 주세요.',
                    ),
                  ),
                SettlementTextField(
                  controller: _amount,
                  label: '총 정산 금액',
                  numeric: true,
                  enabled: !_hasSubmission,
                  validator: _hasSubmission
                      ? null
                      : SettlementInputValidation.amount,
                ),
                Text('정산 대상', style: MoaText.titleS),
                for (final member in widget.members)
                  CheckboxListTile(
                    value: _selected.contains(member.memberId),
                    onChanged: _hasSubmission || _busy
                        ? null
                        : (value) => _toggleMember(member.memberId, value),
                    title: Text(member.userName ?? '이름 미설정'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                const SizedBox(height: 12),
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
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('납부 기한'),
                  subtitle: Text(shortDate(_dueAt)),
                  onTap: _busy ? null : _pickDueAt,
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
        ),
        SafeArea(
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
      ],
    );
  }
}
