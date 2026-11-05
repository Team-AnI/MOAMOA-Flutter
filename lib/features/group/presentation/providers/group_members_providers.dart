import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_group_members.dart';
import '../../domain/usecases/get_group_members_impl.dart';
import '../viewmodels/group_members_state.dart';
import '../viewmodels/group_members_view_model.dart';
import 'group_providers.dart';

final getGroupMembersProvider = Provider<GetGroupMembers>(
  (ref) =>
      GetGroupMembersImpl(groupRepository: ref.watch(groupRepositoryProvider)),
);

/// 모임별 요청·로딩·실패 상태를 분리하고 화면 종료 시 정리합니다.
final groupMembersProvider = NotifierProvider.autoDispose
    .family<GroupMembersViewModel, GroupMembersState, int>(
      (groupId) => GroupMembersViewModel(groupId: groupId),
    );
