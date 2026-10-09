import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/group_remote_data_source.dart';
import '../../data/datasources/group_remote_data_source_impl.dart';
import '../../data/repositories/group_repository_impl.dart';
import '../../data/repositories/memory_group_repository.dart';
import '../../domain/repositories/group_repository.dart';
import '../viewmodels/group_state.dart';
import '../viewmodels/group_view_model.dart';
import '../../domain/usecases/create_group.dart';
import '../../domain/usecases/create_group_impl.dart';
import '../../domain/usecases/join_group.dart';
import '../../domain/usecases/join_group_impl.dart';
import '../../domain/usecases/get_group_invite_code.dart';
import '../../domain/usecases/get_group_invite_code_impl.dart';
import '../../domain/usecases/get_group.dart';
import '../../domain/usecases/get_group_impl.dart';
import '../../domain/usecases/get_my_groups.dart';
import '../../domain/usecases/get_my_groups_impl.dart';

/// 로그인 기능에서 현재 계정의 표시 이름을 주입합니다.
final groupUseMockProvider = Provider<bool>(
  (ref) => const bool.fromEnvironment('GROUP_USE_MOCK'),
);
final groupCurrentUserNameProvider = Provider<String?>(
  (ref) => ref.watch(groupUseMockProvider) ? '테스트 사용자' : null,
);

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
  (ref) => ref.watch(groupUseMockProvider)
      ? MemoryGroupRepository()
      : GroupRepositoryImpl(
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
