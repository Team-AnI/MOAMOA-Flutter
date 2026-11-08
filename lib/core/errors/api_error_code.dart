/// 서버 실패 응답의 error.code (API 명세 공통 사항) + 앱에서 생기는 경우
///
/// 기능별로 다르게 처리할 이유(예: 이미 가입한 모임)는 각 기능에서 이 코드를 보고 정합니다.
enum ApiErrorCode {
  validation,
  input,
  missingRequiredValue,
  jsonParse,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  unprocessableEntity,

  /// 응답 자체를 받지 못했습니다. (연결 실패, 시간 초과)
  network,

  /// 응답은 받았지만 형식이 다르거나 명세에 없는 코드입니다.
  unknown;

  /// 서버의 error.code 값을 바꿉니다. 모르는 값이면 [unknown] 입니다.
  static ApiErrorCode fromServer(Object? value) => switch (value) {
    'VALIDATION_ERROR' => ApiErrorCode.validation,
    'INPUT_ERROR' => ApiErrorCode.input,
    'MISSING_REQUIRED_VALUE' => ApiErrorCode.missingRequiredValue,
    'JSON_PARSE_ERROR' => ApiErrorCode.jsonParse,
    'UNAUTHORIZED' => ApiErrorCode.unauthorized,
    'FORBIDDEN' => ApiErrorCode.forbidden,
    'NOT_FOUND' => ApiErrorCode.notFound,
    'CONFLICT' => ApiErrorCode.conflict,
    'UNPROCESSABLE_ENTITY' => ApiErrorCode.unprocessableEntity,
    _ => ApiErrorCode.unknown,
  };

  /// 본문에 error.code 가 없을 때 HTTP 상태 코드로 정합니다.
  static ApiErrorCode fromStatusCode(int? statusCode) => switch (statusCode) {
    401 => ApiErrorCode.unauthorized,
    403 => ApiErrorCode.forbidden,
    404 => ApiErrorCode.notFound,
    409 => ApiErrorCode.conflict,
    422 => ApiErrorCode.unprocessableEntity,
    _ => ApiErrorCode.unknown,
  };
}
