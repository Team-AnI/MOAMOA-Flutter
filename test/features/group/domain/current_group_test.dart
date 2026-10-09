import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/group_member.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';

void main() {
  const group = Group(id: 1, name: '모아모아', description: '우리 모임');

  test('내용이 같은 현재 모임과 구성원은 동등하다', () {
    final first = CurrentGroup(
      group: const Group(id: 1, name: '모임'),
      membership: const GroupMember(
        groupId: 1,
        userId: 11,
        role: MemberRole.admin,
      ),
    );
    final second = CurrentGroup(
      group: const Group(id: 1, name: '모임'),
      membership: const GroupMember(
        groupId: 1,
        userId: 11,
        role: MemberRole.admin,
      ),
    );
    expect(first, second);
    expect(first.hashCode, second.hashCode);
    expect(first.group.description, isNull);
    expect(
      first,
      isNot(
        CurrentGroup(
          group: const Group(id: 1, name: '모임'),
          membership: const GroupMember(groupId: 1, role: MemberRole.member),
        ),
      ),
    );
  });

  test('공지와 일정 관리 기능은 관리자에게만 허용된다', () {
    expect(MemberRole.admin.canWriteNotices, isTrue);
    expect(MemberRole.admin.canCreateSchedules, isTrue);
    expect(MemberRole.admin.canConfirmSchedules, isTrue);
    expect(MemberRole.member.canWriteNotices, isFalse);
    expect(MemberRole.member.canCreateSchedules, isFalse);
    expect(MemberRole.member.canConfirmSchedules, isFalse);
  });

  test('관리자는 초대 코드를 확인할 권한이 있다', () {
    final current = CurrentGroup(
      group: group,
      membership: const GroupMember(
        groupId: 1,
        userId: 11,
        role: MemberRole.admin,
      ),
    );
    expect(current.canViewInviteCode, isTrue);
    expect(current.canWriteNotices, isTrue);
    expect(current.canCreateSchedules, isTrue);
    expect(current.canConfirmSchedules, isTrue);
  });

  test('일반 구성원은 초대 코드를 확인할 권한이 없다', () {
    final current = CurrentGroup(
      group: group,
      membership: const GroupMember(
        groupId: 1,
        userId: 12,
        role: MemberRole.member,
      ),
    );
    expect(current.canViewInviteCode, isFalse);
    expect(current.canWriteNotices, isFalse);
    expect(current.canCreateSchedules, isFalse);
    expect(current.canConfirmSchedules, isFalse);
  });

  test('다른 모임의 구성원 정보를 현재 모임에 연결할 수 없다', () {
    expect(
      () => CurrentGroup(
        group: group,
        membership: const GroupMember(
          groupId: 2,
          userId: 11,
          role: MemberRole.admin,
        ),
      ),
      throwsAssertionError,
    );
  });
}
