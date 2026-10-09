import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 월 달력. 일정이 있는 날에는 점을 표시합니다.
class ScheduleCalendar extends StatelessWidget {
  const ScheduleCalendar({
    super.key,
    required this.month,
    required this.selected,
    required this.markedDays,
    required this.onMonthChanged,
    required this.onSelected,
  });

  /// 보여줄 달의 1일
  final DateTime month;
  final DateTime selected;

  /// 일정이 있는 날(시각을 뺀 날짜)
  final Set<DateTime> markedDays;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    // month 가 1일이 아니어도 첫 요일이 틀어지지 않게 1일을 직접 만든다.
    final leading = DateTime(month.year, month.month).weekday % 7; // 일요일 시작
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final cells = <int?>[
      ...List.filled(leading, null),
      for (var d = 1; d <= daysInMonth; d++) d,
    ];
    while (cells.length % 7 != 0) {
      cells.add(null);
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        spacing: 2,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MonthButton(
                  'caret_left_calendar',
                  () => onMonthChanged(DateTime(month.year, month.month - 1)),
                ),
                Text('${month.year}년 ${month.month}월', style: MoaText.titleM),
                _MonthButton(
                  'caret_right_calendar',
                  () => onMonthChanged(DateTime(month.year, month.month + 1)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              for (final w in ['일', '월', '화', '수', '목', '금', '토'])
                Expanded(
                  child: Text(
                    w,
                    textAlign: TextAlign.center,
                    style: MoaText.captionStrong.copyWith(
                      color: MoaColors.textTertiary,
                    ),
                  ),
                ),
            ],
          ),
          for (var i = 0; i < cells.length; i += 7)
            Row(
              children: [
                for (final day in cells.sublist(i, i + 7))
                  Expanded(child: _buildDay(day)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDay(int? day) {
    if (day == null) return const SizedBox(height: 44);
    final date = DateTime(month.year, month.month, day);
    final today = DateUtils.dateOnly(DateTime.now());
    final isSelected = DateUtils.isSameDay(date, selected);
    final isToday = DateUtils.isSameDay(date, today);
    final isPast = date.isBefore(today);

    final Color? background = isSelected
        ? MoaColors.accent
        : isToday
        ? MoaColors.raised
        : null;
    final textStyle =
        (isSelected || isToday ? MoaText.bodyStrong : MoaText.body).copyWith(
          color: isSelected
              ? MoaColors.textInverse
              : isToday
              ? MoaColors.accentText
              : isPast
              ? MoaColors.textTertiary
              : MoaColors.textPrimary,
        );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onSelected(date),
      child: SizedBox(
        height: 44,
        child: Column(
          spacing: 1,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Text('$day', style: textStyle),
            ),
            SizedBox(
              width: 5,
              height: 5,
              child: markedDays.contains(date)
                  ? const DecoratedBox(
                      decoration: BoxDecoration(
                        color: MoaColors.accent,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthButton extends StatelessWidget {
  const _MonthButton(this.icon, this.onTap);

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: MoaColors.raised,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset('assets/icons/$icon.svg'),
      ),
    );
  }
}
