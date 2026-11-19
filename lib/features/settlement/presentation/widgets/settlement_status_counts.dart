import 'package:flutter/material.dart';

import '../../../../core/theme/moa_theme.dart';
import '../../domain/entities/settlement_summary.dart';

/// 목록의 대표 카드와 관리자 상세가 공유하는 납부 현황입니다.
class SettlementStatusCounts extends StatelessWidget {
  const SettlementStatusCounts({super.key, required this.summary});
  final SettlementSummary summary;
  List<({String count, String label})> get _counts => [
    (count: '${summary.paidCount}', label: '완납'),
    (count: '${summary.pendingCount}', label: '확인 대기'),
    (count: '${summary.unpaidCount}', label: '미납'),
  ];
  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (final count in _counts)
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: MoaColors.darkFill,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  count.count,
                  style: MoaText.titleS.copyWith(color: MoaColors.textInverse),
                ),
                const SizedBox(height: 2),
                Text(
                  count.label,
                  style: MoaText.caption.copyWith(
                    color: MoaColors.onDarkSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}
