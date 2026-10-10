import '../entities/current_group.dart';
import '../repositories/group_repository.dart';
import 'get_group_invite_code.dart';
import 'params/get_group_invite_code_params.dart';

final class GetGroupInviteCodeImpl implements GetGroupInviteCode {
  const GetGroupInviteCodeImpl({required this.repository});
  final GroupRepository repository;
  @override
  Future<String> call(GetGroupInviteCodeParams params) {
    if (!params.currentGroup.canViewInviteCode) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    return repository.getInviteCode(groupId: params.currentGroup.group.id);
  }
}
