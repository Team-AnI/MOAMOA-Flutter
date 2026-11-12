import '../entities/group_member_profile.dart';
import '../repositories/group_repository.dart';
import 'get_group_members.dart';
import 'params/get_group_params.dart';

final class GetGroupMembersImpl implements GetGroupMembers {
  const GetGroupMembersImpl({required GroupRepository groupRepository})
    : _groupRepository = groupRepository;
  final GroupRepository _groupRepository;

  @override
  Future<List<GroupMemberProfile>> call(GetGroupParams params) {
    return _groupRepository.getMembersByGroupId(groupId: params.groupId);
  }
}
