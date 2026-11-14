import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'jwt.dart';
import 'secure_storage.dart';
import 'token_storage_impl.dart';

/// 액세스·리프레시 토큰 저장소
///
/// 로그인·회원가입·재발급 때 저장하고, 로그아웃·탈퇴·재발급 실패 때 지웁니다.
/// 구현을 바꿔 끼울 수 있도록(테스트용 저장소 등) 추상 클래스로 둡니다. 기본 구현은 [TokenStorageImpl] 입니다.
abstract interface class TokenStorage {
  /// 저장된 토큰. 없거나 저장된 값의 형식이 다르면 null 입니다.
  Future<Jwt?> read();

  Future<void> save(Jwt tokens);

  Future<void> clear();

  /// 저장된 리프레시 토큰이 [refreshToken] 그대로일 때만 [tokens] 로 바꿉니다. 바꿨으면 true 입니다.
  ///
  /// 재발급하는 사이 로그아웃하거나 다른 계정으로 로그인했으면 그 상태를 덮어쓰지 않습니다.
  Future<bool> saveIfUnchanged({
    required String refreshToken,
    required Jwt tokens,
  });

  /// 저장된 리프레시 토큰이 [refreshToken] 그대로일 때만 지웁니다. 지웠으면 true 입니다.
  Future<bool> clearIfUnchanged({required String refreshToken});
}

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorageImpl(secureStorage: ref.watch(secureStorageProvider)),
);
