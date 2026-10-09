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
  late DateTime _month = DateTime(_today.year, _today.month);
  late DateTime _selected = _today;

  String get _basePath => '/meetings/${widget.meetingId}/schedules';

  @override
  Widget build(BuildContext context) {
    // 목록은 지난 3개월 ~ 앞으로 1년, 캘린더는 보고 있는 달을 조회한다.
    final args = _calendar
        ? (
            meetingId: widget.meetingId,
            startDate: _month,
            endDate: DateTime(_month.year, _month.month + 1, 0),
          )
        : (
            meetingId: widget.meetingId,
            startDate: DateTime(_today.year, _today.month - 3),
            endDate: DateTime(_today.year, _today.month + 13, 0),
          );
    final schedules = ref.watch(scheduleListProvider(args));

    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              showAdd: ref.watch(scheduleAdminProvider),
              onAdd: () => context.push('$_basePath/new'),
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
                  ? _buildCalendar(schedules)
                  : schedules.when(
                      data: _buildList,
                      error: (_, _) => _Message(
                        '일정을 불러오지 못했어요',
                        onRetry: () => ref.invalidate(scheduleListProvider),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Schedule> schedules) {
    if (schedules.isEmpty) return const _Message('등록된 일정이 없어요');
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: schedules.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, i) => ScheduleCard(
        schedule: schedules[i],
        onTap: () => context.push('$_basePath/${schedules[i].id}'),
      ),
    );
  }

  /// 월을 바꾸면 선택 날짜도 그 달로 옮긴다. (이번 달이면 오늘, 아니면 1일)
  void _changeMonth(DateTime month) {
    setState(() {
      _month = month;
      _selected = DateUtils.isSameMonth(month, _today) ? _today : month;
    });
  }

  /// 달력은 항상 보여주고, 아래 일정 영역에서 로딩/오류/빈 날짜를 처리한다.
  Widget _buildCalendar(AsyncValue<List<Schedule>> state) {
    final schedules = state.value ?? const <Schedule>[];
    final marked = {
      for (final s in schedules) DateUtils.dateOnly(s.startAt.toLocal()),
    };
    final selectedDay = schedules
        .where((s) => DateUtils.isSameDay(s.startAt.toLocal(), _selected))
        .toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        ScheduleCalendar(
          month: _month,
          selected: _selected,
          markedDays: marked,
          onMonthChanged: _changeMonth,
          onSelected: (date) => setState(() => _selected = date),
        ),
        const SizedBox(height: 24),
        Text(
          '${_selected.month}월 ${_selected.day}일 ${_selected.weekdayKo}요일',
          style: MoaText.titleM,
        ),
        const SizedBox(height: 12),
        if (state.isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (state.hasError)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _Message(
              '일정을 불러오지 못했어요',
              onRetry: () => ref.invalidate(scheduleListProvider),
            ),
          )
        else if (selectedDay.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: _Message('선택한 날짜에 일정이 없어요'),
          )
        else
          for (final s in selectedDay)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ScheduleEventTile(
                schedule: s,
                onTap: () => context.push('$_basePath/${s.id}'),
              ),
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
            Expanded(child: _segment(label, value)),
        ],
      ),
    );
  }

  Widget _segment(String label, bool value) {
    final selected = calendar == value;
    return GestureDetector(
      onTap: () => onChanged(value),
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
