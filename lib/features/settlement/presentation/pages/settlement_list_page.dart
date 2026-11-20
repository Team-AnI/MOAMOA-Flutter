import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/widgets/moa_error_widget.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../../group/presentation/widgets/group_icon.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_list_display.dart';
import '../widgets/settlement_bottom_tabs.dart';
import '../widgets/settlement_status_counts.dart';

class SettlementListPage extends ConsumerWidget {
  const SettlementListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
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
          AsyncData(:final value) => _SettlementListContent(
            meetingId: meetingId,
            role: value,
          ),
        },
      ),
    );
  }
}

class _SettlementListContent extends ConsumerWidget {
  const _SettlementListContent({required this.meetingId, required this.role});
  final int meetingId;
  final MemberRole role;
  bool get _isAdmin => role.canManageGroup;
  String get _heading => _isAdmin ? '진행 중인 정산' : '내 정산 기록';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(settlementListProvider(meetingId));
    return switch (list) {
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
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          children: [
            Text('회비', style: MoaText.titleXl),
            const SizedBox(height: 26),
            if (_isAdmin) ...[
              if (settlements.featuredAdmin != null) ...[
                _AdminFeatureCard(
                  meetingId: meetingId,
                  settlement: settlements.featuredAdmin!,
                ),
                const SizedBox(height: 20),
              ],
              Text('정산 관리', style: MoaText.titleM),
              const SizedBox(height: 10),
              _ActionCard(
                title: '새 정산 등록',
                subtitle: '구성원에게 정산 요청을 보내요',
                onTap: () =>
                    context.push('/meetings/$meetingId/settlements/new'),
              ),
              const SizedBox(height: 24),
            ] else if (settlements.featuredMember != null) ...[
              _MemberFeatureCard(
                meetingId: meetingId,
                settlement: settlements.featuredMember!,
              ),
              const SizedBox(height: 28),
            ],
            Row(
              children: [
                Expanded(child: Text(_heading, style: MoaText.titleM)),
                TextButton(
                  onPressed: () =>
                      context.push('/meetings/$meetingId/settlements/history'),
                  child: const Text('전체'),
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
              for (final settlement
                  in (_isAdmin
                      ? settlements.activePreview
                      : settlements.recentPreview))
                _SettlementRow(meetingId: meetingId, settlement: settlement),
            if (_isAdmin && settlements.history.isNotEmpty) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Text('지난 정산', style: MoaText.titleM)),
                  TextButton(
                    onPressed: () => context.push(
                      '/meetings/$meetingId/settlements/history',
                    ),
                    child: const Text('전체'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (final settlement in settlements.historyPreview)
                _SettlementRow(meetingId: meetingId, settlement: settlement),
            ],
          ],
        ),
      ),
    };
  }
}

class _AdminFeatureCard extends ConsumerWidget {
  const _AdminFeatureCard({required this.meetingId, required this.settlement});
  final int meetingId;
  final Settlement settlement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref
        .watch(
          settlementDetailProvider(
            SettlementDetailRequest(
              meetingId: meetingId,
              settlementId: settlement.id,
            ),
          ),
        )
        .asData
        ?.value
        .summary;
    return Container(
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
            style: MoaText.titleL.copyWith(color: MoaColors.textInverse),
          ),
          if (summary != null) ...[
            const SizedBox(height: 18),
            SettlementStatusCounts(summary: summary),
          ],
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () => context.push(
              '/meetings/$meetingId/settlements/${settlement.id}',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: MoaColors.textInverse,
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
          settlement.memberAmountLabel,
          style: MoaText.titleXl.copyWith(color: MoaColors.textInverse),
        ),
        const SizedBox(height: 4),
        Text(
          settlement.dueSubtitle,
          style: MoaText.sub.copyWith(color: MoaColors.onDarkSecondary),
        ),
        const SizedBox(height: 18),
        FilledButton(
          onPressed: () =>
              context.push('/meetings/$meetingId/settlements/${settlement.id}'),
          style: FilledButton.styleFrom(
            backgroundColor: MoaColors.textInverse,
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
        subtitle: Text(settlement.rowSubtitle, style: MoaText.sub),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(settlement.statusLabel, style: MoaText.captionStrong),
            const SizedBox(height: 3),
            const GroupIcon('chevron', size: 14),
          ],
        ),
      ),
    ),
  );
}
