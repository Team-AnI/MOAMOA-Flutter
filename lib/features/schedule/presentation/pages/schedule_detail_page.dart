import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';

/// 일정 상세.
/// TODO: Figma 에 직접 생성한 일정의 상세 화면이 없어 기존 화면 스타일로 임시 구성했습니다.
class ScheduleDetailPage extends ConsumerWidget {
  const ScheduleDetailPage({
    super.key,
    required this.meetingId,
    required this.scheduleId,
  });

  final int meetingId;
  final int scheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(
      scheduleDetailProvider((meetingId: meetingId, scheduleId: scheduleId)),
    );

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: const MoaAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: schedule.when(
                data: (s) => _Body(s),
                error: (_, _) => Center(
                  child: Text(
                    '일정을 불러오지 못했어요',
                    style: MoaText.body.copyWith(color: MoaColors.textTertiary),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.schedule);

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    final start = schedule.startAt.toLocal();
    final end = schedule.endAt?.toLocal();
    final description = schedule.description;
    final location = schedule.location;
    final endLabel = end == null
        ? ''
        : DateUtils.isSameDay(start, end)
        ? ' ~ ${end.hhmm}'
        : ' ~ ${end.fieldLabel}';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(schedule.title, style: MoaText.titleXl),
          ),
          _InfoRow('clock_field', '${start.fieldLabel}$endLabel'),
          if (location.isNotEmpty) _InfoRow('map_pin_field', location),
          if (description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                description,
                style: MoaText.body.copyWith(color: MoaColors.textSecondary),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.text);

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        SvgPicture.asset('assets/icons/$icon.svg'),
        Expanded(child: Text(text, style: MoaText.body)),
      ],
    );
  }
}
