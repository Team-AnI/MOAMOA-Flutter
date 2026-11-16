import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';

/// 회원·인증 화면에서 보여줄 오류 안내
extension AuthErrorMessageX on Object {
  /// 서버 문구가 있으면 그대로, 없으면 기본 문구입니다.
  String get authErrorMessage => switch (this) {
    final ApiException e => e.userMessage,
    _ => ApiErrorCode.unknown.defaultMessage,
  };

  /// 로그인 실패 안내. 서버 문구가 없는 401 이면 이메일·비밀번호를 구분하지 않고 안내합니다. (7-2)
  String get loginErrorMessage => switch (this) {
    ApiException(code: ApiErrorCode.unauthorized, message: null) =>
      '이메일 또는 비밀번호를 확인해 주세요.',
    _ => authErrorMessage,
  };
}
