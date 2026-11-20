import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/utils/moa_snack_bar.dart';
import '../../../../core/widgets/moa_app_bar.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_members_providers.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/presentation/viewmodels/group_members_state.dart';
import '../../../group/presentation/widgets/group_icon.dart';
import '../../../schedule/domain/entities/schedule.dart';
import '../../domain/usecases/create_settlement.dart';
import '../../domain/usecases/settlement_input_validation.dart';
import '../providers/settlement_providers.dart';
import '../settlement_account_input.dart';
import '../settlement_format.dart';
import '../viewmodels/settlement_action.dart';
import '../viewmodels/settlement_action_state.dart';
import '../widgets/settlement_schedule_picker.dart';
import '../widgets/settlement_text_field.dart';

class SettlementCreatePage extends ConsumerWidget {
  const SettlementCreatePage({super.key, required this.meetingId});
  final int meetingId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(
        showClose: true,
        onBack: () => context.canPop()
            ? context.pop()
            : context.go('/meetings/$meetingId/settlements'),
      ),
      body: switch (role) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError() => Center(
          child: TextButton(
            onPressed: () => ref.invalidate(groupMyRoleProvider(meetingId)),
            child: const Text('권한 정보를 불러오지 못했어요. 다시 시도'),
          ),
        ),
        AsyncData(:final value) when !value.canManageGroup => const Center(
          child: Text('관리자만 정산을 등록할 수 있어요.'),
        ),
        AsyncData() => _SettlementForm(meetingId: meetingId),
      },
    );
  }
}

class _SettlementForm extends ConsumerStatefulWidget {
  const _SettlementForm({required this.meetingId});
  final int meetingId;
  @override
  ConsumerState<_SettlementForm> createState() => _SettlementFormState();
}

class _SettlementFormState extends ConsumerState<_SettlementForm> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  SettlementAccountInput _account = const SettlementAccountInput();
  Set<int> _selected = {};
  Schedule? _schedule;
  DateTime? _dueAt;
  bool _postNotice = false;
  String get _scheduleTitle => _schedule?.title ?? '연결할 일정 선택 (선택)';
  String get _scheduleLabel => _schedule == null
      ? '일정 없이도 정산을 등록할 수 있어요'
      : '${shortDate(_schedule!.startAt)} · 이 일정과 연결돼요';
  String get _memberLabel => '${_selected.length}명 선택';
  String get _dueLabel => _dueAt == null ? '날짜 선택' : shortDate(_dueAt!);

  @override
  void dispose() {
    for (final controller in [_title, _amount]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onAction(SettlementActionState? previous, SettlementActionState next) {
    if (next.action != SettlementAction.create || next.isSubmitting) return;
    if (ModalRoute.of(context)?.isCurrent == false) return;
    if (next.failure case final failure?) {
      showMoaSnackBar(context, message: failure.userMessage);
    } else if (next.createdSettlementId case final id?) {
      context.go('/meetings/${widget.meetingId}/settlements/$id');
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (!_account.isValid) {
      _editAccount();
      return;
    }
    ref
        .read(settlementActionsProvider(widget.meetingId).notifier)
        .create(
          CreateSettlementParams(
            meetingId: widget.meetingId,
            scheduleId: _schedule?.id,
            title: _title.text,
            amount: _amount.text,
            memberIds: _selected.toList()..sort(),
            bankName: _account.bankName,
            accountNumber: _account.accountNumber,
            accountHolder: _account.accountHolder,
            dueAt: _dueAt,
            postNotice: _postNotice,
          ),
        );
  }

  Future<void> _pickSchedule() async {
    final selected = await showModalBottomSheet<Schedule>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SettlementSchedulePicker(meetingId: widget.meetingId),
    );
    if (!mounted || selected == null) return;
    setState(() {
      _schedule = selected;
      if (_title.text.trim().isEmpty) _title.text = '${selected.title} 정산';
    });
  }

  Future<void> _pickMembers() async {
    final selected = await showModalBottomSheet<Set<int>>(
      context: context,
      isScrollControlled: true,
      builder: (_) =>
          _MemberPicker(meetingId: widget.meetingId, selected: _selected),
    );
    if (mounted && selected != null) setState(() => _selected = selected);
  }

  Future<void> _editAccount() async {
    final account = await showModalBottomSheet<SettlementAccountInput>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AccountForm(initial: _account),
    );
    if (mounted && account != null) setState(() => _account = account);
  }

  Future<void> _pickDueAt() async {
    final now = DateTime.now();
    final value = await showDatePicker(
      context: context,
      initialDate: _dueAt ?? now,
      firstDate: DateTime(2020),
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (mounted && value != null) {
      setState(
        () => _dueAt = DateTime(value.year, value.month, value.day, 23, 59),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(settlementActionsProvider(widget.meetingId), _onAction);
    final role = ref.watch(groupMyRoleProvider(widget.meetingId));
    final members = ref.watch(groupMembersProvider(widget.meetingId));
    final submitting = ref
        .watch(settlementActionsProvider(widget.meetingId))
        .isSubmitting;
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                Text('정산 정보 등록', style: MoaText.titleXl),
                const SizedBox(height: 24),
                // 일정 카드와 선택 행은 Figma 등록 화면의 구조를 유지합니다.
                _FormRow(
                  label: _scheduleTitle,
                  subtitle: _scheduleLabel,
                  icon: 'settlement_calendar_check',
                  onTap: submitting ? null : _pickSchedule,
                ),
                if (_schedule != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: submitting
                          ? null
                          : () => setState(() => _schedule = null),
                      child: const Text('일정 연결 해제'),
                    ),
                  ),
                const SizedBox(height: 16),
                // API가 요구하는 정산명은 시안에 없어 동일 입력 스타일로 보완합니다.
                SettlementTextField(
                  controller: _title,
                  label: '정산 이름',
                  maxLength: 50,
                  validator: SettlementInputValidation.title,
                ),
                SettlementTextField(
                  controller: _amount,
                  label: '총 금액',
                  numeric: true,
                  validator: SettlementInputValidation.amount,
                ),
                Text('정산 대상', style: MoaText.subStrong),
                const SizedBox(height: 8),
                _FormRow(
                  label: _memberLabel,
                  icon: 'settlement_users_three',
                  onTap: submitting ? null : _pickMembers,
                ),
                const SizedBox(height: 12),
                Text('개인별 금액은 등록 후 정산 상세에서 확인해 주세요.', style: MoaText.sub),
                const SizedBox(height: 16),
                Text('받을 계좌', style: MoaText.subStrong),
                const SizedBox(height: 8),
                _FormRow(
                  label: _account.label,
                  onTap: submitting ? null : _editAccount,
                ),
                const SizedBox(height: 16),
                Text('납부 기한', style: MoaText.subStrong),
                const SizedBox(height: 8),
                _FormRow(
                  label: _dueLabel,
                  trailingIcon: 'settlement_calendar_blank',
                  onTap: submitting ? null : _pickDueAt,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  value: _postNotice,
                  onChanged: submitting
                      ? null
                      : (value) => setState(() => _postNotice = value ?? false),
                  title: const Text('공지에도 올리기'),
                  subtitle: const Text('공지 탭에 정산 안내가 같이 올라가요'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                FilledButton(
                  onPressed:
                      submitting ||
                          role.isLoading ||
                          role.hasError ||
                          members.hasFailed ||
                          members.hasInvalidMemberIds ||
                          !members.hasLoaded
                      ? null
                      : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: MoaColors.accent,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(submitting ? '등록 중…' : '정산 요청 보내기'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FormRow extends StatelessWidget {
  const _FormRow({
    required this.label,
    this.subtitle,
    this.icon,
    this.trailingIcon = 'settlement_caret_right',
    this.onTap,
  });
  final String label;
  final String? subtitle, icon;
  final String trailingIcon;
  double get _iconSize => icon == 'settlement_users_three' ? 18 : 20;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: MoaColors.fill,
    borderRadius: BorderRadius.circular(subtitle == null ? 16 : 24),
    child: ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: icon == null
          ? null
          : Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: MoaColors.page,
                borderRadius: BorderRadius.circular(13),
              ),
              alignment: Alignment.center,
              child: GroupIcon(icon!, size: _iconSize),
            ),
      title: Text(label, style: MoaText.body),
      subtitle: subtitle == null ? null : Text(subtitle!, style: MoaText.sub),
      trailing: GroupIcon(trailingIcon, size: 18),
    ),
  );
}

class _MemberPicker extends ConsumerStatefulWidget {
  const _MemberPicker({required this.meetingId, required this.selected});
  final int meetingId;
  final Set<int> selected;
  @override
  ConsumerState<_MemberPicker> createState() => _MemberPickerState();
}

class _MemberPickerState extends ConsumerState<_MemberPicker> {
  late final Set<int> _selected = {...widget.selected};
  @override
  Widget build(BuildContext context) {
    final members = ref.watch(groupMembersProvider(widget.meetingId));
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .65,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('정산 대상 선택', style: MoaText.titleM),
            ),
            Expanded(
              child: members.isLoading && !members.hasLoaded
                  ? const Center(child: CircularProgressIndicator())
                  : members.hasFailed || members.hasInvalidMemberIds
                  ? Center(
                      child: TextButton(
                        onPressed: () => ref
                            .read(
                              groupMembersProvider(widget.meetingId).notifier,
                            )
                            .refresh(),
                        child: const Text('구성원 목록을 불러오지 못했어요. 다시 시도'),
                      ),
                    )
                  : ListView(
                      children: [
                        if (members.members.isEmpty)
                          const ListTile(title: Text('구성원이 없어요.')),
                        for (final member in members.members)
                          CheckboxListTile(
                            value: _selected.contains(member.memberId),
                            onChanged: (value) => setState(() {
                              if (value == true) {
                                _selected.add(member.memberId);
                              } else {
                                _selected.remove(member.memberId);
                              }
                            }),
                            title: Text(member.userName ?? '이름 미설정'),
                          ),
                      ],
                    ),
            ),
            TextButton(
              onPressed: members.hasFailed || members.hasInvalidMemberIds
                  ? null
                  : () => Navigator.pop(context, _selected),
              child: const Text('선택 완료'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountForm extends StatefulWidget {
  const _AccountForm({required this.initial});
  final SettlementAccountInput initial;
  @override
  State<_AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<_AccountForm> {
  final _formKey = GlobalKey<FormState>();
  late final _bank = TextEditingController(text: widget.initial.bankName);
  late final _number = TextEditingController(
    text: widget.initial.accountNumber,
  );
  late final _holder = TextEditingController(
    text: widget.initial.accountHolder,
  );
  @override
  void dispose() {
    _bank.dispose();
    _number.dispose();
    _holder.dispose();
    super.dispose();
  }

  void _complete() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      SettlementAccountInput(
        bankName: _bank.text.trim(),
        accountNumber: _number.text.trim(),
        accountHolder: _holder.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      20,
      24,
      20,
      MediaQuery.viewInsetsOf(context).bottom + 16,
    ),
    child: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SettlementTextField(
                controller: _bank,
                label: '은행',
                maxLength: 20,
                validator: SettlementInputValidation.bankName,
              ),
              SettlementTextField(
                controller: _number,
                label: '계좌번호',
                maxLength: 30,
                validator: SettlementInputValidation.accountNumber,
              ),
              SettlementTextField(
                controller: _holder,
                label: '예금주',
                maxLength: 20,
                validator: SettlementInputValidation.accountHolder,
              ),
              TextButton(onPressed: _complete, child: const Text('입력 완료')),
            ],
          ),
        ),
      ),
    ),
  );
}
