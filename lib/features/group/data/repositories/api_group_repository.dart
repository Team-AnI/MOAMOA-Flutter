import 'package:dio/dio.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/repositories/group_repository.dart';
import '../models/meeting_dto.dart';

class ApiGroupRepository implements GroupRepository {
  ApiGroupRepository(
    this._dio, {
    required this.baseUrl,
    required this.authHeaders,
  });
  final Dio _dio;
  final String baseUrl;
  final Map<String, String>? Function() authHeaders;

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool isJoining = false,
  }) async {
    final uri = Uri.tryParse(baseUrl);
    if (uri == null ||
        !uri.hasAuthority ||
        !['http', 'https'].contains(uri.scheme)) {
      throw const GroupFailure(GroupFailureReason.unavailable);
    }
    final headers = authHeaders();
    if (headers == null) {
      throw const GroupFailure(GroupFailureReason.unauthorized);
    }
    try {
      final response = await _dio.request<Object?>(
        uri.resolve(path).toString(),
        data: body,
        options: Options(
          method: method,
          headers: headers,
          contentType: Headers.jsonContentType,
        ),
      );
      return _data(response.data, isJoining: isJoining);
    } on DioException catch (error) {
      final payload = error.response?.data;
      if (payload is Map<String, dynamic> &&
          payload['error'] is Map<String, dynamic>) {
        throw _failure(
          (payload['error'] as Map<String, dynamic>)['code'],
          isJoining: isJoining,
        );
      }
      throw const GroupFailure(GroupFailureReason.unavailable);
    } on FormatException {
      throw const GroupFailure(GroupFailureReason.unavailable);
    } on TypeError {
      throw const GroupFailure(GroupFailureReason.unavailable);
    }
  }

  Map<String, dynamic> _data(Object? payload, {required bool isJoining}) {
    if (payload is! Map<String, dynamic>) {
      throw const FormatException('잘못된 API 응답');
    }
    if (payload['success'] == false) {
      final error = payload['error'];
      throw _failure(
        error is Map<String, dynamic> ? error['code'] : null,
        isJoining: isJoining,
      );
    }
    if (payload['success'] != true ||
        payload['data'] is! Map<String, dynamic>) {
      throw const FormatException('잘못된 API 응답');
    }
    return payload['data'] as Map<String, dynamic>;
  }

  GroupFailure _failure(Object? code, {required bool isJoining}) =>
      GroupFailure(switch (code) {
        'UNAUTHORIZED' => GroupFailureReason.unauthorized,
        'FORBIDDEN' => GroupFailureReason.forbidden,
        'NOT_FOUND' when isJoining => GroupFailureReason.invalidCode,
        'CONFLICT' when isJoining => GroupFailureReason.alreadyJoined,
        'VALIDATION_ERROR' ||
        'INPUT_ERROR' ||
        'MISSING_REQUIRED_VALUE' => GroupFailureReason.validation,
        _ => GroupFailureReason.unavailable,
      });

  CurrentGroup _meeting(Map<String, dynamic> json, {String? description}) {
    try {
      return MeetingDto.fromJson(
        json,
      ).toDomain(descriptionOverride: description);
    } on FormatException {
      throw const GroupFailure(GroupFailureReason.unavailable);
    } on TypeError {
      throw const GroupFailure(GroupFailureReason.unavailable);
    }
  }

  @override
  Future<List<CurrentGroup>> getMyGroups() async {
    final data = await _request('GET', '/v1/me/meetings');
    final meetings = data['meetings'];
    if (meetings is! List) {
      throw const GroupFailure(GroupFailureReason.unavailable);
    }
    return meetings
        .map((entry) {
          if (entry is! Map<String, dynamic>) {
            throw const GroupFailure(GroupFailureReason.unavailable);
          }
          return _meeting(entry);
        })
        .toList(growable: false);
  }

  @override
  Future<CurrentGroup> createGroup({
    required String name,
    required String description,
  }) async {
    final data = await _request(
      'POST',
      '/v1/meetings',
      body: {
        'name': name,
        if (description.isNotEmpty) 'description': description,
      },
    );
    return _meeting(data, description: description);
  }

  @override
  Future<CurrentGroup> joinGroup({required String inviteCode}) async {
    final data = await _request(
      'POST',
      '/v1/me/meetings',
      body: {'inviteCode': inviteCode},
      isJoining: true,
    );
    return _meeting(data);
  }

  @override
  Future<CurrentGroup> getGroup(String groupId) async => _meeting(
    await _request('GET', '/v1/meetings/${Uri.encodeComponent(groupId)}'),
  );

  @override
  Future<String> getInviteCode({required String groupId}) async {
    final data = await _request(
      'GET',
      '/v1/meetings/${Uri.encodeComponent(groupId)}/invite-code',
    );
    final code = data['inviteCode'];
    if (code is! String || code.isEmpty) {
      throw const GroupFailure(GroupFailureReason.unavailable);
    }
    return code;
  }
}
