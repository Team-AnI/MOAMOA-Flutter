import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../schedule_format.dart';
import 'schedule_status_pill.dart';

/// 캘린더에서 선택한 날짜의 일정 한 줄
class ScheduleEventTile extends StatelessWidget {
  const ScheduleEventTile({super.key, required this.schedule, this.onTap});

  final Schedule schedule;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final start = schedule.startAt.toLocal();
    final end = schedule.endAt?.toLocal();
    final location = schedule.location;
    const radius = BorderRadius.all(Radius.circular(24));

    return Material(
      color: MoaColors.fill,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 14,
            children: [
              SizedBox(
                width: 48,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(start.hhmm, style: MoaText.bodyStrong),
                    if (end != null)
                      Text(
                        durationLabel(end.difference(start)),
                        style: MoaText.caption.copyWith(
                          color: MoaColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                width: 4,
                height: 44,
                decoration: const BoxDecoration(
                  color: MoaColors.accent,
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(schedule.title, style: MoaText.titleS),
                    if (location != null)
                      Text(
                        location,
                        style: MoaText.sub.copyWith(
                          color: MoaColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              ScheduleStatusPill(isPast: start.isBefore(DateTime.now())),
            ],
          ),
        ),
      ),
    );
  }
}
