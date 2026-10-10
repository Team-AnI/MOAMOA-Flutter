import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';
import '../widgets/schedule_calendar.dart';
import '../widgets/schedule_card.dart';
import '../widgets/schedule_event_tile.dart';

/// 일정 화면들의 라우트 기본 경로입니다. 예: `/meetings/1/schedules`
/// (일정 만들기는 `…/new`, 상세는 `…/{일정 id}` 로 이어집니다.)
String _basePath(int meetingId) => '/meetings/$meetingId/schedules';

/// 캘린더 탭이 조회하는 기간입니다. [month] 달의 1일 ~ 말일
ScheduleListRequest _monthRequest(int meetingId, DateTime month) =>
    ScheduleListRequest(
      meetingId: meetingId,
      startDate: month,
      endDate: DateTime(month.year, month.month + 1, 0),
    );

/// 일정 탭 화면. 위에서부터 다음 순서로 구성됩니다.
///
/// 1. 헤더: 제목 "일정"과 일정 만들기 `+` 버튼(관리자에게만 보임)
/// 2. 목록 / 캘린더 전환 토글
/// 3. 선택한 탭의 내용([_ListTab] 또는 [_CalendarTab])
///
/// - [meetingId]: 일정을 볼 모임. 라우트(`/meetings/:meetingId/schedules`)에서 전달됩니다.
/// - 토글 상태는 이 화면 안에서만 쓰여서 State 가 직접 들고 있습니다.
/// - 캘린더의 월/선택 날짜는 [ScheduleCalendarViewModel] 이 들고 있어서 토글을 오가도 유지됩니다.
class ScheduleListPage extends ConsumerStatefulWidget {
  const ScheduleListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends ConsumerState<ScheduleListPage> {
  bool _calendar = false;

  @override
  Widget build(BuildContext context) {
    // 목록 탭으로 가서 캘린더 탭이 사라져도 보던 달/선택 날짜가 남도록 구독을 유지합니다.
    ref.listen(scheduleCalendarProvider, (_, _) {});

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
                  ? _CalendarTab(meetingId: widget.meetingId)
                  : _ListTab(meetingId: widget.meetingId),
            ),
          ],
        ),
      ),
    );
  }
}

/// 목록 탭: 지난 3개월 ~ 앞으로 1년의 일정을 시작 일시 순으로 카드로 보여줍니다.
///
/// 불러오는 중에는 로딩 표시, 실패하면 "다시 시도" 버튼이 있는 안내, 일정이 없으면 빈 안내를 보여줍니다.
/// 카드를 누르면 일정 상세 화면으로 이동합니다.
class _ListTab extends ConsumerWidget {
  const _ListTab({required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateUtils.dateOnly(DateTime.now());
    final schedules = ref.watch(
      scheduleListProvider(
        ScheduleListRequest(
          meetingId: meetingId,
          startDate: DateTime(today.year, today.month - 3),
          endDate: DateTime(today.year, today.month + 13, 0),
        ),
      ),
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

/// 캘린더 탭: 보고 있는 달의 일정을 조회해서 달력에 점으로 표시하고,
/// 선택한 날짜의 일정을 아래에 보여줍니다.
///
/// 보고 있는 달과 선택 날짜는 [scheduleCalendarProvider] 에서 읽고, 월 이동/날짜 선택은
/// 그 ViewModel 의 메서드로 바꿉니다. 이 위젯은 값을 들고 있지 않습니다.
class _CalendarTab extends ConsumerWidget {
  const _CalendarTab({required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendar = ref.watch(scheduleCalendarProvider);
    final viewModel = ref.read(scheduleCalendarProvider.notifier);
    final schedules = ref.watch(
      scheduleListProvider(_monthRequest(meetingId, calendar.month)),
    );
    final marked = {
      for (final s in schedules.value ?? const <Schedule>[])
        DateUtils.dateOnly(s.startAt.toLocal()),
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        ScheduleCalendar(
          month: calendar.month,
          selected: calendar.selected,
          markedDays: marked,
          onMonthChanged: viewModel.changeMonth,
          onSelected: viewModel.select,
        ),
        const SizedBox(height: 24),
        Text(
          '${calendar.selected.month}월 ${calendar.selected.day}일 '
          '${calendar.selected.weekdayKo}요일',
          style: MoaText.titleM,
        ),
        const SizedBox(height: 12),
        _SelectedDaySchedules(meetingId: meetingId),
      ],
    );
  }
}

/// 선택한 날짜의 일정 영역. 달력은 그대로 두고 이 영역에서만 상태를 처리합니다.
///
/// 불러오는 중이면 로딩 표시, 실패하면 "다시 시도" 안내, 그날 일정이 없으면 빈 안내,
/// 있으면 시작 일시 순으로 일정 줄([ScheduleEventTile])을 보여줍니다.
class _SelectedDaySchedules extends ConsumerWidget {
  const _SelectedDaySchedules({required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendar = ref.watch(scheduleCalendarProvider);
    final state = ref.watch(
      scheduleListProvider(_monthRequest(meetingId, calendar.month)),
    );

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
        .where(
          (s) => DateUtils.isSameDay(s.startAt.toLocal(), calendar.selected),
        )
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

/// 화면 맨 위의 제목과 일정 만들기 `+` 버튼입니다.
/// [showAdd] 가 false 이면(관리자가 아니면) 버튼을 그리지 않습니다.
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
          // 관리자에게만 보입니다.
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

/// 목록 / 캘린더 전환 토글. [calendar] 가 true 이면 캘린더가 선택된 상태이고,
/// 누르면 [onChanged] 로 선택한 쪽(true: 캘린더, false: 목록)을 알립니다.
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

/// 토글의 버튼 하나. [selected] 이면 흰 배경과 그림자로 선택된 모양을 보여줍니다.
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

/// 화면 가운데의 안내 문구. [onRetry] 를 주면 "다시 시도" 버튼이 함께 보입니다.
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
