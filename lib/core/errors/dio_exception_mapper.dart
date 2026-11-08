import 'package:dio/dio.dart';

import 'api_error_code.dart';
import 'api_exception.dart';

/// Dio 오류를 공통 예외 [ApiException] 으로 바꿉니다.
///
/// 각 기능의 Repository 가 DataSource 호출을 감싸서 씁니다. DataSource 에서는 예외를 잡지 않습니다.
extension DioExceptionMapperX on DioException {
  ApiException toApiException() {
    final response = this.response;
    // 응답 자체를 받지 못한 경우 (연결 실패, 시간 초과)
    if (response == null) {
      return const ApiException(code: ApiErrorCode.network);
    }

    final body = response.data;
    // 디코더 설정에 따라 Map<dynamic, dynamic> 으로 올 수 있어 Map 으로 검사합니다.
    final error = body is Map ? body['error'] : null;
    if (error is Map && error['code'] != null) {
      final message = error['message'];
      return ApiException(
        code: ApiErrorCode.fromServer(error['code']),
        message: message is String ? message : null,
      );
    }
    // 실패 응답 형식이 아니면 HTTP 상태 코드로 보완합니다.
    return ApiException(code: ApiErrorCode.fromStatusCode(response.statusCode));
  }
}
