import '../entities/current_group.dart';
import '../repositories/group_repository.dart';
import 'delete_group.dart';
import 'params/delete_group_params.dart';

final class DeleteGroupImpl implements DeleteGroup {
  const DeleteGroupImpl({required GroupRepository groupRepository})
    // ignore: prefer_initializing_formals
    : _groupRepository = groupRepository;
  final GroupRepository _groupRepository;

  @override
  Future<void> call(DeleteGroupParams params) {
    if (!params.currentGroup.canManageGroup) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    return _groupRepository.deleteGroup(groupId: params.currentGroup.group.id);
  }
}
