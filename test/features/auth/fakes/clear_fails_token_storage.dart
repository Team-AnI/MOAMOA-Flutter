import 'package:moamoa/core/storage/jwt.dart';
import 'package:moamoa/core/storage/token_storage.dart';

/// 토큰을 지우는 데만 실패하는 테스트용 토큰 저장소
class ClearFailsTokenStorage implements TokenStorage {
  ClearFailsTokenStorage(this._inner);

  final TokenStorage _inner;

  @override
  Future<Jwt?> read() => _inner.read();

  @override
  Future<void> save(Jwt tokens) => _inner.save(tokens);

  @override
  Future<void> clear() => Future.error(Exception('토큰 삭제 실패'));

  @override
  Future<bool> saveIfUnchanged({
    required String refreshToken,
    required Jwt tokens,
  }) => _inner.saveIfUnchanged(refreshToken: refreshToken, tokens: tokens);

  @override
  Future<bool> clearIfUnchanged({required String refreshToken}) =>
      _inner.clearIfUnchanged(refreshToken: refreshToken);
}
