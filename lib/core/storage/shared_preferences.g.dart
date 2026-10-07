// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 일반 설정 값 저장소
///
/// 앱 시작 전에 `main()` 에서 인스턴스를 미리 불러와 `ProviderScope` 의
/// `overrides` 로 주입하므로, 이후에는 동기적으로 사용할 수 있습니다.
/// 테스트에서도 `overrideWithValue` 로 주입해야 합니다.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// 일반 설정 값 저장소
///
/// 앱 시작 전에 `main()` 에서 인스턴스를 미리 불러와 `ProviderScope` 의
/// `overrides` 로 주입하므로, 이후에는 동기적으로 사용할 수 있습니다.
/// 테스트에서도 `overrideWithValue` 로 주입해야 합니다.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// 일반 설정 값 저장소
  ///
  /// 앱 시작 전에 `main()` 에서 인스턴스를 미리 불러와 `ProviderScope` 의
  /// `overrides` 로 주입하므로, 이후에는 동기적으로 사용할 수 있습니다.
  /// 테스트에서도 `overrideWithValue` 로 주입해야 합니다.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'0755e33905db7a25ff88f031a29d11b5be2a199a';
