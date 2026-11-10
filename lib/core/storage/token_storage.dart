import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_tokens.dart';
import 'secure_storage.dart';

/// 액세스·리프레시 토큰을 기기의 안전한 저장소에 보관합니다.
///
/// 로그인·회원가입·재발급 때 저장하고, 로그아웃·탈퇴·재발급 실패 때 지웁니다.
/// 두 토큰을 한 값으로 묶어 저장해, 저장이 중간에 실패해도 서로 다른 토큰 쌍이 남지 않습니다.
class TokenStorage {
  const TokenStorage({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  static const _tokensKey = 'auth.tokens';
  static const _accessTokenField = 'accessToken';
  static const _refreshTokenField = 'refreshToken';

  final FlutterSecureStorage _secureStorage;

  /// 저장된 토큰. 없거나 저장된 값의 형식이 다르면 null 입니다.
  Future<AuthTokens?> read() async {
    final saved = await _secureStorage.read(key: _tokensKey);
    if (saved == null) return null;
    try {
      final json = jsonDecode(saved);
      if (json is! Map) return null;
      final accessToken = json[_accessTokenField];
      final refreshToken = json[_refreshTokenField];
      if (accessToken is! String || refreshToken is! String) return null;
      return AuthTokens(accessToken: accessToken, refreshToken: refreshToken);
    } on FormatException {
      return null;
    }
  }

  Future<void> save(AuthTokens tokens) {
    return _secureStorage.write(
      key: _tokensKey,
      value: jsonEncode({
        _accessTokenField: tokens.accessToken,
        _refreshTokenField: tokens.refreshToken,
      }),
    );
  }

  Future<void> clear() => _secureStorage.delete(key: _tokensKey);
}

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(secureStorage: ref.watch(secureStorageProvider)),
);
