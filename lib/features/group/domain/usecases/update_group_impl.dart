import '../entities/group.dart';
import '../entities/member_role.dart';
import '../repositories/group_repository.dart';
import 'params/update_group_params.dart';
import 'update_group.dart';

final class UpdateGroupImpl implements UpdateGroup {
  const UpdateGroupImpl({required GroupRepository repository})
    // ignore: prefer_initializing_formals
    : _repository = repository;
  final GroupRepository _repository;

  @override
  Future<Group> call(UpdateGroupParams params) {
    if (params.currentGroup.membership.role != MemberRole.admin) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    if (params.name != null && params.name!.trim().isEmpty ||
        params.name == null && params.description == null) {
      throw const GroupFailure(GroupFailureReason.validation);
    }
    return _repository.updateGroup(
      groupId: params.currentGroup.group.id,
      name: params.name?.trim(),
      description: params.description,
    );
  }
}
