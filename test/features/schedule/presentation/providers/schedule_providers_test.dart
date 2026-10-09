import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderException;
import 'package:flutter_test/flutter_test.dart';
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
}
