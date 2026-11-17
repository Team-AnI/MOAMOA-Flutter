import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/notice/presentation/notice_error.dart';

void main() {
  group('NoticeErrorX', () {
    test('서버 문구가 있으면 그 문구로 안내한다', () {
      const error = ApiException(
        code: ApiErrorCode.forbidden,
        message: '모임 구성원이 아닙니다.',
      );

      expect(error.noticeErrorMessage, '모임 구성원이 아닙니다.');
    });

    test('응답을 받지 못했으면 네트워크 연결을 확인하라고 안내한다', () {
      const error = ApiException(code: ApiErrorCode.network);

      expect(error.noticeErrorMessage, '네트워크 연결을 확인해주세요.');
    });

    test('공통 예외가 아니면 기본 문구로 안내한다', () {
      expect(
        StateError('알 수 없음').noticeErrorMessage,
        '요청을 처리하지 못했어요. 잠시 후 다시 시도해주세요.',
      );
    });

    test('NOT_FOUND 면 삭제되었거나 없는 공지로 본다', () {
      const error = ApiException(code: ApiErrorCode.notFound);

      expect(error.isNoticeNotFound, isTrue);
    });

    test('NOT_FOUND 가 아니면 삭제된 공지로 보지 않는다', () {
      const error = ApiException(code: ApiErrorCode.forbidden);

      expect(error.isNoticeNotFound, isFalse);
    });
  });
}
