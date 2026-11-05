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
    try {
      final getMembers = ref.watch(getGroupMembersProvider);
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

  /// 새로고침과 오류 재시도를 같은 경로로 실행하고 새 응답을 기다립니다.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
