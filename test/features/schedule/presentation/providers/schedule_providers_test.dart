import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderException;
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

void main() {
  test('API 구현체가 연결되기 전에는 Repository 를 override 하지 않으면 읽을 수 없다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      () => container.read(scheduleRepositoryProvider),
      throwsA(
        isA<ProviderException>().having(
          (e) => e.exception,
          'exception',
          isA<UnimplementedError>(),
        ),
      ),
    );
  });

  group('scheduleAdminProvider', () {
    ProviderContainer containerWith(Future<MemberRole> Function() role) {
      final container = ProviderContainer(
        overrides: [groupMyRoleProvider.overrideWith((ref, groupId) => role())],
      );
      addTearDown(container.dispose);
      // 화면이 구독하는 것처럼 유지한다. (autoDispose)
      container.listen(scheduleAdminProvider(1), (_, _) {});
      return container;
    }

    test('모임 관리자이면 true 가 된다', () async {
      final container = containerWith(() async => MemberRole.admin);

      await container.read(groupMyRoleProvider(1).future);

      expect(container.read(scheduleAdminProvider(1)), isTrue);
    });

    test('일반 구성원이면 false 가 된다', () async {
      final container = containerWith(() async => MemberRole.member);

      await container.read(groupMyRoleProvider(1).future);

      expect(container.read(scheduleAdminProvider(1)), isFalse);
    });

    test('역할을 확인하는 중이면 false 로 보고 버튼을 숨긴다', () {
      final pending = Completer<MemberRole>();
      final container = containerWith(() => pending.future);

      expect(container.read(scheduleAdminProvider(1)), isFalse);
    });
  });
}
