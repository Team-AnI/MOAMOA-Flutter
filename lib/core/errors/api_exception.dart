import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error_code.dart';

part 'api_exception.freezed.dart';

/// 서버 요청이 실패했을 때 Repository 가 던지는 공통 예외
///
/// 서버 실패 응답 { error: { code, message } } 를 담습니다.
/// 서버 message 는 사용자에게 보여줄 문구입니다. (팀 공통 에러 가이드 v1)
@freezed
abstract class ApiException with _$ApiException implements Exception {
  const factory ApiException({
    required ApiErrorCode code,

    /// 서버가 보낸 안내 문구. 응답을 받지 못했거나 문구가 없으면 null 입니다.
    String? message,
  }) = _ApiException;
}

/// 화면에 보여줄 안내 문구
extension ApiExceptionMessageX on ApiException {
  /// 서버 문구가 있으면 그대로, 없으면 코드별 기본 문구
  String get userMessage => message ?? code.defaultMessage;
}

/// 서버 문구가 없을 때 쓰는 기본 안내 문구
extension ApiErrorCodeMessageX on ApiErrorCode {
  String get defaultMessage => switch (this) {
    ApiErrorCode.network => '네트워크 연결을 확인해주세요.',
    _ => '요청을 처리하지 못했어요. 잠시 후 다시 시도해주세요.',
  };
}
