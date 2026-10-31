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
  bool get isBusy => isSubmitting || isLoading;
  bool get canManageCurrentGroup => currentGroup?.canManageGroup ?? false;
}
