import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';

void main() {
  group('ApiExceptionMessageX', () {
    test('서버 문구가 있으면 그대로 보여준다', () {
      const exception = ApiException(
        code: ApiErrorCode.notFound,
        message: '공지사항을 찾을 수 없습니다.',
      );

      expect(exception.userMessage, '공지사항을 찾을 수 없습니다.');
    });

    test('응답을 받지 못했으면 네트워크 확인을 안내한다', () {
      const exception = ApiException(code: ApiErrorCode.network);

      expect(exception.userMessage, '네트워크 연결을 확인해주세요.');
    });

    test('서버 문구가 없으면 다시 시도를 안내한다', () {
      const exception = ApiException(code: ApiErrorCode.unknown);

      expect(exception.userMessage, '요청을 처리하지 못했어요. 잠시 후 다시 시도해주세요.');
    });
  });
}
