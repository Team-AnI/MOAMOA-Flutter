import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 일정 상태 라벨(확정 / 지난 일정)
class ScheduleStatusPill extends StatelessWidget {
  const ScheduleStatusPill({super.key, required this.isPast});

  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: MoaColors.raised,
        borderRadius: BorderRadius.all(Radius.circular(9999)),
      ),
      child: Text(
        isPast ? '지난 일정' : '확정',
        style: MoaText.captionStrong.copyWith(color: MoaColors.textSecondary),
      ),
    );
  }
}
