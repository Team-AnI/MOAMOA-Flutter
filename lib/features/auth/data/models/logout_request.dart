import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_request.freezed.dart';
part 'logout_request.g.dart';

/// 로그아웃(7-4). [toJson] 은 요청 본문(refreshToken)이 됩니다.
@freezed
abstract class LogoutRequest with _$LogoutRequest {
  const factory LogoutRequest({required String refreshToken}) = _LogoutRequest;

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);
}
