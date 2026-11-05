import 'package:dio/dio.dart';

import '../../domain/entities/current_group.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/group_member_profile.dart';
import '../../domain/entities/member_role.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/group_remote_data_source.dart';
import '../models/group_api_failure.dart';
import '../models/group_member_model.dart';
import '../models/group_update_model.dart';
import '../models/meeting_model.dart';
import '../requests/delete_group_request.dart';
import '../requests/group_members_request.dart';
import '../requests/update_group_request.dart';

class GroupRepositoryImpl implements GroupRepository {
  // 명명된 public 인자로 주입하고 내부 참조만 보관합니다.
  const GroupRepositoryImpl({required GroupRemoteDataSource remoteDataSource})
    // ignore: prefer_initializing_formals
    : _remoteDataSource = remoteDataSource;
  final GroupRemoteDataSource _remoteDataSource;

  Future<T> _execute<T>(
    Future<T> Function() operation, {
    bool isJoining = false,
    GroupFailureReason parseFailureReason = GroupFailureReason.unavailable,
  }) async {
    try {
      return await operation();
    } on DioException catch (error) {
      final payload = error.response?.data;
      final details = payload is Map<String, dynamic> ? payload['error'] : null;
      final code = details is Map<String, dynamic> ? details['code'] : null;
      throw _failure(
        code is String
            ? code
            : switch (error.response?.statusCode) {
                401 => 'UNAUTHORIZED',
                403 => 'FORBIDDEN',
                404 => 'NOT_FOUND',
                409 => 'CONFLICT',
                400 => 'VALIDATION_ERROR',
                _ => 'UNAVAILABLE',
              },
        isJoining: isJoining,
      );
    } on FormatException {
      throw GroupFailure(parseFailureReason);
    } on TypeError {
      throw GroupFailure(parseFailureReason);
    } on GroupApiFailure catch (error) {
      throw _failure(error.code, isJoining: isJoining);
    }
  }

  GroupFailure _failure(Object? code, {required bool isJoining}) =>
      GroupFailure(switch (code) {
        'UNAUTHORIZED' => GroupFailureReason.unauthorized,
        'FORBIDDEN' => GroupFailureReason.forbidden,
        'NOT_FOUND' when isJoining => GroupFailureReason.invalidCode,
        'NOT_FOUND' => GroupFailureReason.notFound,
        'CONFLICT' when isJoining => GroupFailureReason.alreadyJoined,
        'VALIDATION_ERROR' ||
        'INPUT_ERROR' ||
        'MISSING_REQUIRED_VALUE' => GroupFailureReason.validation,
        _ => GroupFailureReason.unavailable,
      });

  @override
  Future<Group> updateGroup({
    required int groupId,
    String? name,
    String? description,
  }) => _execute(() async {
    final model = await _remoteDataSource.updateGroup(
      UpdateGroupRequest(
        meetingId: groupId,
        name: name,
        description: description,
      ),
    );
    if (model.meetingId != groupId) throw const FormatException('모임 ID 불일치');
    return model.toEntity();
  });

  @override
  Future<void> deleteGroup({required int groupId}) => _execute(() async {
    final returnedId = await _remoteDataSource.deleteGroup(
      DeleteGroupRequest(meetingId: groupId),
    );
    if (returnedId != groupId) throw const FormatException('모임 ID 불일치');
  });

  @override
  Future<List<GroupMemberProfile>> getMembersByGroupId({
    required int groupId,
  }) => _execute(() async {
    final models = await _remoteDataSource.fetchMembers(
      GroupMembersRequest(meetingId: groupId),
    );
    final ids = <int>{};
    for (final model in models) {
      if (model.memberId is! int ||
          model.memberId <= 0 ||
          !ids.add(model.memberId as int)) {
        throw const FormatException('잘못되거나 중복된 구성원 ID');
      }
    }
    return models.map((model) => model.toEntity()).toList(growable: false);
  }, parseFailureReason: GroupFailureReason.invalidResponse);

  @override
  Future<List<CurrentGroup>> getMyGroups() => _execute(() async {
    final models = await _remoteDataSource.fetchMyGroups();
    // 목록에서는 서버가 확장한 역할을 추측하지 않고 기존 정책대로 제외합니다.
    return models
        .where((model) => MemberRole.tryFromServer(model.role) != null)
        .map(_currentGroup)
        .toList(growable: false);
  });

  @override
  Future<CurrentGroup> createGroup(CreateGroupParams params) =>
      _execute(() async {
        final model = await _remoteDataSource.createGroup(
          name: params.name,
          description: params.description,
        );
        return _currentGroup(model, descriptionOverride: params.description);
      });

  @override
  Future<CurrentGroup> joinGroup({required String inviteCode}) =>
      _execute(() async {
        final model = await _remoteDataSource.joinGroup(inviteCode);
        return _currentGroup(model);
      }, isJoining: true);

  @override
  Future<CurrentGroup> getGroup(int groupId) => _execute(() async {
    final model = await _remoteDataSource.fetchGroup(groupId);
    return _currentGroup(model);
  });

  @override
  Future<String> getInviteCode({required int groupId}) => _execute(() async {
    final code = await _remoteDataSource.fetchInviteCode(groupId);
    if (code.isEmpty) throw const FormatException('잘못된 초대 코드');
    return code;
  });

  CurrentGroup _currentGroup(
    MeetingModel model, {
    String? descriptionOverride,
  }) {
    final count = model.memberCount;
    if (count != null && (count is! int || count < 0)) {
      throw const FormatException('잘못된 구성원 수');
    }
    return model.toEntity(descriptionOverride: descriptionOverride);
  }
}
