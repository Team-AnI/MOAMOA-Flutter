import '../../domain/entities/group.dart';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

final groupImagePickerProvider = Provider<ImagePicker>((ref) => ImagePicker());

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

/// API에 이미지 필드가 없어 Mock 실행에만 사용하는 세션 사진입니다.
final groupMockPhotosProvider =
    NotifierProvider<GroupMockPhotos, Map<int, Uint8List>>(GroupMockPhotos.new);

class GroupMockPhotos extends Notifier<Map<int, Uint8List>> {
  @override
  Map<int, Uint8List> build() {
    ref.watch(groupRepositoryProvider);
    return const {};
  }

  void save(int groupId, Uint8List photo) {
    if (!ref.read(groupUseMockProvider)) return;
    state = Map.unmodifiable({...state, groupId: Uint8List.fromList(photo)});
  }
}

// 승인 요청 결과는 Mock UI에서만 사용하며 정식 API 상태와 분리합니다.
final groupMockPendingProvider =
    NotifierProvider<GroupMockPending, List<Group>>(GroupMockPending.new);

class GroupMockPending extends Notifier<List<Group>> {
  @override
  List<Group> build() {
    ref.watch(groupRepositoryProvider);
    return const [];
  }

  void update(List<Group> groups) => state = List.unmodifiable(groups);
}
