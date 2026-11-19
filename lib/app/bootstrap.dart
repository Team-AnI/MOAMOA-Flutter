import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/auth_session.dart';
import '../core/network/dio_provider.dart';
import '../core/storage/shared_preferences.dart';
import '../core/storage/token_storage.dart';
import '../core/storage/token_storage_impl.dart';

/// 실행 환경 값. 실행·빌드할 때 `--dart-define` 으로 넘깁니다.
abstract final class AppEnvironment {
  /// 서버 주소 (예: `--dart-define=API_BASE_URL=https://moamoa.aandiclub.com/api`)
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
}

/// 앱을 띄우기 전에 준비할 값을 만들고, ProviderScope 에 넣을 덮어쓰기 목록을 돌려줍니다.
///
/// 앱 전체에 주입하는 값(실행 환경, 저장소 등)은 여기서 한곳에서 관리합니다.
///
/// [tokenStorage] 는 테스트에서 바꿔 끼울 때만 넘깁니다.
Future<List<Override>> bootstrap({TokenStorage? tokenStorage}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final initialAuthStatus = await _initialAuthStatus(
    tokenStorage ??
        TokenStorageImpl(secureStorage: const FlutterSecureStorage()),
  );
  return [
    apiBaseUrlProvider.overrideWithValue(AppEnvironment.apiBaseUrl),
    sharedPreferencesProvider.overrideWithValue(prefs),
    initialAuthStatusProvider.overrideWithValue(initialAuthStatus),
  ];
}

/// 저장된 토큰이 있으면 로그인한 상태로 시작합니다. 읽지 못하면 로그인하지 않은 상태로 시작합니다.
Future<AuthSessionStatus> _initialAuthStatus(TokenStorage tokenStorage) async {
  try {
    final tokens = await tokenStorage.read();
    return tokens == null
        ? AuthSessionStatus.unauthorized
        : AuthSessionStatus.authenticated;
  } on Exception {
    return AuthSessionStatus.unauthorized;
  }
}
