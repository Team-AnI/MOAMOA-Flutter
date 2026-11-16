import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../auth_input_rules.dart';
import '../repositories/auth_repository.dart';

/// Withdraw 전용 파라미터
final class WithdrawParams extends Params {
  const WithdrawParams({required this.password});

  /// 본인 확인을 위해 다시 입력한 비밀번호
  final String password;

  @override
  List<Object?> get props => [password];
}

/// 회원 탈퇴 (7-9). 성공하면 기기의 토큰이 지워집니다.
abstract class Withdraw extends Usecase<void, WithdrawParams> {}

final class WithdrawImpl implements Withdraw {
  WithdrawImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// 비밀번호가 비었으면 보내지 않습니다. 비밀번호는 그대로 보냅니다.
  @override
  Future<void> call(WithdrawParams params) async {
    final error = params.password.loginPasswordError;
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    await _authRepository.withdraw(password: params.password);
  }
}
