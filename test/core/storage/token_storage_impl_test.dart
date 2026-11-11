import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/storage/auth_tokens.dart';
import 'package:moamoa/core/storage/token_storage_impl.dart';

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
  group(TokenStorageImpl, () {
    const tokens = AuthTokens(accessToken: 'access', refreshToken: 'refresh');
    late TokenStorageImpl storage;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      storage = TokenStorageImpl(secureStorage: const FlutterSecureStorage());
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
      final failing = TokenStorageImpl(
        secureStorage: const _WriteFailingSecureStorage(),
      );

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

    group('saveIfUnchanged', () {
      const next = AuthTokens(
        accessToken: 'access-2',
        refreshToken: 'refresh-2',
      );

      test('저장된 리프레시 토큰이 같으면 새 토큰으로 바꾼다', () async {
        await storage.save(tokens);

        final saved = await storage.saveIfUnchanged(
          refreshToken: 'refresh',
          tokens: next,
        );

        expect(saved, isTrue);
        expect(await storage.read(), next);
      });

      test('저장된 리프레시 토큰이 다르면 바꾸지 않는다', () async {
        await storage.save(tokens);

        final saved = await storage.saveIfUnchanged(
          refreshToken: 'refresh-old',
          tokens: next,
        );

        expect(saved, isFalse);
        expect(await storage.read(), tokens);
      });

      test('지운 뒤에는 새 토큰을 저장하지 않는다', () async {
        final saved = await storage.saveIfUnchanged(
          refreshToken: 'refresh',
          tokens: next,
        );

        expect(saved, isFalse);
        expect(await storage.read(), isNull);
      });
    });

    group('clearIfUnchanged', () {
      test('저장된 리프레시 토큰이 같으면 지운다', () async {
        await storage.save(tokens);

        final cleared = await storage.clearIfUnchanged(refreshToken: 'refresh');

        expect(cleared, isTrue);
        expect(await storage.read(), isNull);
      });

      test('저장된 리프레시 토큰이 다르면 지우지 않는다', () async {
        await storage.save(tokens);

        final cleared = await storage.clearIfUnchanged(
          refreshToken: 'refresh-old',
        );

        expect(cleared, isFalse);
        expect(await storage.read(), tokens);
      });
    });

    test('바꾸는 중에 지우면 바꾼 뒤에 지워 토큰이 남지 않는다', () async {
      await storage.save(tokens);

      final saving = storage.saveIfUnchanged(
        refreshToken: 'refresh',
        tokens: const AuthTokens(
          accessToken: 'access-2',
          refreshToken: 'refresh-2',
        ),
      );
      final clearing = storage.clear();
      await Future.wait([saving, clearing]);

      expect(await storage.read(), isNull);
    });
  });
}
