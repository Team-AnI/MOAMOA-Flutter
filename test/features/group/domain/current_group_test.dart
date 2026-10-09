import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/group_member.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';

void main() {
  const group = Group(id: 1, name: '모아모아', description: '우리 모임');

  test('현재 모임과 구성원 정보가 같으면 동등하게 비교되고 hashCode가 같다', () {
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

  test('copyWith로 역할을 변경하면 위임 권한을 갱신하고 원본을 보존한다', () {
    final original = CurrentGroup(
      group: group,
      membership: const GroupMember(
        groupId: 1,
        userId: 11,
        role: MemberRole.admin,
      ),
    );
    final updated = original.copyWith(
      membership: original.membership.copyWith(role: MemberRole.member),
    );

    expect(original.canViewInviteCode, isTrue);
    expect(updated.canViewInviteCode, isFalse);
    expect(updated.canWriteNotices, isFalse);
    expect(updated.membership.userId, 11);
    expect(
      () => original.copyWith(
        membership: original.membership.copyWith(groupId: 2),
      ),
      throwsAssertionError,
    );
  });

  test('역할이 관리자이면 공지·일정 관리 권한을 허용하고 구성원이면 거부한다', () {
    expect(MemberRole.admin.canWriteNotices, isTrue);
    expect(MemberRole.admin.canCreateSchedules, isTrue);
    expect(MemberRole.admin.canConfirmSchedules, isTrue);
    expect(MemberRole.member.canWriteNotices, isFalse);
    expect(MemberRole.member.canCreateSchedules, isFalse);
    expect(MemberRole.member.canConfirmSchedules, isFalse);
  });

  test('현재 모임의 역할이 관리자이면 초대 코드·공지·일정 관리 권한을 허용한다', () {
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

  test('현재 모임의 역할이 구성원이면 초대 코드·공지·일정 관리 권한을 거부한다', () {
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

  test('모임 ID와 구성원의 모임 ID가 다르면 assertion 오류가 발생한다', () {
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
