import '../../domain/entities/current_group.dart';
import '../../domain/entities/group_failure_reason.dart';

class GroupState {
  const GroupState({
    this.groups = const [],
    this.currentGroup,
    this.isSubmitting = false,
    this.isLoading = false,
    this.errorMessage,
    this.failureReason,
  });
  final List<CurrentGroup> groups;
  final CurrentGroup? currentGroup;
  final bool isSubmitting;
  final bool isLoading;
  final String? errorMessage;
  final GroupFailureReason? failureReason;
}
