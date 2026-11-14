import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt.freezed.dart';

/// 로그인·회원가입·토큰 재발급 응답으로 받은 토큰 (API 7-1·7-2·7-3)
@freezed
abstract class Jwt with _$Jwt {
  const factory Jwt({
    required String accessToken,
    required String refreshToken,
  }) = _Jwt;
}
