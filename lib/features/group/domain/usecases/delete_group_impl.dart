import '../entities/member_role.dart';
import '../repositories/group_repository.dart';
import 'delete_group.dart';
import 'params/delete_group_params.dart';

final class DeleteGroupImpl implements DeleteGroup {
  const DeleteGroupImpl({required GroupRepository repository})
    // ignore: prefer_initializing_formals
    : _repository = repository;
  final GroupRepository _repository;

  @override
  Future<void> call(DeleteGroupParams params) {
    if (params.currentGroup.membership.role != MemberRole.admin) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    return _repository.deleteGroup(groupId: params.currentGroup.group.id);
  }
}
