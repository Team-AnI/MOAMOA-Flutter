import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_exception.freezed.dart';

/// 공지 기능에서 화면에 보여줄 수 있는 예외
///
/// 서버 오류(API 명세의 error.code / error.message)와
/// 입력값 검증 실패를 모두 이 예외로 전달합니다.
@freezed
abstract class NoticeException with _$NoticeException implements Exception {
  const factory NoticeException(
    /// 사용자에게 보여줄 메시지
    String message, {

    /// 서버 오류 코드 (예: VALIDATION_ERROR, FORBIDDEN, NOT_FOUND)
    String? code,
  }) = _NoticeException;
}
