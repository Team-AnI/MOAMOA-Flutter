import 'package:dio/dio.dart';

import '../models/group_api_failure.dart';
import '../models/group_member_model.dart';
import '../models/group_update_model.dart';
import '../models/meeting_model.dart';
import '../requests/delete_group_request.dart';
import '../requests/group_members_request.dart';
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

  @override
  Future<GroupUpdateModel> updateGroup(UpdateGroupRequest request) async =>
      GroupUpdateModel.fromJson(
        await _request(
          'PATCH',
          '/v1/meetings/${request.meetingId}',
          body: request.toPatchJson(),
        ),
      );

  @override
  Future<int> deleteGroup(DeleteGroupRequest request) async {
    final data = await _request('DELETE', '/v1/meetings/${request.meetingId}');
    return data['meetingId'] as int;
  }

  @override
  Future<List<GroupMemberModel>> fetchMembers(
    GroupMembersRequest request,
  ) async {
    final data = await _request(
      'GET',
      '/v1/meetings/${request.meetingId}/members',
    );
    return (data['members'] as List)
        .map(
          (entry) => GroupMemberModel.fromJson(entry as Map<String, dynamic>),
        )
        .toList(growable: false);
  }

  @override
  Future<List<MeetingModel>> fetchMyGroups() async {
    final data = await _request('GET', '/v1/me/meetings');
    return (data['meetings'] as List)
        .map((entry) => MeetingModel.fromJson(entry as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<MeetingModel> fetchGroup(int groupId) async =>
      MeetingModel.fromJson(await _request('GET', '/v1/meetings/$groupId'));

  @override
  Future<MeetingModel> createGroup({
    required String name,
    String? description,
  }) async => MeetingModel.fromJson(
    await _request(
      'POST',
      '/v1/meetings',
      body: {
        'name': name,
        if (description != null && description.isNotEmpty)
          'description': description,
      },
    ),
  );

  @override
  Future<MeetingModel> joinGroup(String inviteCode) async =>
      MeetingModel.fromJson(
        await _request(
          'POST',
          '/v1/me/meetings',
          body: {'inviteCode': inviteCode},
        ),
      );

  @override
  Future<String> fetchInviteCode(int groupId) async {
    final data = await _request('GET', '/v1/meetings/$groupId/invite-code');
    return data['inviteCode'] as String;
  }

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
