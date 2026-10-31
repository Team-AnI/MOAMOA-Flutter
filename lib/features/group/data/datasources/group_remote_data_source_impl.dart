import 'package:dio/dio.dart';

import '../models/group_api_failure.dart';
import '../models/group_update_model.dart';
import '../models/meeting_model.dart';
import '../requests/delete_group_request.dart';
import '../requests/update_group_request.dart';
import 'group_remote_data_source.dart';

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  // 명명된 인자로 의존성을 주입하고 구현 내부에 보관합니다.
  GroupRemoteDataSourceImpl({
    required Dio dio,
    required String baseUrl,
    required Map<String, String>? Function() authHeaders,
    // ignore: prefer_initializing_formals
  }) : _dio = dio,
       // ignore: prefer_initializing_formals
       _baseUrl = baseUrl,
       // ignore: prefer_initializing_formals
       _authHeaders = authHeaders;
  final Dio _dio;
  final String _baseUrl;
  final Map<String, String>? Function() _authHeaders;

  Future<T> _decode<T>(
    Future<Map<String, dynamic>> response,
    T Function(Map<String, dynamic>) parse,
  ) async {
    try {
      return parse(await response);
    } on FormatException {
      throw const GroupApiFailure('UNAVAILABLE');
    } on TypeError {
      throw const GroupApiFailure('UNAVAILABLE');
    }
  }

  @override
  Future<GroupUpdateModel> updateGroup(UpdateGroupRequest request) => _decode(
    _request(
      'PATCH',
      '/v1/meetings/${request.meetingId}',
      body: request.toPatchJson(),
    ),
    (data) {
      final model = GroupUpdateModel.fromJson(data);
      if (model.meetingId != request.meetingId) {
        throw const FormatException('모임 ID 불일치');
      }
      return model;
    },
  );

  @override
  Future<void> deleteGroup(DeleteGroupRequest request) =>
      _decode(_request('DELETE', '/v1/meetings/${request.meetingId}'), (data) {
        if (data['meetingId'] != request.meetingId) {
          throw const FormatException('모임 ID 불일치');
        }
      });

  @override
  Future<List<MeetingModel>> fetchMyGroups() =>
      _decode(_request('GET', '/v1/me/meetings'), (data) {
        final meetings = data['meetings'];
        if (meetings is! List) throw const FormatException('잘못된 모임 목록');
        final result = <MeetingModel>[];
        for (final entry in meetings) {
          if (entry is! Map<String, dynamic>) {
            throw const FormatException('잘못된 모임');
          }
          // 서버 역할 확장 시 권한을 추측하지 않고 해당 항목만 제외합니다.
          if (entry['myRole'] is String &&
              entry['myRole'] != 'ADMIN' &&
              entry['myRole'] != 'MEMBER') {
            continue;
          }
          result.add(MeetingModel.fromJson(entry));
        }
        return List.unmodifiable(result);
      });

  @override
  Future<MeetingModel> fetchGroup(int groupId) =>
      _decode(_request('GET', '/v1/meetings/$groupId'), MeetingModel.fromJson);

  @override
  Future<MeetingModel> createGroup({
    required String name,
    String? description,
  }) => _decode(
    _request(
      'POST',
      '/v1/meetings',
      body: {
        'name': name,
        if (description != null && description.isNotEmpty)
          'description': description,
      },
    ),
    MeetingModel.fromJson,
  );

  @override
  Future<MeetingModel> joinGroup(String inviteCode) => _decode(
    _request('POST', '/v1/me/meetings', body: {'inviteCode': inviteCode}),
    MeetingModel.fromJson,
  );

  @override
  Future<String> fetchInviteCode(int groupId) =>
      _decode(_request('GET', '/v1/meetings/$groupId/invite-code'), (data) {
        final code = data['inviteCode'];
        if (code is! String || code.isEmpty) {
          throw const FormatException('잘못된 초대 코드');
        }
        return code;
      });

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final cleanBase = _baseUrl.endsWith('/') ? _baseUrl : '$_baseUrl/';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    final uri = Uri.tryParse(cleanBase);
    if (uri == null ||
        !uri.hasAuthority ||
        !['http', 'https'].contains(uri.scheme)) {
      throw const GroupApiFailure('UNAVAILABLE');
    }
    final headers = _authHeaders();
    if (headers == null) {
      throw const GroupApiFailure('UNAUTHORIZED');
    }
    try {
      final response = await _dio.request<Object?>(
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
