import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../auth_input_rules.dart';
import '../repositories/auth_repository.dart';

/// ResetPassword 전용 파라미터
final class ResetPasswordParams extends Params {
  const ResetPasswordParams({required this.token, required this.newPassword});

  /// 메일 링크의 token 값
  final String token;
  final String newPassword;

  @override
  List<Object?> get props => [token, newPassword];
}

/// 새 비밀번호 설정 (7-6). 성공하면 모든 기기에서 로그아웃됩니다.
abstract class ResetPassword extends Usecase<void, ResetPasswordParams> {}

final class ResetPasswordImpl implements ResetPassword {
  ResetPasswordImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// 비밀번호 규칙에 맞지 않으면 보내지 않습니다. 비밀번호는 공백을 빼지 않고 그대로 보냅니다.
  @override
  Future<void> call(ResetPasswordParams params) async {
    final error = params.newPassword.passwordError;
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    await _authRepository.resetPassword(
      token: params.token,
      newPassword: params.newPassword,
    );
  }
}
