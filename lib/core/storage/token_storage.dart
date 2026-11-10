import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_tokens.dart';
import 'secure_storage.dart';

/// 액세스·리프레시 토큰을 기기의 안전한 저장소에 보관합니다.
///
/// 로그인·회원가입·재발급 때 저장하고, 로그아웃·탈퇴·재발급 실패 때 지웁니다.
/// 두 토큰을 한 값으로 묶어 저장해, 저장이 중간에 실패해도 서로 다른 토큰 쌍이 남지 않습니다.
/// 저장·삭제는 하나씩 차례로 실행해, 재발급과 로그인·로그아웃이 겹쳐도 서로 덮어쓰지 않습니다.
class TokenStorage {
  TokenStorage({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  static const _tokensKey = 'auth.tokens';
  static const _accessTokenField = 'accessToken';
  static const _refreshTokenField = 'refreshToken';

  final FlutterSecureStorage _secureStorage;

  /// 마지막으로 맡은 저장·삭제. 다음 작업은 이 작업이 끝난 뒤 시작합니다.
  Future<void> _pending = Future<void>.value();

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

  Future<void> save(AuthTokens tokens) => _serialize(() => _write(tokens));

  Future<void> clear() => _serialize(_delete);

  /// 저장된 리프레시 토큰이 [refreshToken] 그대로일 때만 [tokens] 로 바꿉니다. 바꿨으면 true 입니다.
  ///
  /// 재발급하는 사이 로그아웃하거나 다른 계정으로 로그인했으면 그 상태를 덮어쓰지 않습니다.
  Future<bool> saveIfUnchanged({
    required String refreshToken,
    required AuthTokens tokens,
  }) {
    return _serialize(() => _replaceIfUnchanged(refreshToken, tokens));
  }

  /// 저장된 리프레시 토큰이 [refreshToken] 그대로일 때만 지웁니다. 지웠으면 true 입니다.
  Future<bool> clearIfUnchanged({required String refreshToken}) {
    return _serialize(() => _replaceIfUnchanged(refreshToken, null));
  }

  /// [tokens] 가 null 이면 지웁니다.
  Future<bool> _replaceIfUnchanged(
    String refreshToken,
    AuthTokens? tokens,
  ) async {
    final current = await read();
    if (current?.refreshToken != refreshToken) return false;
    if (tokens == null) {
      await _delete();
    } else {
      await _write(tokens);
    }
    return true;
  }

  Future<T> _serialize<T>(Future<T> Function() action) {
    final result = _pending.then((_) => action());
    // 앞 작업이 실패해도 다음 작업은 이어서 실행합니다.
    _pending = result.then<void>((_) {}, onError: (_) {});
    return result;
  }

  Future<void> _write(AuthTokens tokens) {
    return _secureStorage.write(
      key: _tokensKey,
      value: jsonEncode({
        _accessTokenField: tokens.accessToken,
        _refreshTokenField: tokens.refreshToken,
      }),
    );
  }

  Future<void> _delete() => _secureStorage.delete(key: _tokensKey);
}

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(secureStorage: ref.watch(secureStorageProvider)),
);
