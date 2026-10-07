import 'group.dart';
import 'group_member.dart';

/// 선택한 모임과 해당 모임에서 로그인 사용자가 가진 권한입니다.
class CurrentGroup {
  CurrentGroup({required this.group, required this.membership}) {
    if (group.id != membership.groupId) {
      throw ArgumentError('모임과 구성원 정보의 모임 ID가 일치해야 합니다.');
    }
  }

  final Group group;
  final GroupMember membership;

  bool get canViewInviteCode => membership.role.canViewInviteCode;
}
