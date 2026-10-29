import '../entities/group.dart';
import '../entities/member_role.dart';
import '../repositories/group_repository.dart';
import 'params/update_group_params.dart';
import 'update_group.dart';

final class UpdateGroupImpl implements UpdateGroup {
  const UpdateGroupImpl({required GroupRepository groupRepository})
    // ignore: prefer_initializing_formals
    : _groupRepository = groupRepository;
  final GroupRepository _groupRepository;

  @override
  Future<Group> call(UpdateGroupParams params) {
    if (params.currentGroup.membership.role != MemberRole.admin) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    final name = params.name?.trim();
    if (name != null && (name.isEmpty || name.length > 20)) {
      throw const GroupFailure(GroupFailureReason.validation);
    }
    if (name == null && params.description == null) {
      throw const GroupFailure(GroupFailureReason.validation);
    }
    return _groupRepository.updateGroup(
      groupId: params.currentGroup.group.id,
      name: name,
      description: params.description,
    );
  }
}
