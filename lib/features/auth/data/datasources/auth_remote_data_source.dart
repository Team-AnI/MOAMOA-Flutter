import '../models/jwt_model.dart';
import '../models/login_request.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';

abstract interface class AuthRemoteDataSource {
  /// POST /v1/auth/login
  Future<JwtModel> login(LoginRequest request);

  /// POST /v1/auth/password-reset-requests
  Future<void> requestPasswordReset(PasswordResetMailRequest request);

  /// POST /v1/auth/password-resets
  Future<void> resetPassword(PasswordResetRequest request);
}
