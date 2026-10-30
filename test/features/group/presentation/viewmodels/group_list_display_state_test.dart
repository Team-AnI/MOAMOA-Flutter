import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/group_member.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_list_display_state.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_list_preferences.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_state.dart';

CurrentGroup _group(int id, MemberRole role) => CurrentGroup(
  group: Group(id: id, name: '모임 $id'),
  membership: GroupMember(groupId: id, role: role),
);

void main() {
  group('모임 목록 표시 상태', () {
    final groups = [
      _group(1, MemberRole.admin),
      _group(2, MemberRole.member),
      _group(3, MemberRole.admin),
      _group(4, MemberRole.member),
    ];
    List<int> ids(List<CurrentGroup> values) =>
        values.map((g) => g.group.id).toList();

    test('고정 모임을 역할별 기본 목록 앞에 두고 관리 목록은 지정 순서를 유지한다', () {
      final state = GroupListDisplayState(
        source: GroupState(groups: groups),
        preferences: const GroupListPreferences(
          pinnedIds: [3, 4],
          orderedIds: [1, 2, 3, 4],
        ),
      );
      expect(ids(state.adminGroups), [3, 1]);
      expect(ids(state.memberGroups), [4, 2]);
      expect(ids(state.manageAdminGroups), [1, 3]);
      expect(ids(state.manageMemberGroups), [2, 4]);
    });

    test('보관한 모임을 표시 목록에서 제외하고 존재하는 보관 모임만 집계한다', () {
      final source = GroupState(groups: groups);
      final state = GroupListDisplayState(
        source: source,
        preferences: const GroupListPreferences(archivedIds: [1, 4, 999]),
      );
      expect(ids(state.visibleGroups), [2, 3]);
      expect(ids(state.archivedAdminGroups), [1]);
      expect(ids(state.archivedMemberGroups), [4]);
      expect(state.archivedCount, 2);
      expect(state.showAllArchived, isFalse);
      expect(ids(source.groups), [1, 2, 3, 4]);
      expect(source.groups[0].membership.role, MemberRole.admin);
    });

    test('전체 보관 안내는 원본 모임이 있고 로딩과 오류가 없을 때만 표시한다', () {
      final state = GroupListDisplayState(
        source: GroupState(groups: groups),
        preferences: const GroupListPreferences(archivedIds: [1, 2, 3, 4]),
      );
      expect(state.showAllArchived, isTrue);
      expect(state.isManageEmpty, isTrue);
      expect(state.isArchiveEmpty, isFalse);
      expect(state.showEmpty, isFalse);
      expect(
        state
            .copyWith(source: state.source.copyWith(isLoading: true))
            .showAllArchived,
        isFalse,
      );
      expect(
        state
            .copyWith(source: state.source.copyWith(errorMessage: '실패'))
            .showAllArchived,
        isFalse,
      );
      expect(
        state.copyWith(source: const GroupState()).showAllArchived,
        isFalse,
      );
      expect(state.copyWith(source: const GroupState()).showEmpty, isTrue);
    });

    test('관리자 목록이 보관되어 비면 구성원 섹션의 첫 여백을 적용한다', () {
      final state = GroupListDisplayState(
        source: GroupState(groups: groups),
        preferences: const GroupListPreferences(archivedIds: [1, 3]),
      );
      expect(state.memberSectionPadding, 20);
      expect(state.manageMemberSectionPadding, 4);
      expect(state.archivedMemberSectionPadding, 16);
      expect(
        state
            .copyWith(
              preferences: const GroupListPreferences(archivedIds: [2, 4]),
            )
            .archivedMemberSectionPadding,
        4,
      );
    });

    test('공백 이름은 기본 인사말로 표시하고 복원하면 원래 목록에 다시 포함한다', () {
      final state = GroupListDisplayState(
        source: GroupState(groups: groups),
        preferences: const GroupListPreferences(archivedIds: [1]),
        userName: '   ',
      );
      expect(state.greeting, '안녕하세요');
      expect(state.copyWith(userName: ' 성은 ').greeting, '성은님, 안녕하세요');
      final restored = state.copyWith(
        preferences: const GroupListPreferences(),
      );
      expect(restored.archivedCount, 0);
      expect(ids(restored.adminGroups), [1, 3]);
      expect(restored.menuSubtitle(groups.first), '관리자');
    });
  });
}
