import 'package:freezed_annotation/freezed_annotation.dart';

import 'group.dart';
import 'group_member.dart';
import 'member_role.dart';

part 'current_group.freezed.dart';

/// 선택한 모임과 해당 모임에서 로그인 사용자가 가진 권한입니다.
@freezed
abstract class CurrentGroup with _$CurrentGroup {
  @Assert('group.id == membership.groupId', '모임과 구성원 정보의 모임 ID가 일치해야 합니다.')
  factory CurrentGroup({
    required Group group,
    required GroupMember membership,
  }) = _CurrentGroup;
}

/// 현재 모임에서 로그인 사용자가 가진 권한을 위임합니다.
extension CurrentGroupPermissions on CurrentGroup {
  bool get canWriteNotices => membership.role.canWriteNotices;
  bool get canCreateSchedules => membership.role.canCreateSchedules;
  bool get canConfirmSchedules => membership.role.canConfirmSchedules;
  bool get canViewInviteCode => membership.role.canViewInviteCode;
}
