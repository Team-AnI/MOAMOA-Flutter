import 'package:dio/dio.dart';

import '../models/group_api_failure.dart';
import 'group_remote_data_source.dart';

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  GroupRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl,
    required this.authHeaders,
  });
  final Dio dio;
  final String baseUrl;
  final Map<String, String>? Function() authHeaders;

  @override
  Future<Map<String, dynamic>> request(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final cleanBase = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    final uri = Uri.tryParse(cleanBase);
    if (uri == null ||
        !uri.hasAuthority ||
        !['http', 'https'].contains(uri.scheme)) {
      throw const GroupApiFailure('UNAVAILABLE');
    }
    final headers = authHeaders();
    if (headers == null) {
      throw const GroupApiFailure('UNAUTHORIZED');
    }
    try {
      final response = await dio.request<Object?>(
        uri.resolve(cleanPath).toString(),
        data: body,
        options: Options(
          method: method,
          headers: headers,
          contentType: Headers.jsonContentType,
        ),
      );
      return _data(response.data);
    } on DioException catch (error) {
      final payload = error.response?.data;
      if (payload is Map<String, dynamic> &&
          payload['error'] is Map<String, dynamic> &&
          (payload['error'] as Map<String, dynamic>)['code'] is String) {
        throw _failure((payload['error'] as Map<String, dynamic>)['code']);
      }
      throw GroupApiFailure(switch (error.response?.statusCode) {
        401 => 'UNAUTHORIZED',
        403 => 'FORBIDDEN',
        404 => 'NOT_FOUND',
        409 => 'CONFLICT',
        400 => 'VALIDATION_ERROR',
        _ => 'UNAVAILABLE',
      });
    } on FormatException {
      throw const GroupApiFailure('UNAVAILABLE');
    } on TypeError {
      throw const GroupApiFailure('UNAVAILABLE');
    }
  }

  Map<String, dynamic> _data(Object? payload) {
    if (payload is! Map<String, dynamic>) {
      throw const FormatException('잘못된 API 응답');
    }
    if (payload['success'] == false) {
      final error = payload['error'];
      throw _failure(error is Map<String, dynamic> ? error['code'] : null);
    }
    if (payload['success'] != true ||
        payload['data'] is! Map<String, dynamic>) {
      throw const FormatException('잘못된 API 응답');
    }
    return payload['data'] as Map<String, dynamic>;
  }

  GroupApiFailure _failure(Object? code) =>
      GroupApiFailure(code is String ? code : 'UNAVAILABLE');
}
