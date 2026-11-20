import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/api_exception.dart';
import '../../../../core/theme/moa_theme.dart';
import '../../../../core/widgets/moa_app_bar.dart';
import '../../../../core/widgets/moa_error_widget.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../domain/entities/settlement.dart';
import '../providers/settlement_providers.dart';
import '../settlement_format.dart';

class SettlementHistoryPage extends ConsumerWidget {
  const SettlementHistoryPage({super.key, required this.meetingId});
  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(groupMyRoleProvider(meetingId));
    final list = ref.watch(settlementListProvider(meetingId));
    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(
        onBack: () => context.canPop()
            ? context.pop()
            : context.go('/meetings/$meetingId/settlements'),
      ),
      body: SafeArea(
        child: switch ((role, list)) {
          (AsyncLoading(), _) || (_, AsyncLoading()) => const Center(
            child: CircularProgressIndicator(),
          ),
          (AsyncError(), _) => MoaErrorWidget(
            message: '모임 권한을 확인하지 못했어요.',
            onAction: () => ref.invalidate(groupMyRoleProvider(meetingId)),
          ),
          (_, AsyncError(:final error)) => MoaErrorWidget(
            message: error is ApiException
                ? error.userMessage
                : '정산 내역을 불러오지 못했어요.',
            onAction: () => ref.invalidate(settlementListProvider(meetingId)),
          ),
          (
            AsyncData(value: final currentRole),
            AsyncData(value: final items),
          ) =>
            RefreshIndicator(
              onRefresh: () async =>
                  ref.refresh(settlementListProvider(meetingId).future),
              child: _HistoryContent(
                meetingId: meetingId,
                items: items,
                isAdmin: currentRole.canManageGroup,
              ),
            ),
        },
      ),
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({
    required this.meetingId,
    required this.items,
    required this.isAdmin,
  });
  final int meetingId;
  final List<Settlement> items;
  final bool isAdmin;

  List<Settlement> get _sorted =>
      [...items]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  Iterable<Settlement> get _thisYear => _sorted.where(
    (item) =>
        item.createdAt.toLocal().year == DateTime.now().year &&
        item.status != SettlementStatus.canceled,
  );
  int get _totalAmount => _thisYear.fold(
    0,
    (sum, item) => sum + (isAdmin ? item.totalAmount : (item.myAmount ?? 0)),
  );
  String get _thisYearLabel => '${_thisYear.length}건';
  String get _totalAmountLabel => won(_totalAmount);
  Map<String, List<Settlement>> get _groups {
    final result = <String, List<Settlement>>{};
    for (final item in _sorted) {
      final date = item.createdAt.toLocal();
      result.putIfAbsent('${date.year}년 ${date.month}월', () => []).add(item);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 36),
      children: [
        Text('정산 내역', style: MoaText.titleXl),
        const SizedBox(height: 6),
        Text('모임의 정산을 월별로 모아 봤어요.', style: MoaText.sub),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: MoaColors.fill,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Text(_thisYearLabel, style: MoaText.titleS),
                    const SizedBox(height: 4),
                    Text('올해 정산', style: MoaText.caption),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: MoaColors.fill,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Text(_totalAmountLabel, style: MoaText.titleS),
                    const SizedBox(height: 4),
                    Text(isAdmin ? '모든 금액' : '내 청구 금액', style: MoaText.caption),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        if (_groups.isEmpty) const Text('아직 정산 내역이 없어요.'),
        for (final entry in _groups.entries) ...[
          Text(entry.key, style: MoaText.titleS),
          const SizedBox(height: 10),
          Material(
            color: MoaColors.fill,
            borderRadius: BorderRadius.circular(24),
            child: Column(
              children: [
                for (final (index, item) in entry.value.indexed) ...[
                  if (index > 0)
                    const Divider(height: 1, indent: 18, endIndent: 18),
                  ListTile(
                    onTap: () => context.push(
                      '/meetings/$meetingId/settlements/${item.id}',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    title: Text(item.title, style: MoaText.titleS),
                    subtitle: Text(
                      '${shortDate(item.createdAt)} · ${item.memberCount}명',
                      style: MoaText.sub,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          won(
                            isAdmin ? item.totalAmount : (item.myAmount ?? 0),
                          ),
                          style: MoaText.captionStrong,
                        ),
                        Text(item.status.label, style: MoaText.caption),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}
