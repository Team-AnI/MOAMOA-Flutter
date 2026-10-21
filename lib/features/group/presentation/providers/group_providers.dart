import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/group_remote_data_source.dart';
import '../../data/datasources/group_remote_data_source_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../domain/entities/member_role.dart';
import '../../domain/repositories/group_repository.dart';
import '../../domain/usecases/create_group.dart';
import '../../domain/usecases/create_group_impl.dart';
import '../../domain/usecases/get_group.dart';
import '../../domain/usecases/get_group_impl.dart';
import '../../domain/usecases/get_group_invite_code.dart';
import '../../domain/usecases/get_group_invite_code_impl.dart';
import '../../domain/usecases/get_my_groups.dart';
import '../../domain/usecases/get_my_groups_impl.dart';
import '../../domain/usecases/join_group.dart';
import '../../domain/usecases/join_group_impl.dart';
import '../../domain/usecases/params/get_group_params.dart';
import '../viewmodels/group_state.dart';
import '../viewmodels/group_view_model.dart';

final groupImagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

/// 로그인 기능에서 현재 계정의 표시 이름을 주입합니다.
final groupCurrentUserNameProvider = Provider<String?>((ref) => null);

/// 로그인 기능에서 서버 인증 방식에 맞는 헤더를 주입합니다.
final groupAuthHeadersProvider = Provider<Map<String, String>?>((ref) => null);
final groupApiBaseUrlProvider = Provider<String>(
  (ref) => const String.fromEnvironment('API_BASE_URL'),
);
final groupRemoteDataSourceProvider = Provider<GroupRemoteDataSource>(
  (ref) => GroupRemoteDataSourceImpl(
    dio: ref.watch(dioProvider),
    baseUrl: ref.watch(groupApiBaseUrlProvider),
    authHeaders: () => ref.read(groupAuthHeadersProvider),
  ),
);
final groupRepositoryProvider = Provider<GroupRepository>(
  (ref) => GroupRepositoryImpl(
    remoteDataSource: ref.watch(groupRemoteDataSourceProvider),
  ),
);
final createGroupProvider = Provider<CreateGroup>(
  (ref) => CreateGroupImpl(repository: ref.watch(groupRepositoryProvider)),
);
final joinGroupProvider = Provider<JoinGroup>(
  (ref) => JoinGroupImpl(repository: ref.watch(groupRepositoryProvider)),
);
final getGroupInviteCodeProvider = Provider<GetGroupInviteCode>(
  (ref) =>
      GetGroupInviteCodeImpl(repository: ref.watch(groupRepositoryProvider)),
);
final getGroupProvider = Provider<GetGroup>(
  (ref) => GetGroupImpl(repository: ref.watch(groupRepositoryProvider)),
);
final getMyGroupsProvider = Provider<GetMyGroups>(
  (ref) => GetMyGroupsImpl(repository: ref.watch(groupRepositoryProvider)),
);
final groupProvider = NotifierProvider<GroupViewModel, GroupState>(
  GroupViewModel.new,
);

/// 모임(groupId)에서 내 역할.
///
/// 역할을 아직 확인하지 못한 상태를 MEMBER 로 보지 않도록, 로딩·오류와 구분되는 AsyncValue 로 노출합니다.
final groupMyRoleProvider = FutureProvider.autoDispose.family<MemberRole, int>((
  ref,
  groupId,
) async {
  final current = await ref.watch(getGroupProvider)(
    GetGroupParams(groupId: groupId),
  );
  return current.membership.role;
});
