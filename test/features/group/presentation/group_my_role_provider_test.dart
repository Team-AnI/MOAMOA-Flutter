import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../fake_group_repository.dart';

/// 모임 조회 응답을 직접 끝낼 때까지 붙잡아 두는 Repository
class _PendingGroupRepository extends FakeGroupRepository {
  final pendingGet = Completer<CurrentGroup>();

  @override
  Future<CurrentGroup> getGroup(int groupId) => pendingGet.future;
}

/// 모임 조회가 실패하는 Repository. 요청받은 모임 ID를 기록합니다.
class _FailingGroupRepository extends FakeGroupRepository {
  int? requestedGroupId;

  @override
  Future<CurrentGroup> getGroup(int groupId) async {
    requestedGroupId = groupId;
    throw const GroupFailure(GroupFailureReason.unavailable);
  }
}

void main() {
  group('모임 내 역할', () {
    ProviderContainer createContainer(
      GroupRepository repository, {
      int groupId = 1,
    }) {
      final container = ProviderContainer(
        overrides: [groupRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      addTearDown(container.dispose);
      // autoDispose provider 가 응답 도착 전에 정리되지 않도록 구독을 유지합니다.
      container.listen(groupMyRoleProvider(groupId), (_, _) {});
      return container;
    }

    test('관리자인 모임이면 관리자 역할을 돌려준다', () async {
      final repository = FakeGroupRepository()
        ..groups = [makeGroup(MemberRole.admin)];
      final container = createContainer(repository);

      final role = await container.read(groupMyRoleProvider(1).future);

      expect(role, MemberRole.admin);
    });

    test('일반 구성원인 모임이면 일반 구성원 역할을 돌려준다', () async {
      final repository = FakeGroupRepository()
        ..groups = [makeGroup(MemberRole.member)];
      final container = createContainer(repository);

      final role = await container.read(groupMyRoleProvider(1).future);

      expect(role, MemberRole.member);
    });

    test('응답을 기다리는 동안에는 역할 없이 로딩 상태이다', () {
      final container = createContainer(_PendingGroupRepository());

      final role = container.read(groupMyRoleProvider(1));

      expect(role.isLoading, isTrue);
      expect(role.hasValue, isFalse);
    });

    test('모임을 불러오지 못하면 일반 구성원이 아니라 오류 상태이다', () async {
      final repository = _FailingGroupRepository();
      final container = createContainer(repository);

      await expectLater(
        container.read(groupMyRoleProvider(1).future),
        throwsA(isA<GroupFailure>()),
      );

      final role = container.read(groupMyRoleProvider(1));
      expect(role.hasError, isTrue);
      expect(role.error, isA<GroupFailure>());
      expect(role.hasValue, isFalse);
    });

    test('요청한 모임 ID로 모임을 조회한다', () async {
      final repository = _FailingGroupRepository();
      final container = createContainer(repository, groupId: 7);

      await expectLater(
        container.read(groupMyRoleProvider(7).future),
        throwsA(isA<GroupFailure>()),
      );

      expect(repository.requestedGroupId, 7);
    });
  });
}
