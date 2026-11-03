import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/group_repository.dart';
import '../../domain/usecases/params/get_group_params.dart';
import '../providers/group_members_providers.dart';
import 'group_members_state.dart';

class GroupMembersViewModel extends AsyncNotifier<GroupMembersState> {
  GroupMembersViewModel({required int groupId}) : _groupId = groupId;
  final int _groupId;

  @override
  Future<GroupMembersState> build() async {
    final getMembers = ref.watch(getGroupMembersProvider);
    try {
      final members = await getMembers(GetGroupParams(groupId: _groupId));
      return GroupMembersState(members: members);
    } on GroupFailure catch (error) {
      return GroupMembersState(failureReason: error.reason);
    } catch (_) {
      return const GroupMembersState(
        failureReason: GroupFailureReason.unavailable,
      );
    }
  }
}
