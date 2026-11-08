import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';

void main() {
  final options = RequestOptions(path: '/v1/meetings/1/notices/30');

  DioException failure(int statusCode, Object? body) => DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: options,
      statusCode: statusCode,
      data: body,
    ),
  );

  group('DioExceptionMapperX', () {
    test('실패 응답의 code 와 message 를 담는다', () {
      final exception = failure(404, {
        'success': false,
        'data': null,
        'error': {'code': 'NOT_FOUND', 'message': '공지사항을 찾을 수 없습니다.'},
      }).toApiException();

      expect(
        exception,
        const ApiException(
          code: ApiErrorCode.notFound,
          message: '공지사항을 찾을 수 없습니다.',
        ),
      );
    });

    test('응답 본문이 Map<dynamic, dynamic> 이어도 code 와 message 를 담는다', () {
      final exception = failure(404, <dynamic, dynamic>{
        'error': <dynamic, dynamic>{
          'code': 'NOT_FOUND',
          'message': '공지사항을 찾을 수 없습니다.',
        },
      }).toApiException();

      expect(
        exception,
        const ApiException(
          code: ApiErrorCode.notFound,
          message: '공지사항을 찾을 수 없습니다.',
        ),
      );
    });

    test('응답을 받지 못하면 network 로 바꾸고 문구는 비워 둔다', () {
      final exception = DioException(
        requestOptions: options,
        type: DioExceptionType.connectionError,
      ).toApiException();

      expect(exception, const ApiException(code: ApiErrorCode.network));
    });

    test('실패 응답 형식이 아니면 HTTP 상태 코드로 정한다', () {
      final exception = failure(403, '<html>Forbidden</html>').toApiException();

      expect(exception, const ApiException(code: ApiErrorCode.forbidden));
    });

    test('error 에 code 가 없으면 HTTP 상태 코드로 정한다', () {
      final exception = failure(409, {
        'error': {'message': '충돌'},
      }).toApiException();

      expect(exception.code, ApiErrorCode.conflict);
    });

    test('message 가 문자열이 아니면 문구를 비워 둔다', () {
      final exception = failure(404, {
        'error': {'code': 'NOT_FOUND', 'message': 404},
      }).toApiException();

      expect(exception.message, isNull);
    });
  });
}
