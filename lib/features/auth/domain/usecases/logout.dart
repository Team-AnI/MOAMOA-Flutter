import 'package:moamoa/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

/// 로그아웃 (7-4). 서버 요청이 실패해도 이 기기의 토큰은 지웁니다.
abstract class Logout extends Usecase<void, NoParams> {}

final class LogoutImpl implements Logout {
  LogoutImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<void> call(NoParams params) => _authRepository.logout();
}
