import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/storage/auth_tokens.dart';
import 'package:moamoa/core/storage/token_storage.dart';

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

    test('리프레시 토큰만 없으면 null 을 돌려준다', () async {
      FlutterSecureStorage.setMockInitialValues({'auth.accessToken': 'access'});

      expect(await storage.read(), isNull);
    });

    test('지우면 다시 읽었을 때 null 을 돌려준다', () async {
      await storage.save(tokens);

      await storage.clear();

      expect(await storage.read(), isNull);
    });
  });
}
