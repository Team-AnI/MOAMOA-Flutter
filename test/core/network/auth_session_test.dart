import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/network/auth_session.dart';

void main() {
  group(AuthSession, () {
    late ProviderContainer container;

    setUp(() => container = ProviderContainer.test());

    test('처음에는 로그인 필요 상태가 아니다', () {
      expect(container.read(authSessionProvider), AuthSessionStatus.active);
    });

    test('expire 하면 다시 로그인해야 하는 상태가 된다', () {
      container.read(authSessionProvider.notifier).expire();

      expect(container.read(authSessionProvider), AuthSessionStatus.expired);
    });

    test('다시 로그인해 restore 하면 로그인 필요 상태가 풀린다', () {
      final session = container.read(authSessionProvider.notifier)..expire();

      session.restore();

      expect(container.read(authSessionProvider), AuthSessionStatus.active);
    });
  });
}
