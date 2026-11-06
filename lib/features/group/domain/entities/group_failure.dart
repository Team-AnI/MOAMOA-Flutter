import 'group_failure_reason.dart';

class GroupFailure implements Exception {
  const GroupFailure(this.reason);
  final GroupFailureReason reason;
}
