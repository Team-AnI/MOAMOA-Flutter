import 'package:freezed_annotation/freezed_annotation.dart';

import 'vote_submit_status.dart';

part 'vote_submit_state.freezed.dart';

/// 내 투표 제출 상태입니다. 현재 단계와 실패했을 때의 안내 문구를 담습니다.
@freezed
abstract class VoteSubmitState with _$VoteSubmitState {
  const factory VoteSubmitState({
    @Default(VoteSubmitStatus.initial) VoteSubmitStatus status,
    String? errorMessage,
  }) = _VoteSubmitState;
}
