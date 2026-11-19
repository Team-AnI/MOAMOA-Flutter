import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../auth_input_rules.dart';
import '../repositories/auth_repository.dart';

/// RequestPasswordReset 전용 파라미터
final class RequestPasswordResetParams extends Params {
  const RequestPasswordResetParams({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

/// 비밀번호 재설정 메일 요청 (7-5)
abstract class RequestPasswordReset
    extends Usecase<void, RequestPasswordResetParams> {}

final class RequestPasswordResetImpl implements RequestPasswordReset {
  RequestPasswordResetImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// 이메일 앞뒤 공백을 빼고 보냅니다. 형식이 다르면 보내지 않습니다.
  @override
  Future<void> call(RequestPasswordResetParams params) async {
    final error = params.email.emailError;
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    await _authRepository.requestPasswordReset(email: params.email.trim());
  }
}
