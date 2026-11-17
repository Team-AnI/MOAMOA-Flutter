import 'package:freezed_annotation/freezed_annotation.dart';

import 'vote_confirm_status.dart';

part 'vote_confirm_state.freezed.dart';

/// 일정 확정 상태입니다. 현재 단계와 실패했을 때의 안내 문구를 담습니다.
@freezed
abstract class VoteConfirmState with _$VoteConfirmState {
  const factory VoteConfirmState({
    @Default(VoteConfirmStatus.initial) VoteConfirmStatus status,
    String? errorMessage,
  }) = _VoteConfirmState;
}
