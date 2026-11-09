import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_tokens.dart';
import 'secure_storage.dart';

/// 액세스·리프레시 토큰을 기기의 안전한 저장소에 보관합니다.
///
/// 로그인·회원가입·재발급 때 저장하고, 로그아웃·탈퇴·재발급 실패 때 지웁니다.
class TokenStorage {
  const TokenStorage({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  static const _accessTokenKey = 'auth.accessToken';
  static const _refreshTokenKey = 'auth.refreshToken';

  final FlutterSecureStorage _secureStorage;

  /// 저장된 토큰. 둘 중 하나라도 없으면 null 입니다.
  Future<AuthTokens?> read() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    final refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    if (accessToken == null || refreshToken == null) return null;
    return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<void> save(AuthTokens tokens) async {
    await _secureStorage.write(key: _accessTokenKey, value: tokens.accessToken);
    await _secureStorage.write(
      key: _refreshTokenKey,
      value: tokens.refreshToken,
    );
  }

  Future<void> clear() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(secureStorage: ref.watch(secureStorageProvider)),
);
