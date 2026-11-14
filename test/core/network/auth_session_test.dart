import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/network/auth_session.dart';

void main() {
  group(AuthSession, () {
    late ProviderContainer container;

    setUp(() => container = ProviderContainer.test());

    AuthSession session() => container.read(authSessionProvider.notifier);

    test('처음에는 로그인하지 않은 상태로 시작한다', () {
      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('authenticate 하면 로그인한 상태가 된다', () {
      session().authenticate();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('로그인한 뒤 expire 하면 다시 로그인해야 하는 상태가 된다', () {
      session()
        ..authenticate()
        ..expire();

      expect(container.read(authSessionProvider), AuthSessionStatus.expired);
    });

    test('만료된 뒤 다시 authenticate 하면 로그인한 상태가 된다', () {
      session()
        ..expire()
        ..authenticate();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('로그인한 뒤 signOut 하면 로그인하지 않은 상태가 된다', () {
      session()
        ..authenticate()
        ..signOut();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });
  });
}
