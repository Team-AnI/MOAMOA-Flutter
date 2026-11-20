import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/profile_color.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/utils/moa_dialogs.dart';
import '../../../../core/utils/moa_snack_bar.dart';
import '../../../../core/widgets/moa_app_bar.dart';
import '../../../../core/widgets/moa_error_widget.dart';
import '../../../../core/widgets/moa_profile_avatar.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/presentation/widgets/group_icon.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_detail_display.dart';
import '../viewmodels/settlement_action_state.dart';
import '../widgets/settlement_status_counts.dart';

class SettlementDetailPage extends ConsumerWidget {
  const SettlementDetailPage({
    super.key,
    required this.meetingId,
    required this.settlementId,
  });
  final int meetingId, settlementId;

  void _onAction(BuildContext context, SettlementActionState next) {
    if (next.settlementId != settlementId || next.isSubmitting) return;
    if (ModalRoute.of(context)?.isCurrent == false) return;
    if (next.failure case final failure?) {
      showMoaSnackBar(context, message: failure.userMessage);
    }
  }

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    final shouldSubmit = await showMoaConfirmDialog(
      context,
      title: '납부 완료를 알릴까요?',
      message: '계좌 이체를 마친 뒤 제출해 주세요. 관리자가 입금 내역을 확인합니다.',
      confirmLabel: '제출',
    );
    if (shouldSubmit == true && context.mounted) {
      await ref
          .read(settlementActionsProvider(meetingId).notifier)
          .submit(settlementId);
    }
  }

  Future<void> _approve(
    BuildContext context,
    WidgetRef ref,
    SettlementPayment payment,
  ) async {
    final shouldApprove = await showMoaConfirmDialog(
      context,
      title: '입금을 확인했나요?',
      message: '${payment.displayName}님의 납부를 승인합니다.',
      confirmLabel: '승인',
    );
    if (shouldApprove == true && context.mounted) {
      await ref
          .read(settlementActionsProvider(meetingId).notifier)
          .approve(settlementId, payment.id);
    }
  }

  Future<void> _reject(
    BuildContext context,
    WidgetRef ref,
    SettlementPayment payment,
  ) async {
    // Controller는 다이얼로그 위젯이 소유하고, 확인한 문자열만 돌려줍니다.
    final reason = await showDialog<String>(
      context: context,
      builder: (_) => const _RejectionDialog(),
    );
    if (reason != null && context.mounted) {
      await ref
          .read(settlementActionsProvider(meetingId).notifier)
          .reject(settlementId, payment.id, reason: reason);
    }
  }

  Future<void> _copyAccount(BuildContext context, String account) async {
    await Clipboard.setData(ClipboardData(text: account));
    if (context.mounted) {
      showMoaSnackBar(context, message: '계좌번호를 복사했어요.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      settlementActionsProvider(meetingId),
      (_, next) => _onAction(context, next),
    );
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(
        onBack: () => context.canPop()
            ? context.pop()
            : context.go('/meetings/$meetingId/settlements'),
      ),
      bottomNavigationBar: _MemberSubmitBar(
        meetingId: meetingId,
        settlementId: settlementId,
        onSubmit: () => _submit(context, ref),
      ),
      body: _SettlementDetailContent(
        meetingId: meetingId,
        settlementId: settlementId,
        onApprove: (payment) => _approve(context, ref, payment),
        onReject: (payment) => _reject(context, ref, payment),
        onSubmit: () => _submit(context, ref),
        onCopy: (account) => _copyAccount(context, account),
      ),
    );
  }
}

class _SettlementDetailContent extends ConsumerWidget {
  const _SettlementDetailContent({
    required this.meetingId,
    required this.settlementId,
    required this.onApprove,
    required this.onReject,
    required this.onSubmit,
    required this.onCopy,
  });
  final int meetingId, settlementId;
  final ValueChanged<SettlementPayment> onApprove, onReject;
  final VoidCallback onSubmit;
  final ValueChanged<String> onCopy;
  SettlementDetailRequest get _request =>
      SettlementDetailRequest(meetingId: meetingId, settlementId: settlementId);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(settlementDetailProvider(_request));
    final role = ref.watch(groupMyRoleProvider(meetingId));
    final submitting = ref
        .watch(settlementActionsProvider(meetingId))
        .isSubmitting;
    return SafeArea(
      child: switch ((role, detail)) {
        (AsyncLoading(), _) => const Center(child: CircularProgressIndicator()),
        (AsyncError(), _) => MoaErrorWidget(
          message: '모임 권한을 확인하지 못했어요.',
          onAction: () => ref.invalidate(groupMyRoleProvider(meetingId)),
        ),
        (_, AsyncLoading()) => const Center(child: CircularProgressIndicator()),
        (_, AsyncError(:final error)) => MoaErrorWidget(
          message: error is ApiException
              ? error.userMessage
              : '정산 정보를 불러오지 못했어요.',
          onAction: () => ref.invalidate(settlementDetailProvider(_request)),
        ),
        (AsyncData(value: final currentRole), AsyncData(value: final data)) =>
          RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(settlementDetailProvider(_request).future),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 36),
              children: [
                _DetailHeader(data: data, isAdmin: currentRole.canManageGroup),
                const SizedBox(height: 22),
                _AmountCard(data: data, isAdmin: currentRole.canManageGroup),
                const SizedBox(height: 24),
                if (!currentRole.canManageGroup)
                  _AccountCard(
                    data: data,
                    onCopy: () => onCopy(data.accountNumber),
                  ),
                if (currentRole.canManageGroup) ...[
                  _PaymentGroup(
                    heading: data.pendingHeading,
                    payments: data.pendingPayments,
                    canManage: data.status == SettlementStatus.inProgress,
                    submitting: submitting,
                    onApprove: onApprove,
                    onReject: onReject,
                  ),
                  _PaymentGroup(
                    heading: data.unpaidHeading,
                    payments: data.unpaidPayments,
                  ),
                  _PaymentGroup(
                    heading: data.paidHeading,
                    payments: data.paidPayments,
                  ),
                  if (data.canSubmit) Text('내 납부', style: MoaText.titleM),
                ],
                if (data.canSubmit && currentRole.canManageGroup)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: FilledButton(
                      onPressed: submitting ? null : onSubmit,
                      style: FilledButton.styleFrom(
                        backgroundColor: MoaColors.accent,
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(submitting ? '제출 중…' : '납부했어요'),
                    ),
                  ),
              ],
            ),
          ),
      },
    );
  }
}

class _MemberSubmitBar extends ConsumerWidget {
  const _MemberSubmitBar({
    required this.meetingId,
    required this.settlementId,
    required this.onSubmit,
  });
  final int meetingId, settlementId;
  final VoidCallback onSubmit;
  bool _isAvailable(
    AsyncValue<MemberRole> role,
    AsyncValue<SettlementDetail> detail,
  ) =>
      !role.isLoading &&
      !role.hasError &&
      !detail.isLoading &&
      !detail.hasError &&
      role.asData?.value == MemberRole.member &&
      detail.asData?.value.canSubmit == true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    final detail = ref.watch(
      settlementDetailProvider(
        SettlementDetailRequest(
          meetingId: meetingId,
          settlementId: settlementId,
        ),
      ),
    );
    final busy = ref.watch(settlementActionsProvider(meetingId)).isSubmitting;
    if (!_isAvailable(role, detail)) return const SizedBox.shrink();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: FilledButton(
          onPressed: busy ? null : onSubmit,
          style: FilledButton.styleFrom(
            backgroundColor: MoaColors.accent,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(busy ? '제출 중…' : '납부했어요'),
        ),
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.data, required this.isAdmin});
  final SettlementDetail data;
  final bool isAdmin;
  String get _heading => isAdmin ? '정산 현황' : data.title;
  String get _badge => isAdmin ? data.heading : data.myStatusLabel;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: MoaColors.fill,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(_badge, style: MoaText.captionStrong),
      ),
      const SizedBox(height: 10),
      Text(_heading, style: MoaText.titleXl),
      const SizedBox(height: 10),
      Text(data.totalLabel, style: MoaText.sub),
    ],
  );
}

class _AmountCard extends StatelessWidget {
  const _AmountCard({required this.data, required this.isAdmin});
  final SettlementDetail data;
  final bool isAdmin;
  String get _amount => isAdmin ? data.paidLabel : data.myAmountLabel;
  String get _label => isAdmin ? '완납' : '내가 낼 금액';
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: MoaColors.accent,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _label,
          style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                _amount,
                style: MoaText.titleXl.copyWith(color: MoaColors.textInverse),
              ),
            ),
            if (isAdmin)
              Text(
                data.summary.paidPercentage,
                style: MoaText.titleXl.copyWith(color: MoaColors.textInverse),
              ),
          ],
        ),
        if (!isAdmin) ...[
          const SizedBox(height: 4),
          Text(
            data.splitLabel,
            style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
          ),
        ],
        if (isAdmin) ...[
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: data.summary.paidProgress,
            color: MoaColors.textInverse,
            backgroundColor: MoaColors.darkFill,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 14),
          SettlementStatusCounts(summary: data.summary),
        ],
      ],
    ),
  );
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.data, required this.onCopy});
  final SettlementDetail data;
  final VoidCallback onCopy;
  String get _holderLabel => '예금주 ${data.accountHolder}';
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('이 계좌로 보내 주세요', style: MoaText.titleM),
      const SizedBox(height: 12),
      Material(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
        child: ListTile(
          leading: const GroupIcon('settlement_bank', size: 20),
          title: Text(data.accountLabel, style: MoaText.bodyStrong),
          subtitle: Text(_holderLabel, style: MoaText.sub),
          trailing: TextButton(onPressed: onCopy, child: const Text('복사')),
        ),
      ),
    ],
  );
}

class _PaymentGroup extends StatelessWidget {
  const _PaymentGroup({
    required this.heading,
    required this.payments,
    this.canManage = false,
    this.submitting = false,
    this.onApprove,
    this.onReject,
  });
  final String heading;
  final List<SettlementPayment> payments;
  final bool canManage, submitting;
  final ValueChanged<SettlementPayment>? onApprove, onReject;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: MoaText.titleM),
        const SizedBox(height: 12),
        if (payments.isEmpty)
          Text('해당하는 구성원이 없어요.', style: MoaText.sub)
        else
          Material(
            color: MoaColors.fill,
            borderRadius: BorderRadius.circular(24),
            child: Column(
              children: [
                for (final payment in payments)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            MoaProfileAvatar(
                              userName: payment.userName,
                              color: ProfileColor.lightBlue,
                              size: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    payment.displayName,
                                    style: MoaText.bodyStrong,
                                  ),
                                  Text(
                                    payment.submittedLabel,
                                    style: MoaText.sub,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (canManage &&
                            payment.status == PaymentStatus.pending)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: submitting
                                      ? null
                                      : () => onReject?.call(payment),
                                  child: const Text('반려'),
                                ),
                                const SizedBox(width: 8),
                                FilledButton(
                                  onPressed: submitting
                                      ? null
                                      : () => onApprove?.call(payment),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: MoaColors.accent,
                                  ),
                                  child: const Text('입금 확인'),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

class _RejectionDialog extends StatefulWidget {
  const _RejectionDialog();
  @override
  State<_RejectionDialog> createState() => _RejectionDialogState();
}

class _RejectionDialogState extends State<_RejectionDialog> {
  final _reason = TextEditingController();
  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('납부 요청 반려'),
    scrollable: true,
    content: TextField(
      controller: _reason,
      maxLength: 255,
      decoration: const InputDecoration(hintText: '사유 (선택)'),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('취소'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, _reason.text),
        child: const Text('반려'),
      ),
    ],
  );
}
