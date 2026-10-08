import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/repositories/group_repository.dart';
import '../../domain/usecases/params/create_group_params.dart';
import '../../domain/usecases/params/join_group_params.dart';
import '../../domain/usecases/params/get_group_params.dart';
import '../../domain/usecases/params/get_group_invite_code_params.dart';
import '../../../../core/usecases/no_params.dart';
import '../providers/group_providers.dart';
import 'group_state.dart';

class GroupViewModel extends Notifier<GroupState> {
  @override
  GroupState build() => const GroupState();

  Future<void> loadGroups() async {
    if (state.isLoading || state.isSubmitting) return;
    final previous = state;
    state = GroupState(
      groups: previous.groups,
      currentGroup: previous.currentGroup,
      isLoading: true,
    );
    try {
      final groups = await ref.read(getMyGroupsProvider)(const NoParams());
      if (!ref.mounted) return;
      CurrentGroup? selected;
      for (final group in groups) {
        if (group.group.id == previous.currentGroup?.group.id) selected = group;
      }
      state = GroupState(
        groups: List.unmodifiable(groups),
        currentGroup: selected,
      );
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = GroupState(
        groups: previous.groups,
        currentGroup: previous.currentGroup,
        errorMessage: _message(error),
        failureReason: error is GroupFailure ? error.reason : null,
      );
    }
  }

  Future<bool> selectGroup(String groupId) async {
    if (state.isSubmitting || state.isLoading) return false;
    final previous = state;
    state = GroupState(
      groups: previous.groups,
      currentGroup: previous.currentGroup,
      isLoading: true,
    );
    try {
      final current = await ref.read(getGroupProvider)(
        GetGroupParams(groupId: groupId),
      );
      if (!ref.mounted) return false;
      final groups = previous.groups
          .map((entry) => entry.group.id == current.group.id ? current : entry)
          .toList();
      state = GroupState(
        groups: List.unmodifiable(groups),
        currentGroup: current,
      );
      return true;
    } on Exception catch (error) {
      if (ref.mounted) {
        state = GroupState(
          groups: previous.groups,
          currentGroup: previous.currentGroup,
          errorMessage: _message(error),
          failureReason: error is GroupFailure ? error.reason : null,
        );
      }
      return false;
    }
  }

  Future<CurrentGroup?> create({
    required String name,
    required String description,
  }) {
    return _submit(
      () => ref.read(createGroupProvider)(
        CreateGroupParams(name: name, description: description),
      ),
    );
  }

  Future<CurrentGroup?> join(String inviteCode) {
    return _submit(
      () =>
          ref.read(joinGroupProvider)(JoinGroupParams(inviteCode: inviteCode)),
    );
  }

  Future<CurrentGroup?> _submit(Future<CurrentGroup> Function() action) async {
    if (state.isSubmitting || state.isLoading) return null;
    final previous = state;
    state = GroupState(
      groups: previous.groups,
      currentGroup: previous.currentGroup,
      isSubmitting: true,
    );
    try {
      final current = await action();
      if (!ref.mounted) return null;
      final groups =
          previous.groups
              .where((entry) => entry.group.id != current.group.id)
              .toList()
            ..add(current);
      state = GroupState(
        groups: List.unmodifiable(groups),
        currentGroup: current,
      );
      return current;
    } on ArgumentError catch (error) {
      if (ref.mounted) {
        state = GroupState(
          groups: previous.groups,
          currentGroup: previous.currentGroup,
          errorMessage: error.message.toString(),
        );
      }
      return null;
    } on Exception catch (error) {
      if (ref.mounted) {
        state = GroupState(
          groups: previous.groups,
          currentGroup: previous.currentGroup,
          errorMessage: _message(error),
          failureReason: error is GroupFailure ? error.reason : null,
        );
      }
      return null;
    }
  }

  Future<String?> getInviteCode() async {
    final current = state.currentGroup;
    if (current == null) return null;
    try {
      return await ref.read(getGroupInviteCodeProvider)(
        GetGroupInviteCodeParams(currentGroup: current),
      );
    } on Exception catch (error) {
      if (ref.mounted) {
        state = GroupState(
          groups: state.groups,
          currentGroup: state.currentGroup,
          errorMessage: _message(error),
          failureReason: error is GroupFailure ? error.reason : null,
        );
      }
      return null;
    }
  }

  String _message(Object error) {
    if (error is GroupFailure) {
      return switch (error.reason) {
        GroupFailureReason.invalidCode => '유효하지 않은 초대 코드입니다.',
        GroupFailureReason.unauthorized => '로그인이 필요합니다.',
        GroupFailureReason.validation => '입력 내용을 확인해주세요.',
        GroupFailureReason.alreadyJoined => '이미 참여 중인 모임입니다.',
        GroupFailureReason.forbidden => '관리자만 초대 코드를 확인할 수 있습니다.',
        GroupFailureReason.unavailable => '요청을 완료하지 못했습니다. 다시 시도해주세요.',
      };
    }
    return '요청을 완료하지 못했습니다. 다시 시도해주세요.';
  }
}
