import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/widgets/moa_error_widget.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/widgets/group_icon.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_format.dart';
import '../widgets/settlement_bottom_tabs.dart';

class SettlementListPage extends ConsumerWidget {
  const SettlementListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    final list = ref.watch(settlementListProvider(meetingId));
    return Scaffold(
      backgroundColor: MoaColors.page,
      bottomNavigationBar: SettlementBottomTabs(meetingId: meetingId),
      body: SafeArea(
        child: switch (role) {
          AsyncLoading() => const Center(child: CircularProgressIndicator()),
          AsyncError() => MoaErrorWidget(
            message: '모임 권한을 확인하지 못했어요.',
            onAction: () => ref.invalidate(groupMyRoleProvider(meetingId)),
          ),
          AsyncData(:final value) => switch (list) {
            AsyncLoading() => const Center(child: CircularProgressIndicator()),
            AsyncError(:final error) => MoaErrorWidget(
              message: error is ApiException
                  ? error.userMessage
                  : '정산 목록을 불러오지 못했어요.',
              onAction: () => ref.invalidate(settlementListProvider(meetingId)),
            ),
            AsyncData(value: final settlements) => RefreshIndicator(
              onRefresh: () async =>
                  ref.refresh(settlementListProvider(meetingId).future),
              child: _Content(
                meetingId: meetingId,
                isAdmin: value.canManageGroup,
                settlements: settlements,
              ),
            ),
          },
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.meetingId,
    required this.isAdmin,
    required this.settlements,
  });

  final int meetingId;
  final bool isAdmin;
  final List<Settlement> settlements;

  @override
  Widget build(BuildContext context) {
    final active = settlements.where(
      (item) => item.status == SettlementStatus.inProgress,
    );
    final history = settlements.where(
      (item) => item.status != SettlementStatus.inProgress,
    );
    final myUnpaid = active.where(
      (item) => item.myPaymentStatus == PaymentStatus.unpaid,
    );
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        Text('회비', style: MoaText.titleXl),
        const SizedBox(height: 26),
        if (isAdmin) ...[
          if (active.isNotEmpty) ...[
            _AdminFeatureCard(meetingId: meetingId, settlement: active.first),
            const SizedBox(height: 20),
          ],
          Text('정산 관리', style: MoaText.titleM),
          const SizedBox(height: 10),
          _ActionCard(
            title: '새 정산 등록',
            subtitle: '구성원에게 정산 요청을 보내요',
            onTap: () => context.push('/meetings/$meetingId/settlements/new'),
          ),
          const SizedBox(height: 24),
        ] else if (myUnpaid.isNotEmpty) ...[
          _MemberFeatureCard(meetingId: meetingId, settlement: myUnpaid.first),
          const SizedBox(height: 28),
        ],
        Row(
          children: [
            Expanded(
              child: Text(
                isAdmin ? '진행 중인 정산' : '내 정산 기록',
                style: MoaText.titleM,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (settlements.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 26),
            child: Text('아직 정산 내역이 없어요.'),
          )
        else
          for (final settlement in isAdmin ? active : settlements)
            _SettlementRow(meetingId: meetingId, settlement: settlement),
        if (isAdmin && history.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text('완료된 정산', style: MoaText.titleM),
          const SizedBox(height: 12),
          for (final settlement in history)
            _SettlementRow(meetingId: meetingId, settlement: settlement),
        ],
      ],
    );
  }
}

class _AdminFeatureCard extends StatelessWidget {
  const _AdminFeatureCard({required this.meetingId, required this.settlement});
  final int meetingId;
  final Settlement settlement;

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
          '진행 중인 정산',
          style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          settlement.title,
          style: MoaText.titleL.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: () =>
              context.push('/meetings/$meetingId/settlements/${settlement.id}'),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: MoaColors.textPrimary,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('정산 현황 보기'),
        ),
      ],
    ),
  );
}

class _MemberFeatureCard extends StatelessWidget {
  const _MemberFeatureCard({required this.meetingId, required this.settlement});
  final int meetingId;
  final Settlement settlement;

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
          '내가 낼 회비',
          style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          won(settlement.myAmount ?? 0),
          style: MoaText.titleXl.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          '${settlement.title} · ${shortDate(settlement.dueAt)}까지',
          style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
        ),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: () =>
              context.push('/meetings/$meetingId/settlements/${settlement.id}'),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: MoaColors.textPrimary,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('납부하기'),
        ),
      ],
    ),
  );
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: MoaColors.fill,
    borderRadius: BorderRadius.circular(24),
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(14),
      leading: const Icon(Icons.add_circle_outline),
      title: Text(title, style: MoaText.titleS),
      subtitle: Text(subtitle, style: MoaText.sub),
      trailing: const Icon(Icons.chevron_right, size: 18),
    ),
  );
}

class _SettlementRow extends StatelessWidget {
  const _SettlementRow({required this.meetingId, required this.settlement});
  final int meetingId;
  final Settlement settlement;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: MoaColors.fill,
      borderRadius: BorderRadius.circular(24),
      child: ListTile(
        onTap: () =>
            context.push('/meetings/$meetingId/settlements/${settlement.id}'),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        leading: const Icon(Icons.receipt_long_outlined),
        title: Text(settlement.title, style: MoaText.titleS),
        subtitle: Text(
          '${won(settlement.myAmount ?? settlement.totalAmount)} · ${shortDate(settlement.dueAt)}까지',
          style: MoaText.sub,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              settlement.myPaymentStatus == null
                  ? settlementStatusLabel(settlement.status)
                  : paymentStatusLabel(settlement.myPaymentStatus),
              style: MoaText.captionStrong,
            ),
            const SizedBox(height: 3),
            const GroupIcon('chevron', size: 14),
          ],
        ),
      ),
    ),
  );
}
