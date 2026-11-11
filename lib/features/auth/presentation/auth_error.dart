import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';

/// 회원·인증 화면에서 보여줄 오류 안내
extension AuthErrorMessageX on Object {
  /// 서버 문구가 있으면 그대로, 없으면 기본 문구입니다.
  String get authErrorMessage => switch (this) {
    final ApiException e => e.userMessage,
    _ => ApiErrorCode.unknown.defaultMessage,
  };
}
