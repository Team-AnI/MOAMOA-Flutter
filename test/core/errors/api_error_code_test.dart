import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';

void main() {
  group(ApiErrorCode, () {
    test('명세 공통 코드를 각각의 값으로 바꾼다', () {
      const cases = {
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

      for (final MapEntry(:key, :value) in cases.entries) {
        expect(ApiErrorCode.fromServer(key), value, reason: key);
      }
    });

    test('명세에 없는 코드는 unknown 으로 바꾼다', () {
      expect(ApiErrorCode.fromServer('INTERNAL_ERROR'), ApiErrorCode.unknown);
    });

    test('코드가 문자열이 아니면 unknown 으로 바꾼다', () {
      expect(ApiErrorCode.fromServer(404), ApiErrorCode.unknown);
    });

    test('본문에 코드가 없으면 HTTP 상태 코드로 정한다', () {
      const cases = {
        401: ApiErrorCode.unauthorized,
        403: ApiErrorCode.forbidden,
        404: ApiErrorCode.notFound,
        409: ApiErrorCode.conflict,
        422: ApiErrorCode.unprocessableEntity,
      };

      for (final MapEntry(:key, :value) in cases.entries) {
        expect(ApiErrorCode.fromStatusCode(key), value, reason: '$key');
      }
    });

    test('400·500 처럼 이유를 알 수 없는 상태 코드는 unknown 으로 정한다', () {
      expect(ApiErrorCode.fromStatusCode(400), ApiErrorCode.unknown);
      expect(ApiErrorCode.fromStatusCode(500), ApiErrorCode.unknown);
    });
  });
}
