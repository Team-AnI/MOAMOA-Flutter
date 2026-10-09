import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';
import '../widgets/schedule_calendar.dart';
import '../widgets/schedule_card.dart';
import '../widgets/schedule_event_tile.dart';

String _basePath(int meetingId) => '/meetings/$meetingId/schedules';

/// 일정 탭: 목록 / 캘린더
class ScheduleListPage extends ConsumerStatefulWidget {
  const ScheduleListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends ConsumerState<ScheduleListPage> {
  final _today = DateUtils.dateOnly(DateTime.now());
  bool _calendar = false;
  // 캘린더 탭의 상태. 목록 탭으로 갔다 와도 유지되도록 페이지가 들고 있는다.
  late DateTime _month = DateTime(_today.year, _today.month);
  late DateTime _selected = _today;

  /// 월을 바꾸면 선택 날짜도 그 달로 옮긴다. (이번 달이면 오늘, 아니면 1일)
  void _changeMonth(DateTime month) {
    setState(() {
      _month = month;
      _selected = DateUtils.isSameMonth(month, _today) ? _today : month;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              showAdd: ref.watch(scheduleAdminProvider),
              onAdd: () => context.push('${_basePath(widget.meetingId)}/new'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: _Segmented(
                calendar: _calendar,
                onChanged: (value) => setState(() => _calendar = value),
              ),
            ),
            Expanded(
              child: _calendar
                  ? _CalendarTab(
                      meetingId: widget.meetingId,
                      month: _month,
                      selected: _selected,
                      onMonthChanged: _changeMonth,
                      onSelected: (date) => setState(() => _selected = date),
                    )
                  : _ListTab(meetingId: widget.meetingId),
            ),
          ],
        ),
      ),
    );
  }
}

/// 목록 탭: 지난 3개월 ~ 앞으로 1년의 일정을 시작 일시 순으로 보여준다.
class _ListTab extends ConsumerWidget {
  const _ListTab({required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateUtils.dateOnly(DateTime.now());
    final schedules = ref.watch(
      scheduleListProvider((
        meetingId: meetingId,
        startDate: DateTime(today.year, today.month - 3),
        endDate: DateTime(today.year, today.month + 13, 0),
      )),
    );

    return schedules.when(
      data: (list) => list.isEmpty
          ? const _Message('등록된 일정이 없어요')
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, i) => ScheduleCard(
                schedule: list[i],
                onTap: () =>
                    context.push('${_basePath(meetingId)}/${list[i].id}'),
              ),
            ),
      error: (_, _) => _Message(
        '일정을 불러오지 못했어요',
        onRetry: () => ref.invalidate(scheduleListProvider),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

/// 캘린더 탭: 보고 있는 달의 일정을 조회하고, 선택한 날짜의 일정을 아래에 보여준다.
class _CalendarTab extends ConsumerWidget {
  const _CalendarTab({
    required this.meetingId,
    required this.month,
    required this.selected,
    required this.onMonthChanged,
    required this.onSelected,
  });

  final int meetingId;
  final DateTime month;
  final DateTime selected;
  final ValueChanged<DateTime> onMonthChanged;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      scheduleListProvider((
        meetingId: meetingId,
        startDate: month,
        endDate: DateTime(month.year, month.month + 1, 0),
      )),
    );
    final marked = {
      for (final s in state.value ?? const <Schedule>[])
        DateUtils.dateOnly(s.startAt.toLocal()),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        ScheduleCalendar(
          month: month,
          selected: selected,
          markedDays: marked,
          onMonthChanged: onMonthChanged,
          onSelected: onSelected,
        ),
        const SizedBox(height: 24),
        Text(
          '${selected.month}월 ${selected.day}일 ${selected.weekdayKo}요일',
          style: MoaText.titleM,
        ),
        const SizedBox(height: 12),
        _SelectedDaySchedules(
          meetingId: meetingId,
          state: state,
          selected: selected,
        ),
      ],
    );
  }
}

/// 선택한 날짜의 일정. 달력은 그대로 두고 이 영역에서 로딩/오류/빈 날짜를 처리한다.
class _SelectedDaySchedules extends ConsumerWidget {
  const _SelectedDaySchedules({
    required this.meetingId,
    required this.state,
    required this.selected,
  });

  final int meetingId;
  final AsyncValue<List<Schedule>> state;
  final DateTime selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const padding = EdgeInsets.symmetric(vertical: 20);
    if (state.isLoading) {
      return const Padding(
        padding: padding,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.hasError) {
      return Padding(
        padding: padding,
        child: _Message(
          '일정을 불러오지 못했어요',
          onRetry: () => ref.invalidate(scheduleListProvider),
        ),
      );
    }

    final events = (state.value ?? const <Schedule>[])
        .where((s) => DateUtils.isSameDay(s.startAt.toLocal(), selected))
        .toList();
    if (events.isEmpty) {
      return const Padding(
        padding: padding,
        child: _Message('선택한 날짜에 일정이 없어요'),
      );
    }
    return Column(
      spacing: 12,
      children: [
        for (final s in events)
          ScheduleEventTile(
            schedule: s,
            onTap: () => context.push('${_basePath(meetingId)}/${s.id}'),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.showAdd, required this.onAdd});

  final bool showAdd;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        children: [
          Expanded(child: Text('일정', style: MoaText.titleXl)),
          // 관리자에게만 보인다.
          if (showAdd)
            GestureDetector(
              key: const Key('schedule-add-button'),
              onTap: onAdd,
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: MoaColors.accent,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/icons/plus.svg'),
              ),
            ),
        ],
      ),
    );
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented({required this.calendar, required this.onChanged});

  final bool calendar;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.all(Radius.circular(9999)),
      ),
      child: Row(
        spacing: 4,
        children: [
          for (final (label, value) in [('목록', false), ('캘린더', true)])
            Expanded(
              child: _SegmentButton(
                label: label,
                selected: calendar == value,
                onTap: () => onChanged(value),
              ),
            ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? MoaColors.raised : null,
          borderRadius: const BorderRadius.all(Radius.circular(9999)),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: (selected ? MoaText.bodyStrong : MoaText.body).copyWith(
            color: selected ? MoaColors.textPrimary : MoaColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.text, {this.onRetry});

  final String text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: MoaText.body.copyWith(color: MoaColors.textTertiary),
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('다시 시도')),
        ],
      ),
    );
  }
}
