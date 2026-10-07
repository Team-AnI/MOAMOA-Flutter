import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/repositories/group_repository.dart';
import '../../domain/usecases/create_group.dart';
import '../../domain/usecases/join_group.dart';

/// API 명세가 확정되면 data 레이어의 구현체를 주입합니다.
final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  throw const GroupFailure(GroupFailureReason.unavailable);
});

final groupProvider = NotifierProvider<GroupNotifier, GroupState>(
  GroupNotifier.new,
);

class GroupState {
  const GroupState({
    this.groups = const [],
    this.currentGroup,
    this.isSubmitting = false,
    this.isLoading = false,
    this.errorMessage,
    this.failureReason,
  });
  final List<CurrentGroup> groups;
  final CurrentGroup? currentGroup;
  final bool isSubmitting;
  final bool isLoading;
  final String? errorMessage;
  final GroupFailureReason? failureReason;
}

class GroupNotifier extends Notifier<GroupState> {
  @override
  GroupState build() => const GroupState();

  GroupRepository get _repository => ref.read(groupRepositoryProvider);

  Future<void> loadGroups() async {
    if (state.isLoading || state.isSubmitting) return;
    final previous = state;
    state = GroupState(
      groups: previous.groups,
      currentGroup: previous.currentGroup,
      isLoading: true,
    );
    try {
      final groups = await _repository.getMyGroups();
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

  void selectGroup(String groupId) {
    if (state.isSubmitting || state.isLoading) return;
    final group = state.groups.firstWhere((entry) => entry.group.id == groupId);
    state = GroupState(groups: state.groups, currentGroup: group);
  }

  Future<CurrentGroup?> create({
    required String name,
    required String description,
  }) {
    return _submit(
      () => CreateGroup(_repository)(name: name, description: description),
    );
  }

  Future<CurrentGroup?> join(String inviteCode) {
    return _submit(() => JoinGroup(_repository)(inviteCode: inviteCode));
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

  String _message(Object error) {
    if (error is GroupFailure) {
      return switch (error.reason) {
        GroupFailureReason.invalidCode => '유효하지 않은 초대 코드입니다.',
        GroupFailureReason.expiredCode => '만료된 초대 코드입니다.',
        GroupFailureReason.alreadyJoined => '이미 참여 중인 모임입니다.',
        GroupFailureReason.forbidden => '관리자만 초대 코드를 확인할 수 있습니다.',
        GroupFailureReason.unavailable => '요청을 완료하지 못했습니다. 다시 시도해주세요.',
      };
    }
    return '요청을 완료하지 못했습니다. 다시 시도해주세요.';
  }
}
