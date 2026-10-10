import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';

/// 일정 상세 화면입니다. 목록이나 캘린더에서 일정을 누르면 열립니다.
///
/// 위에서부터 뒤로가기 바, 제목, 일시, 장소, 설명 순서로 보여줍니다.
/// - [meetingId], [scheduleId]: 조회할 모임과 일정. 라우트(`…/schedules/:scheduleId`)에서 전달됩니다.
/// - 불러오는 중에는 로딩 표시, 실패하면 안내 문구를 보여줍니다.
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
      scheduleDetailProvider(
        ScheduleDetailRequest(meetingId: meetingId, scheduleId: scheduleId),
      ),
    );

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(),
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

/// 불러온 일정의 내용입니다. 길어질 수 있어서 스크롤됩니다.
///
/// - 일시: 시작 일시를 보여주고, 종료 일시가 있으면 뒤에 붙입니다.
///   같은 날이면 `~ 21:00` 처럼 시각만, 다른 날이면 날짜까지 붙입니다.
/// - 장소, 설명: 비어 있으면 그 줄을 그리지 않습니다.
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

/// 아이콘과 한 줄 글자입니다. [icon] 은 assets/icons 의 파일 이름(시계, 장소)입니다.
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
