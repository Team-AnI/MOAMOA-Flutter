import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_tokens.freezed.dart';

/// 로그인·회원가입·토큰 재발급 응답으로 받은 토큰 (API 7-1·7-2·7-3)
@freezed
abstract class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokens;
}
