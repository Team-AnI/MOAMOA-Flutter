import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/bootstrap.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/core/network/dio_provider.dart';
import 'package:moamoa/core/storage/jwt.dart';
import 'package:moamoa/core/storage/shared_preferences.dart';
import 'package:moamoa/core/storage/token_storage.dart';
import 'package:moamoa/core/storage/token_storage_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 읽기에 실패하는 토큰 저장소
class _BrokenTokenStorage implements TokenStorage {
  @override
  Future<Jwt?> read() => throw Exception('저장소 오류');

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('bootstrap', () {
    late TokenStorage storage;

    setUp(() {
      SharedPreferences.setMockInitialValues({'seen': true});
      FlutterSecureStorage.setMockInitialValues({});
      storage = TokenStorageImpl(secureStorage: const FlutterSecureStorage());
    });

    test('저장된 토큰이 있으면 로그인한 상태로 시작한다', () async {
      await storage.save(
        const Jwt(accessToken: 'access', refreshToken: 'refresh'),
      );

      final container = ProviderContainer.test(
        overrides: await bootstrap(tokenStorage: storage),
      );

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('저장된 토큰이 없으면 로그인하지 않은 상태로 시작한다', () async {
      final container = ProviderContainer.test(
        overrides: await bootstrap(tokenStorage: storage),
      );

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('토큰을 읽지 못하면 로그인하지 않은 상태로 시작한다', () async {
      final container = ProviderContainer.test(
        overrides: await bootstrap(tokenStorage: _BrokenTokenStorage()),
      );

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('서버 주소를 실행 환경 값으로 주입한다', () async {
      final container = ProviderContainer.test(overrides: await bootstrap());

      expect(container.read(apiBaseUrlProvider), AppEnvironment.apiBaseUrl);
    });

    test('기기 저장소(SharedPreferences)를 주입한다', () async {
      final container = ProviderContainer.test(overrides: await bootstrap());

      expect(container.read(sharedPreferencesProvider).getBool('seen'), isTrue);
    });
  });

  group('dioProvider', () {
    test('주입받은 서버 주소를 기본 주소로 쓴다', () {
      final container = ProviderContainer.test(
        overrides: [
          apiBaseUrlProvider.overrideWithValue('https://api.example.com'),
        ],
      );

      expect(
        container.read(dioProvider).options.baseUrl,
        'https://api.example.com',
      );
    });
  });
}
