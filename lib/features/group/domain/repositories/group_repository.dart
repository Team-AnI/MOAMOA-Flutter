import '../usecases/params/create_group_params.dart';
import '../entities/current_group.dart';
import '../entities/group_failure.dart';

export '../usecases/params/create_group_params.dart';
export '../entities/group_failure.dart';
export '../entities/group_failure_reason.dart';

/// 구현체는 인증된 사용자의 모임만 반환하고 서버에서 권한을 검증합니다.
abstract interface class GroupRepository {
  Future<List<CurrentGroup>> getMyGroups();
  Future<CurrentGroup> getGroup(int groupId);
  Future<CurrentGroup> createGroup(CreateGroupParams params);

  /// 유효하지 않은 코드, 이미 가입한 모임은 [GroupFailure]로 구분합니다.
  Future<CurrentGroup> joinGroup({required String inviteCode});
  Future<String> getInviteCode({required int groupId});
}
