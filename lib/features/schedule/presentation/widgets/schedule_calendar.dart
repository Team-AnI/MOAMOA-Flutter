import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 월 달력입니다. 일정이 있는 날에는 숫자 아래에 점을 표시합니다.
///
/// 값을 들고 있지 않고 받은 값으로만 그립니다.
/// - [month]: 보여줄 달. 상단 화살표를 누르면 [onMonthChanged] 가 호출됩니다.
/// - [selected]: 선택된 날짜. 날짜를 누르면 [onSelected] 가 호출됩니다.
/// - [markedDays]: 일정이 있는 날짜들(시각 제외)
///
/// 요일은 일요일부터 시작합니다.
class ScheduleCalendar extends StatelessWidget {
  const ScheduleCalendar({
    super.key,
    required this.month,
    required this.selected,
    required this.markedDays,
    required this.onMonthChanged,
    required this.onSelected,
  });

  final DateTime month;
  final DateTime selected;

  final Set<DateTime> markedDays;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    // month 가 1일이 아니어도 첫 요일이 틀어지지 않게 1일을 직접 만듭니다.
    final leading = DateTime(month.year, month.month).weekday % 7; // 일요일 시작
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    // 1일 앞의 빈 칸(null) + 1일~말일. 마지막 줄은 빈 칸으로 7칸을 채웁니다.
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
          _MonthHeader(month: month, onMonthChanged: onMonthChanged),
          const _WeekdayRow(),
          // 7칸씩 끊어서 한 주(한 줄)로 그립니다.
          for (var i = 0; i < cells.length; i += 7)
            Row(
              children: [
                for (final day in cells.sublist(i, i + 7))
                  Expanded(
                    child: day == null
                        ? const SizedBox(height: 44)
                        : _DayCell(
                            date: DateTime(month.year, month.month, day),
                            selected: selected,
                            marked: markedDays.contains(
                              DateTime(month.year, month.month, day),
                            ),
                            onTap: onSelected,
                          ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

/// 달력 상단의 이전 달 / 연월 / 다음 달입니다.
class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month, required this.onMonthChanged});

  final DateTime month;
  final ValueChanged<DateTime> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _MonthButton(
            'caret_left_calendar',
            () => onMonthChanged(DateTime(month.year, month.month - 1)),
            key: const Key('calendar-prev-month'),
          ),
          Text('${month.year}년 ${month.month}월', style: MoaText.titleM),
          _MonthButton(
            'caret_right_calendar',
            () => onMonthChanged(DateTime(month.year, month.month + 1)),
            key: const Key('calendar-next-month'),
          ),
        ],
      ),
    );
  }
}

/// 요일 줄(일 ~ 토)입니다.
class _WeekdayRow extends StatelessWidget {
  const _WeekdayRow();

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

/// 달력의 하루입니다. 일정이 있으면 숫자 아래에 점이 붙습니다.
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.selected,
    required this.marked,
    required this.onTap,
  });

  final DateTime date;
  final DateTime selected;
  final bool marked;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(date),
      child: SizedBox(
        height: 44,
        child: Column(
          spacing: 1,
          children: [
            _DayNumber(date: date, selected: selected),
            SizedBox(
              width: 5,
              height: 5,
              child: marked
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

/// 날짜 숫자입니다. 선택/오늘/지난 날짜에 따라 배경과 글자색이 달라집니다.
class _DayNumber extends StatelessWidget {
  const _DayNumber({required this.date, required this.selected});

  final DateTime date;
  final DateTime selected;

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    final isSelected = DateUtils.isSameDay(date, selected);
    final isToday = DateUtils.isSameDay(date, today);
    final isPast = date.isBefore(today);

    // 우선순위: 선택한 날 > 오늘 > 지난 날(흐리게) > 그 밖의 날
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

    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Text('${date.day}', style: textStyle),
    );
  }
}

/// 이전/다음 달 이동 버튼입니다. [icon] 은 assets/icons 의 파일 이름입니다.
class _MonthButton extends StatelessWidget {
  const _MonthButton(this.icon, this.onTap, {super.key});

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
