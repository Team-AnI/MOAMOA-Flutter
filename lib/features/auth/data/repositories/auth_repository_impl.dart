import 'package:dio/dio.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
    : _authRemoteDataSource = authRemoteDataSource;

  final AuthRemoteDataSource _authRemoteDataSource;

  @override
  Future<void> requestPasswordReset({required String email}) {
    return _guard(
      () => _authRemoteDataSource.requestPasswordReset(
        PasswordResetMailRequest(email: email),
      ),
    );
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) {
    return _guard(
      () => _authRemoteDataSource.resetPassword(
        PasswordResetRequest(token: token, newPassword: newPassword),
      ),
    );
  }

  /// Dio 오류를 공통 예외 ApiException 으로 바꿉니다.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw e.toApiException();
    }
  }
}
