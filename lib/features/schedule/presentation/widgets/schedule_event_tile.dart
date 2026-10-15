import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../schedule_format.dart';
import 'schedule_status_pill.dart';

/// 캘린더에서 선택한 날짜의 일정 한 줄입니다. 시작 시각과 소요 시간, 세로 막대,
/// 제목/장소, 상태 라벨 순서로 보여주며 종료 일시가 없으면 소요 시간은 생략합니다.
/// [onTap] 은 줄을 눌렀을 때(상세로 이동) 호출됩니다.
class ScheduleEventTile extends StatelessWidget {
  const ScheduleEventTile({super.key, required this.schedule, this.onTap});

  final Schedule schedule;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final start = schedule.startAt.toLocal();
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
              _TimeColumn(start: start, end: schedule.endAt?.toLocal()),
              const _AccentBar(),
              Expanded(
                child: _EventTexts(
                  title: schedule.title,
                  location: schedule.location,
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

/// 시작 시각과 소요 시간입니다.
class _TimeColumn extends StatelessWidget {
  const _TimeColumn({required this.start, required this.end});

  final DateTime start;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    final end = this.end;
    return SizedBox(
      width: 48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(start.hhmm, style: MoaText.bodyStrong),
          if (end != null)
            Text(
              durationLabel(end.difference(start)),
              style: MoaText.caption.copyWith(color: MoaColors.textSecondary),
            ),
        ],
      ),
    );
  }
}

/// 시간과 제목 사이의 세로 막대입니다.
class _AccentBar extends StatelessWidget {
  const _AccentBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 44,
      decoration: const BoxDecoration(
        color: MoaColors.accent,
        borderRadius: BorderRadius.all(Radius.circular(9999)),
      ),
    );
  }
}

/// 제목과 장소입니다.
class _EventTexts extends StatelessWidget {
  const _EventTexts({required this.title, required this.location});

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(title, style: MoaText.titleS),
        if (location.isNotEmpty)
          Text(
            location,
            style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
          ),
      ],
    );
  }
}
