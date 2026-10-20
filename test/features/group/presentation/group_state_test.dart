import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group_failure_reason.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_state.dart';

import '../fake_group_repository.dart';

void main() {
  group('GroupState', () {
    test('모든 필드와 모임 목록의 내용이 같으면 같은 상태로 비교한다', () {
      final first = GroupState(groups: [makeGroup(MemberRole.admin)]);
      final same = GroupState(groups: [makeGroup(MemberRole.admin)]);
      expect(first, same);
      expect(first.hashCode, same.hashCode);
      expect(first.copyWith(isLoading: true), isNot(first));
    });
    test('copyWith로 선택 모임과 오류를 null로 지우면 원본은 유지한다', () {
      final current = makeGroup(MemberRole.admin);
      final original = GroupState(
        currentGroup: current,
        errorMessage: '오류',
        failureReason: GroupFailureReason.unavailable,
      );
      final cleared = original.copyWith(
        currentGroup: null,
        errorMessage: null,
        failureReason: null,
      );
      expect(cleared.currentGroup, isNull);
      expect(cleared.errorMessage, isNull);
      expect(cleared.failureReason, isNull);
      expect(original.currentGroup, current);
      expect(original.errorMessage, '오류');
      expect(cleared, isNot(original));
    });
    test('상태를 통해 모임 목록을 변경할 수 없다', () {
      final state = GroupState(groups: [makeGroup(MemberRole.admin)]);
      expect(() => state.groups.clear(), throwsUnsupportedError);
    });
  });
}
