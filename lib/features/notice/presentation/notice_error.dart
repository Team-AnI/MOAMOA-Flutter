import '../domain/entities/notice_exception.dart';

/// 에러를 사용자에게 보여줄 메시지로 바꿉니다.
String noticeErrorMessage(Object? error) {
  if (error is NoticeException) return error.message;
  return '알 수 없는 오류가 발생했습니다.';
}

/// 서버가 NOT_FOUND 를 보냈는지 (삭제되었거나 존재하지 않음)
bool isNoticeNotFound(Object? error) =>
    error is NoticeException && error.code == 'NOT_FOUND';
