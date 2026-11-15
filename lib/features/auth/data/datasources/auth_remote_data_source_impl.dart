import 'package:dio/dio.dart';

import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';
import 'auth_remote_data_source.dart';

/// 회원·인증 API 를 Dio 로 호출합니다.
///
/// 실패 응답은 Dio 가 던지는 DioException 을 그대로 Repository 로 전달합니다.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> requestPasswordReset(PasswordResetMailRequest request) async {
    await _dio.post<Map<String, dynamic>>(
      '/v1/auth/password-reset-requests',
      data: request.toJson(),
    );
  }

  @override
  Future<void> resetPassword(PasswordResetRequest request) async {
    await _dio.post<Map<String, dynamic>>(
      '/v1/auth/password-resets',
      data: request.toJson(),
    );
  }
}
