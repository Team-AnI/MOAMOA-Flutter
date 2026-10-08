import '../entities/current_group.dart';

/// 구현체는 인증된 사용자의 모임만 반환하고 서버에서 권한을 검증합니다.
abstract interface class GroupRepository {
  Future<List<CurrentGroup>> getMyGroups();
  Future<CurrentGroup> getGroup(String groupId);
  Future<CurrentGroup> createGroup({
    required String name,
    required String description,
  });

  /// 유효하지 않은 코드, 이미 가입한 모임은 [GroupFailure]로 구분합니다.
  Future<CurrentGroup> joinGroup({required String inviteCode});
  Future<String> getInviteCode({required String groupId});
}

enum GroupFailureReason {
  invalidCode,
  unauthorized,
  validation,
  alreadyJoined,
  forbidden,
  unavailable,
}

class GroupFailure implements Exception {
  const GroupFailure(this.reason);
  final GroupFailureReason reason;
}
