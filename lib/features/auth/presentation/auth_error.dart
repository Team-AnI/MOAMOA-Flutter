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

  /// 회원 탈퇴 실패 안내. 서버 문구가 없으면 비밀번호 오류(400)·탈퇴할 수 없음(422)을 나눠 안내합니다. (7-9)
  String get withdrawalErrorMessage => switch (this) {
    ApiException(code: ApiErrorCode.validation, message: null) =>
      '비밀번호를 확인해 주세요.',
    ApiException(code: ApiErrorCode.unprocessableEntity, message: null) =>
      '혼자 관리자인 모임이나 납부하지 않은 정산이 있으면 탈퇴할 수 없어요.',
    _ => authErrorMessage,
  };

  /// 회원가입 실패 안내. 서버 문구가 없는 409 면 이미 쓰인 이메일이라고 안내합니다. (7-1)
  String get signUpErrorMessage => switch (this) {
    ApiException(code: ApiErrorCode.conflict, message: null) =>
      '이미 가입했거나 탈퇴 후 7일이 지나지 않은 이메일이에요.',
    _ => authErrorMessage,
  };
}
