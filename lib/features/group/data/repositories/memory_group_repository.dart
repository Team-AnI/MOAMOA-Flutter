import '../../domain/entities/current_group.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_member.dart';
import '../../domain/entities/member_role.dart';
import '../../domain/repositories/group_repository.dart';

/// 서버 없이 화면과 도메인 흐름을 검증하는 개발용 데이터입니다.
/// 앱을 다시 실행하면 초기화되며 실제 서버에는 요청하지 않습니다.
class MemoryGroupRepository implements GroupRepository {
  MemoryGroupRepository({this.userId = 1});

  final int userId;
  int _nextId = 2;
  final Map<int, Group> _groups = {
    1: const Group(
      id: 1,
      name: '초대받은 스터디',
      description: 'Mock 가입 검증용 모임',
      memberCount: 1,
    ),
  };
  final Map<String, int> _codes = {'MOA-JOIN': 1};
  final Map<int, MemberRole> _memberships = {};

  CurrentGroup _current(int id) {
    final role = _memberships[id];
    if (role == null) throw const GroupFailure(GroupFailureReason.forbidden);
    return CurrentGroup(
      group: _groups[id]!,
      membership: GroupMember(groupId: id, userId: userId, role: role),
    );
  }

  @override
  Future<List<CurrentGroup>> getMyGroups() async =>
      List.unmodifiable(_memberships.keys.map(_current));

  @override
  Future<CurrentGroup> getGroup(int groupId) async => _current(groupId);

  @override
  Future<CurrentGroup> createGroup({
    required String name,
    required String description,
  }) async {
    if (name.trim().isEmpty) {
      throw const GroupFailure(GroupFailureReason.validation);
    }
    final id = _nextId++;
    _groups[id] = Group(
      id: id,
      name: name.trim(),
      description: description.trim().isEmpty ? null : description.trim(),
      memberCount: 1,
    );
    _memberships[id] = MemberRole.admin;
    _codes['MOA-${id.toString().padLeft(6, '0')}'] = id;
    return _current(id);
  }

  /// 가입 전 조회 API가 없는 동안 Mock 화면에서만 사용하는 미리보기입니다.
  /// 구성원 정보와 구성원 수를 변경하지 않습니다.
  Future<Group> previewInviteCode(String inviteCode) async {
    final id = _codes[inviteCode.trim()];
    if (id == null) throw const GroupFailure(GroupFailureReason.invalidCode);
    if (_memberships.containsKey(id)) {
      throw const GroupFailure(GroupFailureReason.alreadyJoined);
    }
    return _groups[id]!;
  }

  @override
  Future<CurrentGroup> joinGroup({required String inviteCode}) async {
    final id = _codes[inviteCode.trim()];
    if (id == null) throw const GroupFailure(GroupFailureReason.invalidCode);
    if (_memberships.containsKey(id)) {
      throw const GroupFailure(GroupFailureReason.alreadyJoined);
    }
    _memberships[id] = MemberRole.member;
    final group = _groups[id]!;
    _groups[id] = Group(
      id: id,
      name: group.name,
      description: group.description,
      memberCount: (group.memberCount ?? 0) + 1,
    );
    return _current(id);
  }

  @override
  Future<String> getInviteCode({required int groupId}) async {
    if (!_current(groupId).canViewInviteCode) {
      throw const GroupFailure(GroupFailureReason.forbidden);
    }
    return _codes.entries.firstWhere((entry) => entry.value == groupId).key;
  }
}
