import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/widgets/moa_error_widget.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_format.dart';

class SettlementDetailPage extends ConsumerStatefulWidget {
  const SettlementDetailPage({
    super.key,
    required this.meetingId,
    required this.settlementId,
  });

  final int meetingId;
  final int settlementId;

  @override
  ConsumerState<SettlementDetailPage> createState() =>
      _SettlementDetailPageState();
}

class _SettlementDetailPageState extends ConsumerState<SettlementDetailPage> {
  bool _submitting = false;

  Future<void> _run(Future<void> Function() action) async {
    if (_submitting) return;
    setState(() => _submitting = true);
    try {
      await action();
      if (!mounted) return;
      ref.invalidate(
        settlementDetailProvider((widget.meetingId, widget.settlementId)),
      );
      ref.invalidate(settlementListProvider(widget.meetingId));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error is ApiException
                ? error.userMessage
                : '처리하지 못했어요. 다시 시도해 주세요.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(
      settlementDetailProvider((widget.meetingId, widget.settlementId)),
    );
    final role = ref.watch(groupMyRoleProvider(widget.meetingId));
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: AppBar(
        title: const Text('정산 상세'),
        backgroundColor: MoaColors.page,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop()
              ? context.pop()
              : context.go('/meetings/${widget.meetingId}/settlements'),
        ),
      ),
      body: SafeArea(
        child: switch (detail) {
          AsyncLoading() => const Center(child: CircularProgressIndicator()),
          AsyncError(:final error) => MoaErrorWidget(
            message: error is ApiException
                ? error.userMessage
                : '정산 정보를 불러오지 못했어요.',
            onAction: () => ref.invalidate(
              settlementDetailProvider((widget.meetingId, widget.settlementId)),
            ),
          ),
          AsyncData(value: final data) => RefreshIndicator(
            onRefresh: () async => ref.refresh(
              settlementDetailProvider((widget.meetingId, widget.settlementId))
                  .future,
            ),
            child: _content(data, role.asData?.value.canManageGroup ?? false),
          ),
        },
      ),
    );
  }

  Widget _content(SettlementDetail data, bool isAdmin) {
    final pending = data.payments.where(
      (payment) => payment.status == PaymentStatus.pending,
    );
    final unpaid = data.payments.where(
      (payment) => payment.status == PaymentStatus.unpaid,
    );
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
      children: [
        Text(data.title, style: MoaText.titleXl),
        const SizedBox(height: 6),
        Text(settlementStatusLabel(data.status), style: MoaText.sub),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: MoaColors.accent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAdmin ? '정산 현황' : '내가 낼 금액',
                style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
              ),
              const SizedBox(height: 8),
              Text(
                won(isAdmin ? data.totalAmount : (data.myPayment?.amount ?? 0)),
                style: MoaText.titleXl.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 6),
              Text(
                isAdmin
                    ? '${data.summary.paidCount}/${data.summary.totalCount}명 납부 완료'
                    : '${paymentStatusLabel(data.myPayment?.status)} · ${shortDate(data.dueAt)}까지',
                style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: MoaColors.fill,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('입금 계좌', style: MoaText.titleS),
              const SizedBox(height: 8),
              Text(
                '${data.bankName} ${data.accountNumber}',
                style: MoaText.sub,
              ),
              Text('예금주 ${data.accountHolder}', style: MoaText.sub),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: data.accountNumber),
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('계좌번호를 복사했어요.')),
                    );
                  }
                },
                icon: const Icon(Icons.copy_outlined, size: 18),
                label: const Text('계좌번호 복사'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        if (isAdmin) ...[
          Text('확인 대기 ${pending.length}명', style: MoaText.titleM),
          const SizedBox(height: 10),
          for (final payment in pending) _paymentTile(payment, data),
          if (pending.isEmpty) const Text('확인 대기 중인 구성원이 없어요.'),
          const SizedBox(height: 22),
          Text('미납 ${unpaid.length}명', style: MoaText.titleM),
          const SizedBox(height: 10),
          for (final payment in unpaid) _paymentTile(payment, data),
          if (unpaid.isEmpty) const Text('미납 구성원이 없어요.'),
          const SizedBox(height: 22),
          Text('완납 ${data.summary.paidCount}명', style: MoaText.titleM),
          for (final payment in data.payments.where(
            (item) => item.status == PaymentStatus.paid,
          ))
            _paymentTile(payment, data),
        ] else if (data.status == SettlementStatus.inProgress &&
            data.myPayment?.status == PaymentStatus.unpaid) ...[
          FilledButton(
            onPressed: _submitting
                ? null
                : () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('납부 완료를 알릴까요?'),
                        content: const Text(
                          '계좌 이체를 마친 뒤 제출해 주세요. 관리자가 입금 내역을 확인합니다.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('취소'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('제출'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await _run(() async {
                        await ref
                            .read(settlementRepositoryProvider)
                            .submitPayment(
                              widget.meetingId,
                              widget.settlementId,
                            );
                      });
                    }
                  },
            style: FilledButton.styleFrom(
              backgroundColor: MoaColors.textPrimary,
              minimumSize: const Size.fromHeight(54),
            ),
            child: Text(_submitting ? '제출 중…' : '납부했어요'),
          ),
        ],
      ],
    );
  }

  Widget _paymentTile(
    SettlementPayment payment,
    SettlementDetail data,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: MoaColors.fill,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(payment.userName ?? '구성원', style: MoaText.titleS),
            Text(
              '${won(payment.amount)} · ${paymentStatusLabel(payment.status)}',
              style: MoaText.sub,
            ),
            if (payment.status == PaymentStatus.pending &&
                data.status == SettlementStatus.inProgress) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: _submitting ? null : () => _reject(payment),
                    child: const Text('반려'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _submitting ? null : () => _approve(payment),
                    style: FilledButton.styleFrom(
                      backgroundColor: MoaColors.textPrimary,
                    ),
                    child: const Text('입금 확인'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ),
  );

  Future<void> _approve(SettlementPayment payment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('입금을 확인했나요?'),
        content: Text('${payment.userName ?? '구성원'}님의 납부를 승인합니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('승인'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _run(() async {
        await ref
            .read(settlementRepositoryProvider)
            .approvePayment(widget.meetingId, widget.settlementId, payment.id);
      });
    }
  }

  Future<void> _reject(SettlementPayment payment) async {
    final reason = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('납부 요청 반려'),
        content: TextField(
          controller: reason,
          maxLength: 255,
          decoration: const InputDecoration(hintText: '사유 (선택)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('반려'),
          ),
        ],
      ),
    );
    final text = reason.text.trim();
    reason.dispose();
    if (confirmed == true) {
      await _run(() async {
        await ref
            .read(settlementRepositoryProvider)
            .rejectPayment(
              widget.meetingId,
              widget.settlementId,
              payment.id,
              reason: text.isEmpty ? null : text,
            );
      });
    }
  }
}
