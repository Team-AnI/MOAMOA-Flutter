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

class SettlementCreatePage extends ConsumerStatefulWidget {
  const SettlementCreatePage({super.key, required this.meetingId});
  final int meetingId;

  @override
  ConsumerState<SettlementCreatePage> createState() =>
      _SettlementCreatePageState();
}

class _SettlementCreatePageState extends ConsumerState<SettlementCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _bank = TextEditingController();
  final _account = TextEditingController();
  final _holder = TextEditingController();
  final _selected = <int>{};
  DateTime? _dueAt;
  bool _postNotice = false;
  bool _submitting = false;

  @override
  void dispose() {
    for (final controller in [_title, _amount, _bank, _account, _holder]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selected.isEmpty || _dueAt == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('구성원과 납부 기한을 선택해 주세요.')));
      return;
    }
    final amount = int.parse(_amount.text.replaceAll(',', ''));
    if (amount < _selected.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('총 금액은 정산 대상 인원보다 적을 수 없어요.')),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      final id = await ref
          .read(settlementRepositoryProvider)
          .create(
            CreateSettlementInput(
              meetingId: widget.meetingId,
              title: _title.text.trim(),
              totalAmount: amount,
              memberIds: _selected.toList()..sort(),
              bankName: _bank.text.trim(),
              accountNumber: _account.text.trim(),
              accountHolder: _holder.text.trim(),
              dueAt: _dueAt!,
              postNotice: _postNotice,
            ),
          );
      if (!mounted) return;
      ref.invalidate(settlementListProvider(widget.meetingId));
      context.go('/meetings/${widget.meetingId}/settlements/$id');
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error is ApiException ? error.userMessage : '정산을 등록하지 못했어요.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(groupMyRoleProvider(widget.meetingId));
    final members = ref.watch(groupMembersProvider(widget.meetingId));
    final canManage = role.asData?.value.canManageGroup ?? false;
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: AppBar(
        title: const Text('정산 등록'),
        backgroundColor: MoaColors.page,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: !canManage
          ? Center(
              child: Text(role.isLoading ? '권한 확인 중…' : '관리자만 정산을 등록할 수 있어요.'),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                children: [
                  Text('새 정산 만들기', style: MoaText.titleXl),
                  const SizedBox(height: 26),
                  _field(_title, '정산 이름', '예: 11월 모임 회비'),
                  _field(_amount, '총 정산 금액', '원', number: true, amount: true),
                  Text('정산 대상', style: MoaText.titleS),
                  const SizedBox(height: 8),
                  if (members.isLoading && !members.hasLoaded)
                    const Center(child: CircularProgressIndicator())
                  else if (members.hasFailed)
                    TextButton(
                      onPressed: () => ref
                          .read(groupMembersProvider(widget.meetingId).notifier)
                          .refresh(),
                      child: const Text('구성원 목록을 불러오지 못했어요. 다시 시도'),
                    )
                  else if (members.hasInvalidMemberIds)
                    const Text('구성원 정보를 확인할 수 없어요.')
                  else
                    ...members.members.map(_memberTile),
                  if (_selected.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      '1인 예상 금액 ${won((int.tryParse(_amount.text.replaceAll(',', '')) ?? 0) ~/ _selected.length)}',
                      style: MoaText.titleS.copyWith(color: MoaColors.accent),
                    ),
                  ],
                  const SizedBox(height: 20),
                  _field(_bank, '은행', '은행명'),
                  _field(_account, '계좌번호', '계좌번호'),
                  _field(_holder, '예금주', '예금주'),
                  Text('납부 기한', style: MoaText.titleS),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(now.year, now.month, now.day),
                        lastDate: now.add(const Duration(days: 365)),
                        initialDate: _dueAt ?? now,
                      );
                      if (date != null) {
                        setState(
                          () => _dueAt = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            23,
                            59,
                          ),
                        );
                      }
                    },
                    child: Text(_dueAt == null ? '날짜 선택' : shortDate(_dueAt!)),
                  ),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: _postNotice,
                    onChanged: (value) =>
                        setState(() => _postNotice = value ?? false),
                    title: const Text('공지에도 등록하기'),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: canManage
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FilledButton(
                  onPressed:
                      _submitting ||
                          members.hasFailed ||
                          members.hasInvalidMemberIds
                      ? null
                      : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: MoaColors.textPrimary,
                    minimumSize: const Size.fromHeight(54),
                  ),
                  child: Text(_submitting ? '등록 중…' : '정산 등록하기'),
                ),
              ),
            )
          : null,
    );
  }

  Widget _memberTile(GroupMemberProfile member) => CheckboxListTile(
    value: _selected.contains(member.memberId),
    onChanged: (value) => setState(() {
      if (value ?? false) {
        _selected.add(member.memberId);
      } else {
        _selected.remove(member.memberId);
      }
    }),
    title: Text(
      member.userName?.trim().isNotEmpty == true ? member.userName! : '이름 미설정',
    ),
    controlAffinity: ListTileControlAffinity.leading,
    contentPadding: EdgeInsets.zero,
  );

  Widget _field(
    TextEditingController controller,
    String label,
    String hint, {
    bool number = false,
    bool amount = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      controller: controller,
      keyboardType: number ? TextInputType.number : TextInputType.text,
      onChanged: (_) {
        if (amount) setState(() {});
      },
      decoration: InputDecoration(labelText: label, hintText: hint),
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) return '$label을 입력해 주세요.';
        if (amount && (int.tryParse(text.replaceAll(',', '')) ?? 0) <= 0) {
          return '1원 이상의 금액을 입력해 주세요.';
        }
        return null;
      },
    ),
  );
}
