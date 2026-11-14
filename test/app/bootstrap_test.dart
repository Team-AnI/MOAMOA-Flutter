import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/bootstrap.dart';
import 'package:moamoa/core/network/dio_provider.dart';
import 'package:moamoa/core/storage/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('bootstrap', () {
    setUp(() => SharedPreferences.setMockInitialValues({'seen': true}));

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
