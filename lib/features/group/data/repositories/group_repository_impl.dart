import '../../domain/entities/current_group.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/group_remote_data_source.dart';
import '../models/group_api_failure.dart';
import '../models/meeting_model.dart';

class GroupRepositoryImpl implements GroupRepository {
  const GroupRepositoryImpl({required this.remoteDataSource});
  final GroupRemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
    bool isJoining = false,
  }) async {
    try {
      return await remoteDataSource.request(method, path, body: body);
    } on GroupApiFailure catch (error) {
      throw _failure(error.code, isJoining: isJoining);
    }
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
      return MeetingModel.fromJson(
        json,
      ).toEntity(descriptionOverride: description);
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
  Future<CurrentGroup> getGroup(int groupId) async =>
      _meeting(await _request('GET', '/v1/meetings/$groupId'));

  @override
  Future<String> getInviteCode({required int groupId}) async {
    final data = await _request('GET', '/v1/meetings/$groupId/invite-code');
    final code = data['inviteCode'];
    if (code is! String || code.isEmpty) {
      throw const GroupFailure(GroupFailureReason.unavailable);
    }
    return code;
  }
}
