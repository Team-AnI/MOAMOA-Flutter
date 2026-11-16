import 'package:moamoa/core/usecases/usecase.dart';

import '../entities/my_account.dart';
import '../repositories/auth_repository.dart';

/// 내 정보 조회 (7-7)
abstract class GetMyAccount extends Usecase<MyAccount, NoParams> {}

final class GetMyAccountImpl implements GetMyAccount {
  GetMyAccountImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<MyAccount> call(NoParams params) => _authRepository.getMyAccount();
}
