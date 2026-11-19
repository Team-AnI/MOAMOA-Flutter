import 'package:dio/dio.dart';
import 'package:moamoa/core/network/auth_interceptor.dart';

import '../models/jwt_model.dart';
import '../models/login_request.dart';
import '../models/password_reset_mail_request.dart';
import '../models/password_reset_request.dart';
import '../models/sign_up_request.dart';
import '../models/update_me_request.dart';
import 'auth_remote_data_source.dart';

/// 회원·인증 API 를 Dio 로 호출합니다.
///
/// 로그인 전에 부르는 API(가입·로그인·비밀번호 재설정)는 인증이 필요 없는 요청([noAuthExtra])으로 보냅니다.
/// 내 정보 수정은 로그인한 뒤 부르므로 토큰을 붙여 보냅니다.
/// 실패 응답은 Dio 가 던지는 DioException 을 그대로 Repository 로 전달합니다.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  static final _noAuth = Options(extra: noAuthExtra);

  @override
  Future<JwtModel> signUp(SignUpRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/users',
      data: request.toJson(),
      options: _noAuth,
    );
    return JwtModel.fromJson(_data(response));
  }

  @override
  Future<JwtModel> login(LoginRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/auth/login',
      data: request.toJson(),
      options: _noAuth,
    );
    return JwtModel.fromJson(_data(response));
  }

  @override
  Future<void> requestPasswordReset(PasswordResetMailRequest request) async {
    await _dio.post<Map<String, dynamic>>(
      '/v1/auth/password-reset-requests',
      data: request.toJson(),
      options: _noAuth,
    );
  }

  @override
  Future<void> resetPassword(PasswordResetRequest request) async {
    await _dio.post<Map<String, dynamic>>(
      '/v1/auth/password-resets',
      data: request.toJson(),
      options: _noAuth,
    );
  }

  @override
  Future<void> updateMe(UpdateMeRequest request) async {
    await _dio.patch<Map<String, dynamic>>('/v1/me', data: request.toJson());
  }

  /// 공통 응답 { success, data, error, timestamp } 에서 data 를 꺼냅니다.
  ///
  /// 응답 형식이 다르면 크래시 대신 DioException 을 던져 Repository 에서 처리되게 합니다.
  Map<String, dynamic> _data(Response<Map<String, dynamic>> response) {
    final data = response.data?['data'];
    if (data is! Map<String, dynamic>) {
      throw DioException.badResponse(
        statusCode: response.statusCode ?? 200,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    return data;
  }
}
