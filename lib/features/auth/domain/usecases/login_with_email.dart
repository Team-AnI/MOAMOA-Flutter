import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../auth_input_rules.dart';
import '../repositories/auth_repository.dart';

/// LoginWithEmail 전용 파라미터
final class LoginWithEmailParams extends Params {
  const LoginWithEmailParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// 이메일·비밀번호 로그인 (7-2). 성공하면 토큰이 저장됩니다.
abstract class LoginWithEmail extends Usecase<void, LoginWithEmailParams> {}

final class LoginWithEmailImpl implements LoginWithEmail {
  LoginWithEmailImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// 이메일 형식이 다르거나 비밀번호가 비었으면 보내지 않습니다.
  /// 이메일은 앞뒤 공백을 빼고, 비밀번호는 그대로 보냅니다.
  @override
  Future<void> call(LoginWithEmailParams params) async {
    final error = params.email.emailError ?? params.password.loginPasswordError;
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    await _authRepository.login(
      email: params.email.trim(),
      password: params.password,
    );
  }
}
