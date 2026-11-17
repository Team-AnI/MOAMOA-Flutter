import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/presentation/schedule_format.dart';

import '../providers/vote_providers.dart';
import '../viewmodels/vote_create_state.dart';
import '../viewmodels/vote_create_status.dart';
import '../viewmodels/vote_create_view_model.dart';
import '../viewmodels/vote_time_range.dart';
import '../widgets/vote_colors.dart';
import '../widgets/vote_date_sheet.dart';
import '../widgets/vote_field.dart';
import '../widgets/vote_primary_button.dart';
import '../widgets/vote_time_sheet.dart';

/// 투표로 일정 만들기 화면 (관리자). 후보 날짜마다 같은 후보 시각을 붙여 후보를 만들고 투표를 시작합니다.
///
/// - 입력: 일정 이름, 후보 날짜(시트), 후보 시간(시트), 투표 마감
/// - 빈 항목이 있으면 버튼이 회색이고, 누르면 빈 항목마다 오류 문구를 보여줍니다.
/// - 결과: 만들면 만든 일정 id 를 돌려주며 화면을 닫고, 실패하면 서버 문구를 하단 안내(SnackBar)로 보여줍니다.
///   일정 목록 갱신은 이 화면을 연 쪽(일정 목록)이 돌려받은 id 를 보고 합니다.
///
/// [meetingId] 는 투표를 만들 모임입니다. 입력값과 제출 상태는 [voteCreateProvider] 가 관리합니다.
class VoteCreatePage extends ConsumerWidget {
  const VoteCreatePage({super.key, required this.meetingId});

  final int meetingId;

  /// 제출 상태가 바뀌면: 성공이면 만든 일정 id 를 돌려주며 닫고, 실패하면 안내합니다.
  void _onStateChanged(
    BuildContext context,
    VoteCreateState? previous,
    VoteCreateState next,
  ) {
    if (previous?.status == next.status) return;
    if (next.status == VoteCreateStatus.success) {
      context.pop(next.createdScheduleId);
    } else if (next.status == VoteCreateStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(next.errorMessage ?? '투표를 만들지 못했어요')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      voteCreateProvider(meetingId),
      (previous, next) => _onStateChanged(context, previous, next),
    );

    final submitting =
        ref.watch(voteCreateProvider(meetingId)).status ==
        VoteCreateStatus.submitting;

    // 만드는 중에 닫으면 서버에는 투표가 생기지만 목록이 만든 id 를 받지 못해 갱신되지 않습니다.
    // 시스템 뒤로가기·스와이프만 막습니다. 상단 바 버튼은 context.pop 이라 PopScope 를 거치지 않습니다.
    return PopScope(
      canPop: !submitting,
      child: Scaffold(
        backgroundColor: MoaColors.page,
        appBar: MoaAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: _CreateForm(meetingId: meetingId)),
              _SubmitBar(meetingId: meetingId),
            ],
          ),
        ),
      ),
    );
  }
}

/// 제목과 입력 칸 4개입니다. 길어질 수 있어서 스크롤됩니다.
/// 날짜·시간은 시트에서, 투표 마감은 날짜·시간 선택창에서 고릅니다.
/// 화면에서 한 단계만 나누므로, 50줄을 넘어도 안에서 다시 나누지 않고 구역을 주석으로 표시합니다.
class _CreateForm extends ConsumerWidget {
  const _CreateForm({required this.meetingId});

  final int meetingId;

  VoteCreateViewModel _viewModel(WidgetRef ref) =>
      ref.read(voteCreateProvider(meetingId).notifier);

  Future<T?> _showSheet<T>(BuildContext context, Widget sheet) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: MoaColors.page,
      barrierColor: MoaColors.scrim,
      shape: const RoundedRectangleBorder(),
      builder: (_) => sheet,
    );
  }

  Future<void> _pickDates(BuildContext context, WidgetRef ref) async {
    final dates = ref.read(voteCreateProvider(meetingId)).dates;
    final picked = await _showSheet<List<DateTime>>(
      context,
      VoteDateSheet(initialDates: dates),
    );
    if (picked != null && context.mounted) _viewModel(ref).changeDates(picked);
  }

  Future<void> _pickTimeRange(BuildContext context, WidgetRef ref) async {
    final range = ref.read(voteCreateProvider(meetingId)).timeRange;
    final picked = await _showSheet<VoteTimeRange>(
      context,
      VoteTimeSheet(initialRange: range),
    );
    if (picked != null && context.mounted) {
      _viewModel(ref).changeTimeRange(picked);
    }
  }

  /// 날짜를 고른 뒤 이어서 시간을 고릅니다. 오늘 이전 날짜는 고를 수 없고, 둘 중 하나라도 취소하면 그대로 둡니다.
  Future<void> _pickDeadline(BuildContext context, WidgetRef ref) async {
    final current = ref.read(voteCreateProvider(meetingId)).voteDeadlineAt;
    final today = DateUtils.dateOnly(DateTime.now());
    final date = await showDatePicker(
      context: context,
      initialDate: current != null && !current.isBefore(today)
          ? current
          : today,
      firstDate: today,
      lastDate: DateTime(today.year + 1, today.month, today.day),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: current != null
          ? TimeOfDay.fromDateTime(current)
          : const TimeOfDay(hour: 23, minute: 59),
    );
    if (time == null || !context.mounted) return;
    _viewModel(ref).changeDeadline(
      DateTime(date.year, date.month, date.day, time.hour, time.minute),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voteCreateProvider(meetingId));

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18,
        children: [
          // 화면 제목과 안내 문구
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text('일정 만들기', style: MoaText.titleXl),
                Text(
                  '후보 시간을 정하면 투표가 시작돼요.',
                  style: MoaText.body.copyWith(color: MoaColors.textSecondary),
                ),
              ],
            ),
          ),
          // 일정 이름. 서버 제한(50자)을 넘겨 입력하지 않게 막습니다.
          VoteField(
            label: '일정 이름',
            error: state.titleError,
            input: TextField(
              onChanged: _viewModel(ref).changeTitle,
              inputFormatters: [LengthLimitingTextInputFormatter(50)],
              style: MoaText.body,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: '일정 이름을 입력하세요',
                hintStyle: MoaText.body.copyWith(
                  color: VoteColors.textDisabled,
                ),
              ),
            ),
          ),
          VoteField(
            label: '후보 날짜',
            icon: 'calendar_field',
            value: state.datesLabel,
            placeholder: '날짜를 골라 주세요',
            error: state.datesError,
            onTap: () => _pickDates(context, ref),
          ),
          VoteField(
            label: '후보 시간',
            icon: 'clock_field',
            value: state.timeRange.label,
            onTap: () => _pickTimeRange(context, ref),
          ),
          VoteField(
            label: '투표 마감',
            icon: 'hourglass_field',
            value: state.voteDeadlineAt?.fieldLabel,
            placeholder: '마감 일시를 골라 주세요',
            error: state.deadlineError,
            onTap: () => _pickDeadline(context, ref),
          ),
        ],
      ),
    );
  }
}

/// 빈 항목 안내와 "투표 시작하기" 버튼입니다.
/// 빈 항목이 있으면 버튼이 회색이지만 눌리고, 누르면 빈 항목에 오류 문구가 보입니다.
class _SubmitBar extends ConsumerWidget {
  const _SubmitBar({required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voteCreateProvider(meetingId));

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        spacing: 10,
        children: [
          if (state.missingHint case final hint?)
            Text(
              hint,
              style: MoaText.caption.copyWith(color: MoaColors.textSecondary),
            ),
          VotePrimaryButton(
            label: '투표 시작하기',
            enabled: state.canSubmit,
            onPressed: ref.read(voteCreateProvider(meetingId).notifier).submit,
          ),
        ],
      ),
    );
  }
}
