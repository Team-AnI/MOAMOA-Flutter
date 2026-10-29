import 'dart:async';

import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/group_member.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';

class FakeGroupRepository implements GroupRepository {
  @override
  Future<Group> updateGroup({
    required int groupId,
    String? name,
    String? description,
  }) async {
    final current = groups.firstWhere((entry) => entry.group.id == groupId);
    final updated = current.group.copyWith(
      name: name ?? current.group.name,
      description: description == ''
          ? null
          : description ?? current.group.description,
    );
    groups = groups
        .map(
          (entry) => entry.group.id == groupId
              ? entry.copyWith(group: updated)
              : entry,
        )
        .toList();
    return updated;
  }

  @override
  Future<void> deleteGroup({required int groupId}) async {
    groups = groups.where((entry) => entry.group.id != groupId).toList();
  }

  int createCalls = 0;
  String? lastName;
  String? lastDescription;
  final pendingCreate = Completer<CurrentGroup>();
  GroupFailure? joinFailure;
  GroupFailure? loadFailure;
  List<CurrentGroup> groups = [];

  @override
  Future<List<CurrentGroup>> getMyGroups() async {
    if (loadFailure != null) throw loadFailure!;
    return groups;
  }

  @override
  Future<CurrentGroup> createGroup(CreateGroupParams params) {
    final name = params.name;
    final description = params.description;
    createCalls++;
    lastName = name;
    lastDescription = description;
    return pendingCreate.future;
  }

  @override
  Future<CurrentGroup> joinGroup({required String inviteCode}) async {
    if (joinFailure != null) throw joinFailure!;
    return makeGroup(MemberRole.member);
  }

  @override
  Future<CurrentGroup> getGroup(int groupId) async =>
      groups.firstWhere((entry) => entry.group.id == groupId);

  @override
  Future<String> getInviteCode({required int groupId}) async => 'CODE';
}

CurrentGroup makeGroup(MemberRole role) => CurrentGroup(
  group: const Group(id: 1, name: '모임', description: '소개'),
  membership: GroupMember(groupId: 1, userId: 11, role: role),
);
