import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../schedule_format.dart';
import 'schedule_status_pill.dart';

/// 일정 목록의 카드 한 장
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.schedule, this.onTap});

  final Schedule schedule;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final start = schedule.startAt.toLocal();
    final isPast = start.isBefore(DateTime.now());
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
              _DateBadge(start),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      schedule.title,
                      style: MoaText.titleS.copyWith(
                        color: isPast
                            ? MoaColors.textSecondary
                            : MoaColors.textPrimary,
                      ),
                    ),
                    _Meta('clock', '${start.weekdayKo} ${start.hhmm}'),
                    if (location != null) _Meta('map_pin', location),
                  ],
                ),
              ),
              ScheduleStatusPill(isPast: isPast),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge(this.date);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: MoaColors.accentText);
    return Container(
      width: 60,
      height: 64,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: MoaColors.accentTint,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${date.month}월', style: MoaText.captionStrong.merge(style)),
          Text('${date.day}', style: MoaText.titleL.merge(style)),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta(this.icon, this.text);

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: [
        SvgPicture.asset('assets/icons/$icon.svg'),
        Flexible(
          child: Text(
            text,
            style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
