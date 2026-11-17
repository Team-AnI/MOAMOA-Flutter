import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/errors/api_exception.dart';

import '../../domain/usecases/confirm_schedule.dart';
import '../providers/vote_providers.dart';
import '../vote_id.dart';
import 'vote_confirm_state.dart';
import 'vote_confirm_status.dart';

/// 일정 확정 ViewModel 입니다. 고른 후보 시간으로 [VoteId] 투표의 일정을 확정하고 과정을 [VoteConfirmState] 로 알립니다.
///
/// 확정 뒤 일정 목록 갱신은 투표 화면을 연 쪽(일정 목록)이 화면 결과를 보고 합니다.
/// 투표가 일정 Provider 를 알지 않도록 여기서는 일정 Provider 를 건드리지 않습니다.
/// 실패하면 투표 상태가 바뀌었을 수 있어 같은 기능의 [voteProvider] 만 다시 불러옵니다.
class VoteConfirmViewModel extends Notifier<VoteConfirmState> {
  VoteConfirmViewModel({required VoteId id}) : _id = id;

  final VoteId _id;

  @override
  VoteConfirmState build() => const VoteConfirmState();

  Future<void> confirm(DateTime meetingTime) async {
    if (state.status == VoteConfirmStatus.submitting) return; // 중복 탭 방지
    state = const VoteConfirmState(status: VoteConfirmStatus.submitting);

    try {
      await ref.read(confirmScheduleProvider)(
        ConfirmScheduleParams(
          meetingId: _id.meetingId,
          scheduleId: _id.scheduleId,
          meetingTime: meetingTime,
        ),
      );
      if (!ref.mounted) return; // 확정 중에 화면이 닫힌 경우
      state = const VoteConfirmState(status: VoteConfirmStatus.success);
    } on ApiException catch (e) {
      if (!ref.mounted) return;
      // 다른 관리자가 먼저 확정했으면(422) 화면이 지난 투표를 보여주므로 다시 불러옵니다.
      ref.invalidate(voteProvider(_id));
      state = VoteConfirmState(
        status: VoteConfirmStatus.failure,
        errorMessage: e.userMessage,
      );
    }
  }
}
