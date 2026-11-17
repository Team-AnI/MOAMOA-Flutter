import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/errors/api_exception.dart';

import '../../domain/usecases/submit_my_vote.dart';
import '../providers/vote_providers.dart';
import '../vote_id.dart';
import 'vote_submit_state.dart';
import 'vote_submit_status.dart';

/// 내 투표 제출 ViewModel 입니다. 고른 후보 시간을 [VoteId] 투표의 내 응답으로 제출하고
/// 과정을 [VoteSubmitState] 로 알립니다. (API 5-3)
///
/// 어떤 칸을 골랐는지는 화면 안에서만 쓰는 값이라 여기서 들고 있지 않고, 제출할 때 넘겨받습니다.
/// 제출이 끝나면 내 선택·칸별 가능 인원·응답 인원이 바뀌므로 투표를 다시 불러옵니다.
class VoteSubmitViewModel extends Notifier<VoteSubmitState> {
  VoteSubmitViewModel({required VoteId id}) : _id = id;

  final VoteId _id;

  @override
  VoteSubmitState build() => const VoteSubmitState();

  /// [meetingTimes] 를 내 응답으로 제출합니다. 비어 있으면 "가능한 시간 없음" 입니다.
  /// 다시 제출하면 이전 선택을 모두 바꿉니다.
  Future<void> submit(List<DateTime> meetingTimes) async {
    if (state.status == VoteSubmitStatus.submitting) return; // 중복 탭 방지
    state = const VoteSubmitState(status: VoteSubmitStatus.submitting);

    try {
      await ref.read(submitMyVoteProvider)(
        SubmitMyVoteParams(
          meetingId: _id.meetingId,
          scheduleId: _id.scheduleId,
          meetingTimes: meetingTimes,
        ),
      );
      if (!ref.mounted) return; // 제출 중에 화면이 닫힌 경우
      ref
        ..invalidate(voteProvider(_id))
        ..invalidate(voteResponsesProvider(_id));
      state = const VoteSubmitState(status: VoteSubmitStatus.success);
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      // 그 사이 마감되거나 확정됐을 수 있어(422) 화면이 지난 투표를 보여주므로 다시 불러옵니다.
      ref.invalidate(voteProvider(_id));
      state = VoteSubmitState(
        status: VoteSubmitStatus.failure,
        errorMessage: e.userMessage,
      );
    }
  }
}
