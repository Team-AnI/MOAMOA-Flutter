import 'package:dio/dio.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';
import 'package:moamoa/core/storage/token_storage.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/jwt_model.dart';
import '../models/login_request.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required TokenStorage tokenStorage,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _authRemoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<void> login({required String email, required String password}) async {
    final tokens = await _guard(
      () => _authRemoteDataSource.login(
        LoginRequest(email: email, password: password),
      ),
    );
    await _tokenStorage.save(tokens.toEntity());
  }

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
