import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/storage/auth_tokens.dart';
import 'package:moamoa/core/storage/token_storage.dart';

/// 쓰기만 실패하는 secure storage
class _WriteFailingSecureStorage extends FlutterSecureStorage {
  const _WriteFailingSecureStorage();

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    throw PlatformException(code: 'write-failed');
  }
}

void main() {
  group(TokenStorage, () {
    const tokens = AuthTokens(accessToken: 'access', refreshToken: 'refresh');
    late TokenStorage storage;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      storage = const TokenStorage(secureStorage: FlutterSecureStorage());
    });

    test('저장한 토큰을 그대로 읽는다', () async {
      await storage.save(tokens);

      expect(await storage.read(), tokens);
    });

    test('저장한 적이 없으면 null 을 돌려준다', () async {
      expect(await storage.read(), isNull);
    });

    test('저장된 값에 리프레시 토큰이 없으면 null 을 돌려준다', () async {
      FlutterSecureStorage.setMockInitialValues({
        'auth.tokens': '{"accessToken": "access"}',
      });

      expect(await storage.read(), isNull);
    });

    test('저장된 값이 JSON 이 아니면 null 을 돌려준다', () async {
      FlutterSecureStorage.setMockInitialValues({'auth.tokens': 'broken'});

      expect(await storage.read(), isNull);
    });

    test('두 토큰을 한 번의 쓰기로 함께 저장한다', () async {
      await storage.save(tokens);

      expect(await const FlutterSecureStorage().readAll(), hasLength(1));
    });

    test('새 토큰 저장이 실패하면 이전 토큰 쌍이 그대로 남는다', () async {
      await storage.save(tokens);
      const failing = TokenStorage(secureStorage: _WriteFailingSecureStorage());

      await expectLater(
        failing.save(
          const AuthTokens(accessToken: 'access-b', refreshToken: 'refresh-b'),
        ),
        throwsA(isA<PlatformException>()),
      );

      expect(await storage.read(), tokens);
    });

    test('지우면 다시 읽었을 때 null 을 돌려준다', () async {
      await storage.save(tokens);

      await storage.clear();

      expect(await storage.read(), isNull);
    });
  });
}
