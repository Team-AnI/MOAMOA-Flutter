import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';

void main() {
  group(ApiErrorCode, () {
    const serverCodes = {
      'VALIDATION_ERROR': ApiErrorCode.validation,
      'INPUT_ERROR': ApiErrorCode.input,
      'MISSING_REQUIRED_VALUE': ApiErrorCode.missingRequiredValue,
      'JSON_PARSE_ERROR': ApiErrorCode.jsonParse,
      'UNAUTHORIZED': ApiErrorCode.unauthorized,
      'FORBIDDEN': ApiErrorCode.forbidden,
      'NOT_FOUND': ApiErrorCode.notFound,
      'CONFLICT': ApiErrorCode.conflict,
      'UNPROCESSABLE_ENTITY': ApiErrorCode.unprocessableEntity,
    };

    for (final MapEntry(:key, :value) in serverCodes.entries) {
      test('서버 코드 $key 는 ${value.name} 으로 바꾼다', () {
        expect(ApiErrorCode.fromServer(key), value);
      });
    }

    test('명세에 없는 코드는 unknown 으로 바꾼다', () {
      expect(ApiErrorCode.fromServer('INTERNAL_ERROR'), ApiErrorCode.unknown);
    });

    test('코드가 문자열이 아니면 unknown 으로 바꾼다', () {
      expect(ApiErrorCode.fromServer(404), ApiErrorCode.unknown);
    });

    const statusCodes = {
      401: ApiErrorCode.unauthorized,
      403: ApiErrorCode.forbidden,
      404: ApiErrorCode.notFound,
      409: ApiErrorCode.conflict,
      422: ApiErrorCode.unprocessableEntity,
    };

    for (final MapEntry(:key, :value) in statusCodes.entries) {
      test('본문에 코드가 없고 HTTP 상태가 $key 이면 ${value.name} 으로 정한다', () {
        expect(ApiErrorCode.fromStatusCode(key), value);
      });
    }

    for (final statusCode in [400, 500]) {
      test('본문에 코드가 없고 HTTP 상태가 $statusCode 이면 이유를 알 수 없어 unknown 으로 정한다', () {
        expect(ApiErrorCode.fromStatusCode(statusCode), ApiErrorCode.unknown);
      });
    }
  });
}
