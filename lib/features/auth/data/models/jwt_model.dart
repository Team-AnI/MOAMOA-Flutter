import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/storage/jwt.dart';

part 'jwt_model.freezed.dart';
part 'jwt_model.g.dart';

/// 로그인(7-2) 응답의 토큰
@freezed
abstract class JwtModel with _$JwtModel {
  const factory JwtModel({
    required String accessToken,
    required String refreshToken,
  }) = _JwtModel;

  factory JwtModel.fromJson(Map<String, dynamic> json) =>
      _$JwtModelFromJson(json);
}

/// 응답 모델을 토큰 저장소에 저장할 값으로 바꿉니다.
extension JwtModelX on JwtModel {
  Jwt toEntity() => Jwt(accessToken: accessToken, refreshToken: refreshToken);
}
