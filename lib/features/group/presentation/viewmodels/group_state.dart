import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/entities/group_failure_reason.dart';

part 'group_state.freezed.dart';

@freezed
abstract class GroupState with _$GroupState {
  const factory GroupState({
    @Default([]) List<CurrentGroup> groups,
    CurrentGroup? currentGroup,
    @Default(false) bool isSubmitting,
    @Default(false) bool isLoading,
    String? errorMessage,
    GroupFailureReason? failureReason,
  }) = _GroupState;
}

extension GroupStateX on GroupState {
  /// 일시적 통신 실패와 알 수 없는 예외에만 동일 요청 재시도를 제공합니다.
  bool get canRetryFailure =>
      failureReason == null || failureReason == GroupFailureReason.unavailable;
  String get editFailureTitle =>
      canRetryFailure ? '저장 결과를 확인하지 못했어요' : '모임 정보를 저장하지 못했어요';
  String get editFailureMessage => canRetryFailure
      ? '입력한 내용은 그대로 두었어요. 다시 시도해 주세요'
      : errorMessage ?? '입력 내용을 확인해주세요.';
  String get deleteFailureMessage =>
      canRetryFailure ? '잠시 후 다시 시도해 주세요.' : errorMessage ?? '요청을 완료하지 못했습니다.';

  bool get isBusy => isSubmitting || isLoading;
  bool get canManageCurrentGroup => currentGroup?.canManageGroup ?? false;
}
