import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_group_my_role.dart';

void main() {
  group('noticeWriteAccessProvider', () {
    const roleError = GroupFailure(GroupFailureReason.unavailable);

    ProviderContainer createContainer(FakeGroupMyRole myRole) {
      final container = ProviderContainer(
        overrides: [myRole.override],
        retry: (_, _) => null,
      );
      addTearDown(container.dispose);
      // autoDispose provider 가 응답 도착 전에 정리되지 않도록 구독을 유지합니다.
      container.listen(noticeWriteAccessProvider(1), (_, _) {});
      return container;
    }

    /// 역할 조회가 끝나기를 기다립니다. (실패해도 끝난 것으로 봅니다)
    Future<void> settleRole(ProviderContainer container) async {
      try {
        await container.read(groupMyRoleProvider(1).future);
      } on Object {
        // 실패 상태도 확인 대상이라 여기서는 삼킵니다.
      }
    }

    test('관리자이면 작성할 수 있고 다시 시도 동작은 없다', () async {
      final container = createContainer(FakeGroupMyRole.admin());
      await settleRole(container);

      final access = container.read(noticeWriteAccessProvider(1));

      expect(access.canWrite, isTrue);
      expect(access.retryRole, isNull);
    });

    test('일반 구성원이면 작성할 수 없고 다시 시도 동작은 없다', () async {
      final container = createContainer(FakeGroupMyRole());
      await settleRole(container);

      final access = container.read(noticeWriteAccessProvider(1));

      expect(access.canWrite, isFalse);
      expect(access.retryRole, isNull);
    });

    test('역할을 확인하는 동안에는 작성할 수 없고 다시 시도 동작은 없다', () {
      final pending = Completer<MemberRole>();
      final container = ProviderContainer(
        overrides: [
          groupMyRoleProvider.overrideWith((ref, groupId) => pending.future),
        ],
        retry: (_, _) => null,
      );
      addTearDown(container.dispose);
      container.listen(noticeWriteAccessProvider(1), (_, _) {});

      final access = container.read(noticeWriteAccessProvider(1));

      expect(access.canWrite, isFalse);
      expect(access.retryRole, isNull);
    });

    test('역할 조회에 실패하면 작성할 수 없고 다시 시도 동작이 생긴다', () async {
      final container = createContainer(
        FakeGroupMyRole.admin()..error = roleError,
      );
      await settleRole(container);

      final access = container.read(noticeWriteAccessProvider(1));

      expect(access.canWrite, isFalse);
      expect(access.retryRole, isNotNull);
    });

    test('다시 시도하면 역할을 다시 조회해 성공 시 작성할 수 있게 된다', () async {
      final myRole = FakeGroupMyRole.admin()..error = roleError;
      final container = createContainer(myRole);
      await settleRole(container);
      myRole.error = null;

      container.read(noticeWriteAccessProvider(1)).retryRole!();
      await settleRole(container);

      expect(myRole.requestedGroupIds, [1, 1]);
      final access = container.read(noticeWriteAccessProvider(1));
      expect(access.canWrite, isTrue);
      expect(access.retryRole, isNull);
    });

    group('관리자로 확인된 뒤 역할을 다시 조회할 때', () {
      /// 관리자로 확인을 끝낸 상태에서 시작합니다.
      Future<(ProviderContainer, FakeGroupMyRole)> openAsAdmin() async {
        final myRole = FakeGroupMyRole.admin();
        final container = createContainer(myRole);
        await settleRole(container);
        expect(container.read(noticeWriteAccessProvider(1)).canWrite, isTrue);
        return (container, myRole);
      }

      test('응답을 기다리는 동안에는 이전 관리자 값이 있어도 작성할 수 없다', () async {
        final (container, myRole) = await openAsAdmin();
        myRole.gate = Completer<void>();

        container.invalidate(groupMyRoleProvider(1));

        final access = container.read(noticeWriteAccessProvider(1));
        expect(access.canWrite, isFalse);
        expect(access.retryRole, isNull);
        myRole.gate!.complete();
      });

      test('재조회에 실패하면 이전 관리자 값이 있어도 작성할 수 없고 다시 시도 동작이 생긴다', () async {
        final (container, myRole) = await openAsAdmin();
        myRole.error = roleError;

        container.invalidate(groupMyRoleProvider(1));
        await settleRole(container);

        final access = container.read(noticeWriteAccessProvider(1));
        expect(access.canWrite, isFalse);
        expect(access.retryRole, isNotNull);
      });

      test('재조회 결과가 일반 구성원이면 작성할 수 없다', () async {
        final (container, myRole) = await openAsAdmin();
        myRole.role = MemberRole.member;

        container.invalidate(groupMyRoleProvider(1));
        await settleRole(container);

        final access = container.read(noticeWriteAccessProvider(1));
        expect(access.canWrite, isFalse);
        expect(access.retryRole, isNull);
      });

      test('재조회에 성공하면 다시 작성할 수 있다', () async {
        final (container, myRole) = await openAsAdmin();
        myRole.error = roleError;
        container.invalidate(groupMyRoleProvider(1));
        await settleRole(container);
        myRole.error = null;

        container.invalidate(groupMyRoleProvider(1));
        await settleRole(container);

        final access = container.read(noticeWriteAccessProvider(1));
        expect(access.canWrite, isTrue);
        expect(access.retryRole, isNull);
      });
    });
  });
}
