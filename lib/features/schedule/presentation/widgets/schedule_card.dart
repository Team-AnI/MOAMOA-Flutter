import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../schedule_format.dart';
import 'schedule_status_pill.dart';

/// 일정 목록의 카드 한 장입니다. 왼쪽 날짜 배지, 가운데 제목/시간/장소, 오른쪽 상태 라벨로 구성됩니다.
///
/// - 시간은 `수 19:00` 처럼 요일과 시작 시각을 보여주고, 장소가 비어 있으면 그 줄은 없앱니다.
/// - 시작 일시가 지났으면 제목을 흐리게 하고 "지난 일정" 라벨을 붙입니다.
/// - 투표 중인 일정은 날짜 대신 "투표" 배지와 "투표 중" 라벨을 붙이고, 임시 시작 시각은 보여주지 않습니다.
/// - [onTap] 은 카드를 눌렀을 때(상세 또는 투표 화면으로 이동) 호출됩니다.
class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.schedule, this.onTap});

  final Schedule schedule;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final start = schedule.startAt.toLocal();
    // "지난 일정" 상태는 서버가 주지 않아 시작 일시가 지났는지로 판단합니다. 투표 중 일정은 시작 일시가 임시값이라 보지 않습니다.
    final isPast = !schedule.isVoting && start.isBefore(DateTime.now());
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
              _DateBadge(date: start, isVoting: schedule.isVoting),
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
                    if (!schedule.isVoting)
                      _Meta(
                        icon: 'clock',
                        text: '${start.weekdayKo} ${start.hhmm}',
                      ),
                    if (location.isNotEmpty)
                      _Meta(icon: 'map_pin', text: location),
                  ],
                ),
              ),
              ScheduleStatusPill(isPast: isPast, isVoting: schedule.isVoting),
            ],
          ),
        ),
      ),
    );
  }
}

/// 카드 왼쪽의 날짜 배지입니다. 위에 월(`10월`), 아래에 일(`11`)을 보여줍니다.
/// 투표 중([isVoting])이면 일 대신 "투표"를 보여줍니다.
class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date, required this.isVoting});

  final DateTime date;
  final bool isVoting;

  String get _dayLabel => isVoting ? '투표' : '${date.day}';

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
          Text(_dayLabel, style: MoaText.titleL.merge(style)),
        ],
      ),
    );
  }
}

/// 작은 아이콘과 한 줄 글자입니다. [icon] 은 assets/icons 의 파일 이름입니다.
class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.text});

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
