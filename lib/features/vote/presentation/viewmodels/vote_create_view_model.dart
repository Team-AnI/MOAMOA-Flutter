import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/errors/api_exception.dart';

import '../../domain/usecases/create_vote.dart';
import '../providers/vote_providers.dart';
import 'vote_create_state.dart';
import 'vote_create_status.dart';
import 'vote_time_range.dart';

/// 투표 만들기 ViewModel 입니다. 입력값을 들고 있다가 [submit] 으로 투표를 만듭니다.
class VoteCreateViewModel extends Notifier<VoteCreateState> {
  VoteCreateViewModel({required int meetingId}) : _meetingId = meetingId;

  final int _meetingId;

  @override
  VoteCreateState build() => const VoteCreateState();

  void changeTitle(String title) => state = state.copyWith(title: title);

  /// 날짜만 남기고 오름차순으로 정리해 둡니다.
  void changeDates(List<DateTime> dates) {
    final dateOnly = {
      for (final date in dates) DateTime(date.year, date.month, date.day),
    }.toList()..sort();
    state = state.copyWith(dates: dateOnly);
  }

  void changeTimeRange(VoteTimeRange timeRange) =>
      state = state.copyWith(timeRange: timeRange);

  void changeDeadline(DateTime voteDeadlineAt) => state = state.copyWith(
    voteDeadlineAt: voteDeadlineAt,
    deadlinePassed: _hasPassed(voteDeadlineAt),
  );

  /// 서버는 마감이 지금 이후여야 받습니다. (API 5-1)
  static bool _hasPassed(DateTime time) => !time.isAfter(DateTime.now());

  /// 빈 항목이 있거나 마감이 지났으면 오류 문구만 보여주고, 아니면 투표를 만듭니다.
  Future<void> submit() async {
    if (state.status == VoteCreateStatus.submitting) return; // 중복 탭 방지
    // 고른 뒤 시간이 흘러 마감이 지났을 수 있어 제출할 때 한 번 더 확인합니다.
    if (state.voteDeadlineAt case final deadline? when _hasPassed(deadline)) {
      state = state.copyWith(deadlinePassed: true);
    }
    if (!state.canSubmit) {
      state = state.copyWith(showErrors: true);
      return;
    }
    state = state.copyWith(
      status: VoteCreateStatus.submitting,
      errorMessage: null,
    );

    try {
      final scheduleId = await ref.read(createVoteProvider)(
        CreateVoteParams(
          meetingId: _meetingId,
          title: state.title,
          voteDeadlineAt: state.voteDeadlineAt!,
          meetingTimes: state.meetingTimes,
        ),
      );
      if (!ref.mounted) return; // 제출 중에 화면이 닫힌 경우
      state = state.copyWith(
        status: VoteCreateStatus.success,
        createdScheduleId: scheduleId,
      );
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        status: VoteCreateStatus.failure,
        errorMessage: e.userMessage,
      );
    }
  }
}
