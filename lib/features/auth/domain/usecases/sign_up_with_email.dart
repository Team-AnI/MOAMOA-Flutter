import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../auth_input_rules.dart';
import '../repositories/auth_repository.dart';

/// SignUpWithEmail 전용 파라미터
final class SignUpWithEmailParams extends Params {
  const SignUpWithEmailParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.agreedToTerms,
  });

  final String name;
  final String email;
  final String password;

  /// 선택 입력. 비어 있으면 보내지 않습니다.
  final String phone;

  /// 이용약관과 개인정보 처리방침에 모두 동의했는지
  final bool agreedToTerms;

  @override
  List<Object?> get props => [name, email, password, phone, agreedToTerms];
}

/// 회원가입 (7-1). 성공하면 토큰이 저장됩니다.
abstract class SignUpWithEmail extends Usecase<void, SignUpWithEmailParams> {}

final class SignUpWithEmailImpl implements SignUpWithEmail {
  SignUpWithEmailImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// 입력 규칙에 맞지 않거나 약관에 동의하지 않았으면 보내지 않습니다.
  /// 이름·이메일·휴대폰은 앞뒤 공백을 빼고, 비밀번호는 그대로 보냅니다.
  @override
  Future<void> call(SignUpWithEmailParams params) async {
    final error =
        params.name.nameError ??
        params.email.emailError ??
        params.phone.phoneError ??
        params.password.passwordError ??
        (params.agreedToTerms ? null : '이용약관과 개인정보 처리방침에 동의해 주세요.');
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    final phone = params.phone.trim();
    await _authRepository.signUp(
      name: params.name.trim(),
      email: params.email.trim(),
      password: params.password,
      phone: phone.isEmpty ? null : phone,
      agreedToTerms: params.agreedToTerms,
    );
  }
}
