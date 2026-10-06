// ViewModel 테스트 작성 예시입니다. 새 기능의 테스트를 만들 때 참고하세요.
//
// - Repository 는 mocktail 대신 Fake 클래스를 직접 작성합니다.
// - ProviderContainer 의 overrides 로 Fake 를 주입합니다.
// - 실제 테스트 파일은 lib/ 구조를 따라 test/features/<feature>/... 에 *_test.dart 로 둡니다.
//
// 이 파일은 lib/ 코드를 사용하지 않는 독립된 샘플이므로,
// 필요 없어지면 지워도 됩니다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// --- 테스트 대상 (실제로는 lib/features/<feature>/ 에 위치) ---

abstract interface class GreetingRepository {
  Future<String> fetchGreeting();
}

final greetingRepositoryProvider = Provider<GreetingRepository>(
  (ref) => throw UnimplementedError('테스트에서 override 해서 사용합니다.'),
);

class GreetingViewModel extends AsyncNotifier<String> {
  @override
  Future<String> build() =>
      ref.watch(greetingRepositoryProvider).fetchGreeting();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(greetingRepositoryProvider).fetchGreeting(),
    );
  }
}

final greetingViewModelProvider =
    AsyncNotifierProvider<GreetingViewModel, String>(GreetingViewModel.new);

// --- 테스트용 Fake Repository ---

class FakeGreetingRepository implements GreetingRepository {
  FakeGreetingRepository(this.greeting);

  String greeting;

  @override
  Future<String> fetchGreeting() async => greeting;
}

void main() {
  late FakeGreetingRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeGreetingRepository('안녕하세요');
    container = ProviderContainer(
      overrides: [greetingRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  test('build 시 Repository 의 값을 불러온다', () async {
    final greeting = await container.read(greetingViewModelProvider.future);

    expect(greeting, '안녕하세요');
  });

  test('refresh 하면 최신 값으로 갱신된다', () async {
    await container.read(greetingViewModelProvider.future);
    repository.greeting = '반갑습니다';

    await container.read(greetingViewModelProvider.notifier).refresh();

    expect(container.read(greetingViewModelProvider).value, '반갑습니다');
  });
}
