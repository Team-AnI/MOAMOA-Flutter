import 'package:dio/dio.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';
import 'package:moamoa/core/storage/token_storage.dart';

import '../../domain/entities/my_account.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/jwt_model.dart';
import '../models/login_request.dart';
import '../models/logout_request.dart';
import '../models/my_account_model.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';
import '../models/profile_color_json.dart';
import '../models/sign_up_request.dart';
import '../models/update_me_request.dart';
import '../models/update_my_profile_request.dart';
import '../models/withdrawal_request.dart';

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
  Future<void> logout() async {
    await _revokeRefreshToken();
    // 서버 요청이 실패해도 이 기기에서는 로그아웃합니다. (7-4: 앱은 저장한 토큰을 모두 지운다)
    // 여기서 지우지 못하면 로그아웃하지 못한 것이므로 오류를 그대로 던집니다.
    await _tokenStorage.clear();
  }

  /// 서버에 이 기기의 리프레시 토큰을 지우라고 요청합니다. 요청이 실패해도 오류를 던지지 않습니다.
  ///
  /// 요청하는 사이 액세스 토큰이 만료돼 `AuthInterceptor` 가 토큰을 재발급하면, 요청 본문에는 재발급으로
  /// 교체된 옛 리프레시 토큰이 남아 새 토큰이 서버에 남습니다. 그래서 요청한 뒤 저장된 토큰이 바뀌었으면
  /// 바뀐 토큰으로 한 번 더 요청합니다.
  Future<void> _revokeRefreshToken() async {
    try {
      for (var attempt = 0; attempt < 2; attempt++) {
        final sent = await _tokenStorage.read();
        if (sent == null) return;
        try {
          await _guard(
            () => _authRemoteDataSource.logout(
              LogoutRequest(refreshToken: sent.refreshToken),
            ),
          );
        } on ApiException {
          // 요청에 실패해도 아래에서 저장된 토큰이 바뀌었는지는 확인합니다.
        }
        final current = await _tokenStorage.read();
        if (current == null || current.refreshToken == sent.refreshToken) {
          return;
        }
      }
    } on Exception {
      // 토큰을 읽지 못해도 이 기기의 토큰은 지웁니다.
    }
  }

  @override
  Future<void> withdraw({required String password}) async {
    await _guard(
      () =>
          _authRemoteDataSource.withdraw(WithdrawalRequest(password: password)),
    );
    await _tokenStorage.clear();
  }

  @override
  Future<MyAccount> getMyAccount() async {
    final model = await _guard(_authRemoteDataSource.getMe);
    return model.toEntity();
  }

  @override
  Future<MyAccount> updateMyProfile({
    required String name,
    required String? phone,
    required ProfileColor color,
  }) async {
    final model = await _guard(
      () => _authRemoteDataSource.updateMyProfile(
        UpdateMyProfileRequest(
          name: name,
          phone: phone,
          profileColor: color.serverValue,
        ),
      ),
    );
    return model.toEntity();
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
