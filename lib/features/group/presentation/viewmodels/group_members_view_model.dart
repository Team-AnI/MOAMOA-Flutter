import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/group_repository.dart';
import '../../domain/usecases/params/get_group_params.dart';
import '../providers/group_members_providers.dart';
import 'group_members_state.dart';

class GroupMembersViewModel extends Notifier<GroupMembersState> {
  GroupMembersViewModel({required int groupId}) : _groupId = groupId;
  final int _groupId;
  int _requestId = 0;

  @override
  GroupMembersState build() {
    ref.watch(getGroupMembersProvider);
    final generation = ++_requestId;
    ref.onDispose(() => _requestId++);
    // 초기 상태가 구독된 뒤 조회합니다. 폐기되거나 다시 생성된 세대는 실행하지 않습니다.
    scheduleMicrotask(() {
      if (ref.mounted && generation == _requestId) unawaited(refresh());
    });
    return const GroupMembersState(isLoading: true);
  }

  /// 새로고침 중 목록을 유지하며, 최신 요청의 결과만 상태에 반영합니다.
  Future<void> refresh() async {
    final requestId = ++_requestId;
    state = state.copyWith(isLoading: true, failureReason: null);
    try {
      final members = await ref.read(getGroupMembersProvider)(
        GetGroupParams(groupId: _groupId),
      );
      if (!ref.mounted || requestId != _requestId) return;
      state = GroupMembersState(members: members, hasLoaded: true);
    } on GroupFailure catch (error) {
      if (!ref.mounted || requestId != _requestId) return;
      state = GroupMembersState(failureReason: error.reason, hasLoaded: true);
    } catch (_) {
      if (!ref.mounted || requestId != _requestId) return;
      state = const GroupMembersState(
        failureReason: GroupFailureReason.unavailable,
        hasLoaded: true,
      );
    }
  }
}
