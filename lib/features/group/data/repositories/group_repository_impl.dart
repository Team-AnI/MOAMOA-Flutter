import '../../domain/entities/current_group.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/group_remote_data_source.dart';
import '../models/group_api_failure.dart';
import '../models/group_update_model.dart';
import '../models/meeting_model.dart';
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
  }) async {
    try {
      return await operation();
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
      groupId: groupId,
      request: UpdateGroupRequest(name: name, description: description),
    );
    return model.toEntity();
  });

  @override
  Future<void> deleteGroup({required int groupId}) =>
      _execute(() => _remoteDataSource.deleteGroup(groupId));

  @override
  Future<List<CurrentGroup>> getMyGroups() => _execute(() async {
    final models = await _remoteDataSource.fetchMyGroups();
    return models.map((model) => model.toEntity()).toList(growable: false);
  });

  @override
  Future<CurrentGroup> createGroup(CreateGroupParams params) =>
      _execute(() async {
        final model = await _remoteDataSource.createGroup(
          name: params.name,
          description: params.description,
        );
        return model.toEntity(descriptionOverride: params.description);
      });

  @override
  Future<CurrentGroup> joinGroup({required String inviteCode}) =>
      _execute(() async {
        final model = await _remoteDataSource.joinGroup(inviteCode);
        return model.toEntity();
      }, isJoining: true);

  @override
  Future<CurrentGroup> getGroup(int groupId) => _execute(() async {
    final model = await _remoteDataSource.fetchGroup(groupId);
    return model.toEntity();
  });

  @override
  Future<String> getInviteCode({required int groupId}) =>
      _execute(() => _remoteDataSource.fetchInviteCode(groupId));
}
