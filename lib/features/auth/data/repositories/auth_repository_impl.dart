import 'package:dio/dio.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';
import 'package:moamoa/core/storage/token_storage.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/jwt_model.dart';
import '../models/login_request.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';
import '../models/profile_color_json.dart';
import '../models/sign_up_request.dart';
import '../models/update_me_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required TokenStorage tokenStorage,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _authRemoteDataSource;
  final TokenStorage _tokenStorage;

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    String? phone,
    required bool agreedToTerms,
  }) async {
    final tokens = await _guard(
      () => _authRemoteDataSource.signUp(
        SignUpRequest(
          name: name,
          email: email,
          password: password,
          phone: phone,
          agreedToTerms: agreedToTerms,
        ),
      ),
    );
    await _tokenStorage.save(tokens.toEntity());
  }

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
  }) async {
    await _guard(
      () => _authRemoteDataSource.resetPassword(
        PasswordResetRequest(token: token, newPassword: newPassword),
      ),
    );
    // 새 비밀번호로 다시 로그인하도록, 이 기기에 로그인해 있었으면 토큰을 지웁니다.
    await _tokenStorage.clear();
  }

  @override
  Future<void> updateProfileColor({required ProfileColor color}) {
    return _guard(
      () => _authRemoteDataSource.updateMe(
        UpdateMeRequest(profileColor: color.serverValue),
      ),
    );
  }

  /// Dio 오류와 응답 해석 실패를 공통 예외 ApiException 으로 바꿉니다.
  ///
  /// 성공 응답의 필드가 빠졌거나 타입이 다르면 fromJson 이 TypeError·FormatException 을 던지므로
  /// unknown 으로 바꿔 화면이 요청 중 상태에 머물지 않게 합니다.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw e.toApiException();
    } on FormatException {
      throw const ApiException(code: ApiErrorCode.unknown);
    } on TypeError {
      throw const ApiException(code: ApiErrorCode.unknown);
    }
  }
}
