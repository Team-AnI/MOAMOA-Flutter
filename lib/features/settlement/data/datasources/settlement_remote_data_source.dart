import 'package:dio/dio.dart';

/// HTTP 요청과 공통 Envelope 해석만 담당합니다. 화면 판단은 하지 않습니다.
class SettlementRemoteDataSource {
  const SettlementRemoteDataSource({required Dio dio, required String baseUrl})
    : _dio = dio,
      _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

  Future<Map<String, dynamic>> create(
    int meetingId,
    Map<String, Object?> body,
  ) => _request('POST', '/v1/meetings/$meetingId/settlements', body: body);

  Future<Map<String, dynamic>> list(int meetingId) =>
      _request('GET', '/v1/meetings/$meetingId/settlements');

  Future<Map<String, dynamic>> detail(int meetingId, int settlementId) =>
      _request('GET', '/v1/meetings/$meetingId/settlements/$settlementId');

  Future<Map<String, dynamic>> submitPayment(
    int meetingId,
    int settlementId,
  ) => _request(
    'POST',
    '/v1/meetings/$meetingId/settlements/$settlementId/payments/me/submissions',
  );

  Future<Map<String, dynamic>> approvePayment(
    int meetingId,
    int settlementId,
    int paymentId,
  ) => _request(
    'POST',
    '/v1/meetings/$meetingId/settlements/$settlementId/payments/$paymentId/approval',
  );

  Future<Map<String, dynamic>> rejectPayment(
    int meetingId,
    int settlementId,
    int paymentId, {
    String? reason,
  }) => _request(
    'POST',
    '/v1/meetings/$meetingId/settlements/$settlementId/payments/$paymentId/rejection',
    body: reason == null ? null : {'reason': reason},
  );

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, Object?>? body,
  }) async {
    final base = _baseUrl.endsWith('/') ? _baseUrl : '$_baseUrl/';
    final target = _baseUrl.isEmpty
        ? path
        : Uri.parse(base).resolve(path.substring(1)).toString();
    final response = await _dio.request<Object?>(
      target,
      data: body,
      options: Options(method: method, contentType: Headers.jsonContentType),
    );
    final envelope = response.data;
    if (envelope is! Map || envelope['success'] != true) {
      throw const FormatException('잘못된 정산 API 응답');
    }
    final data = envelope['data'];
    if (data is! Map<String, dynamic>) {
      throw const FormatException('정산 응답 데이터가 없습니다');
    }
    return data;
  }
}
