import '../models/jwt_model.dart';
import '../models/login_request.dart';
import '../models/logout_request.dart';
import '../models/my_account_model.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';
import '../models/sign_up_request.dart';
import '../models/update_me_request.dart';
import '../models/update_my_profile_request.dart';
import '../models/withdrawal_request.dart';

abstract interface class AuthRemoteDataSource {
  /// POST /v1/users
  ///
  /// 응답에는 userId·name·email 도 있지만 앱은 토큰만 씁니다.
  Future<JwtModel> signUp(SignUpRequest request);

  /// POST /v1/auth/login
  Future<JwtModel> login(LoginRequest request);

  /// POST /v1/auth/logout
  Future<void> logout(LogoutRequest request);

  /// POST /v1/auth/password-reset-requests
  Future<void> requestPasswordReset(PasswordResetMailRequest request);

  /// POST /v1/auth/password-resets
  Future<void> resetPassword(PasswordResetRequest request);

  /// GET /v1/me
  Future<MyAccountModel> getMe();

  /// PATCH /v1/me (가입 직후 프로필 색만)
  Future<void> updateMe(UpdateMeRequest request);

  /// POST /v1/me/withdrawal
  Future<void> withdraw(WithdrawalRequest request);

  /// PATCH /v1/me (프로필 편집: 이름·휴대폰·프로필 색)
  Future<MyAccountModel> updateMyProfile(UpdateMyProfileRequest request);
}
