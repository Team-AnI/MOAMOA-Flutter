import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/auth_redirect.dart';

void main() {
  group('AuthRedirectX', () {
    test('로그인하지 않았으면 일반 화면을 로그인 화면으로 보낸다', () {
      expect(AuthSessionStatus.unauthorized.redirectFrom('/groups'), '/login');
    });

    test('다시 로그인해야 하면 일반 화면을 로그인 화면으로 보낸다', () {
      expect(AuthSessionStatus.expired.redirectFrom('/'), '/login');
    });

    for (final path in [
      '/login',
      '/signup',
      '/forgot-password',
      '/reset-password',
    ]) {
      test('로그인하지 않았어도 $path 는 그대로 연다', () {
        expect(AuthSessionStatus.unauthorized.redirectFrom(path), isNull);
      });
    }

    test('로그인하지 않았으면 가입 직후 프로필 설정 화면을 로그인 화면으로 보낸다', () {
      expect(
        AuthSessionStatus.unauthorized.redirectFrom('/profile-setup'),
        '/login',
      );
    });

    test('로그인한 상태에서 로그인 화면을 열면 첫 화면으로 보낸다', () {
      expect(AuthSessionStatus.authenticated.redirectFrom('/login'), '/');
    });

    test('로그인한 상태에서 일반 화면은 그대로 연다', () {
      expect(AuthSessionStatus.authenticated.redirectFrom('/groups'), isNull);
    });

    test('로그인한 상태에서도 메일 링크의 비밀번호 재설정 화면은 그대로 연다', () {
      expect(
        AuthSessionStatus.authenticated.redirectFrom('/reset-password'),
        isNull,
      );
    });

    test('재발급까지 실패한 상태만 다시 로그인해야 하는 상태로 본다', () {
      expect(AuthSessionStatus.expired.needsReLogin, isTrue);
      expect(AuthSessionStatus.unauthorized.needsReLogin, isFalse);
    });
  });
}
