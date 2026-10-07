import '../entities/current_group.dart';
import '../repositories/group_repository.dart';

class GetGroupInviteCode {
  const GetGroupInviteCode(this._repository);
  final GroupRepository _repository;

  Future<String> call(CurrentGroup currentGroup) {
    if (!currentGroup.canViewInviteCode) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    return _repository.getInviteCode(groupId: currentGroup.group.id);
  }
}
