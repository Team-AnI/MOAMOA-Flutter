import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';

/// 공지 화면에서 보여줄 오류 안내
extension NoticeErrorX on Object? {
  /// 서버 문구가 있으면 그대로, 없으면 공통 기본 문구입니다.
  String get noticeErrorMessage => switch (this) {
    final ApiException e => e.userMessage,
    _ => ApiErrorCode.unknown.defaultMessage,
  };

  /// 서버가 NOT_FOUND 를 보냈는지 (삭제되었거나 존재하지 않는 공지)
  bool get isNoticeNotFound => switch (this) {
    ApiException(code: ApiErrorCode.notFound) => true,
    _ => false,
  };
}
