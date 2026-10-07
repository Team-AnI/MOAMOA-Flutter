import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/group_member.dart';
import 'package:moamoa/features/group/domain/entities/group_role.dart';

void main() {
  const group = Group(id: 'group-1', name: '모아모아', description: '우리 모임');

  test('공지와 일정 관리 기능은 관리자에게만 허용된다', () {
    expect(GroupRole.admin.canWriteNotices, isTrue);
    expect(GroupRole.admin.canCreateSchedules, isTrue);
    expect(GroupRole.admin.canConfirmSchedules, isTrue);
    expect(GroupRole.member.canWriteNotices, isFalse);
    expect(GroupRole.member.canCreateSchedules, isFalse);
    expect(GroupRole.member.canConfirmSchedules, isFalse);
  });

  test('관리자는 초대 코드를 확인할 권한이 있다', () {
    final current = CurrentGroup(
      group: group,
      membership: const GroupMember(
        groupId: 'group-1',
        userId: 'user-1',
        role: GroupRole.admin,
      ),
    );
    expect(current.canViewInviteCode, isTrue);
  });

  test('일반 구성원은 초대 코드를 확인할 권한이 없다', () {
    final current = CurrentGroup(
      group: group,
      membership: const GroupMember(
        groupId: 'group-1',
        userId: 'user-2',
        role: GroupRole.member,
      ),
    );
    expect(current.canViewInviteCode, isFalse);
  });

  test('다른 모임의 구성원 정보를 현재 모임에 연결할 수 없다', () {
    expect(
      () => CurrentGroup(
        group: group,
        membership: const GroupMember(
          groupId: 'other',
          userId: 'user-1',
          role: GroupRole.admin,
        ),
      ),
      throwsArgumentError,
    );
  });
}
