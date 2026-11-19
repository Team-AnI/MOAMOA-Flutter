import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/moa_theme.dart';
import '../../../schedule/domain/entities/schedule.dart';
import '../../../schedule/domain/entities/schedule_list_request.dart';
import '../../../schedule/presentation/providers/schedule_providers.dart';
import '../settlement_format.dart';

/// 현재 월을 바꿔가며 기존 일정 Provider의 조회 결과를 선택합니다.
class SettlementSchedulePicker extends ConsumerStatefulWidget {
  const SettlementSchedulePicker({super.key, required this.meetingId});
  final int meetingId;
  @override
  ConsumerState<SettlementSchedulePicker> createState() =>
      _SettlementSchedulePickerState();
}

class _SettlementSchedulePickerState
    extends ConsumerState<SettlementSchedulePicker> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);
  ScheduleListRequest get _request => ScheduleListRequest(
    meetingId: widget.meetingId,
    startDate: _month,
    endDate: DateTime(_month.year, _month.month + 1, 0),
  );
  String get _monthLabel => '${_month.year}년 ${_month.month}월';
  void _moveMonth(int delta) =>
      setState(() => _month = DateTime(_month.year, _month.month + delta));
  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(scheduleListProvider(_request));
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * .65,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    tooltip: '이전 달',
                    onPressed: () => _moveMonth(-1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Expanded(
                    child: Text(
                      _monthLabel,
                      textAlign: TextAlign.center,
                      style: MoaText.titleS,
                    ),
                  ),
                  IconButton(
                    tooltip: '다음 달',
                    onPressed: () => _moveMonth(1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
            Expanded(
              child: switch (schedules) {
                AsyncLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                AsyncError() => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('일정 목록을 불러오지 못했어요.'),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(scheduleListProvider(_request)),
                        child: const Text('다시 시도'),
                      ),
                    ],
                  ),
                ),
                AsyncData(:final value) =>
                  value.isEmpty
                      ? const Center(child: Text('이번 달 일정이 없어요.'))
                      : ListView(
                          children: [
                            for (final schedule in value)
                              ListTile(
                                title: Text(schedule.title),
                                subtitle: Text(shortDate(schedule.startAt)),
                                onTap: () =>
                                    Navigator.pop<Schedule>(context, schedule),
                              ),
                          ],
                        ),
              },
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('일정 선택 없이 돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}
