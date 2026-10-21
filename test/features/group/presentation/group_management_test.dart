import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/group/data/datasources/group_remote_data_source_impl.dart';
import 'package:moamoa/features/group/data/repositories/group_repository_impl.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/domain/usecases/delete_group_impl.dart';
import 'package:moamoa/features/group/domain/usecases/params/delete_group_params.dart';
import 'package:moamoa/features/group/domain/usecases/params/update_group_params.dart';
import 'package:moamoa/features/group/domain/usecases/update_group_impl.dart';
import 'package:moamoa/features/group/presentation/group_routes.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../data/api_group_repository_test.dart' show StubAdapter;
import '../fake_group_repository.dart';

class _ManagementRepository extends FakeGroupRepository {
  int updates = 0, deletes = 0;
  String? sentName, sentDescription;
  GroupFailure? failure;
  Completer<Group>? pendingUpdate;
  Completer<void>? pendingDelete;

  @override
  Future<Group> updateGroup({
    required int groupId,
    String? name,
    String? description,
  }) async {
    updates++;
    sentName = name;
    sentDescription = description;
    if (failure != null) throw failure!;
    if (pendingUpdate != null) return pendingUpdate!.future;
    return super.updateGroup(
      groupId: groupId,
      name: name,
      description: description,
    );
  }

  @override
  Future<void> deleteGroup({required int groupId}) async {
    deletes++;
    if (failure != null) throw failure!;
    if (pendingDelete != null) return pendingDelete!.future;
    return super.deleteGroup(groupId: groupId);
  }
}

void main() {
  late _ManagementRepository fake;
  late ProviderContainer container;

  setUp(() async {
    fake = _ManagementRepository()
      ..groups = [
        makeGroup(MemberRole.admin).copyWith(
          group: const Group(
            id: 1,
            name: '모임',
            description: '소개',
            memberCount: 8,
          ),
        ),
      ];
    container = ProviderContainer(
      overrides: [groupRepositoryProvider.overrideWithValue(fake)],
    );
    await container.read(groupProvider.notifier).loadGroups();
    await container.read(groupProvider.notifier).selectGroup(1);
  });
  tearDown(() => container.dispose());

  Future<GoRouter> showPage(WidgetTester tester, String route) async {
    final router = GoRouter(initialLocation: route, routes: groupRoutes);
    addTearDown(router.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    return router;
  }

  group('모임 수정·삭제 API', () {
    late StubAdapter adapter;
    late Dio dio;
    late GroupRepositoryImpl repository;
    setUp(() {
      adapter = StubAdapter();
      dio = Dio()..httpClientAdapter = adapter;
      repository = GroupRepositoryImpl(
        remoteDataSource: GroupRemoteDataSourceImpl(
          dio: dio,
          baseUrl: 'https://example.test',
          authHeaders: () => {'Authorization': 'test'},
        ),
      );
    });
    tearDown(() => dio.close());

    test('이름만 수정하면 PATCH 본문에서 소개와 경로 ID를 제외하고 역할 없는 응답을 변환한다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '새 모임', 'description': '소개'},
      };
      final group = await repository.updateGroup(groupId: 1, name: '새 모임');
      expect(adapter.requests.single.method, 'PATCH');
      expect(
        adapter.requests.single.path,
        'https://example.test/v1/meetings/1',
      );
      expect(adapter.requests.single.data, {'name': '새 모임'});
      expect(group.name, '새 모임');
      expect(group.description, '소개');
    });
    test('소개만 수정하면 이름을 보내지 않고 빈 문자열도 생략하지 않는다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '모임', 'description': ''},
      };
      await repository.updateGroup(groupId: 1, description: '');
      expect(adapter.requests.single.data, {'description': ''});
    });
    test('삭제하면 DELETE 경로와 성공 응답 ID를 확인한다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1},
      };
      await repository.deleteGroup(groupId: 1);
      expect(adapter.requests.single.method, 'DELETE');
      expect(
        adapter.requests.single.path,
        'https://example.test/v1/meetings/1',
      );
      expect(adapter.requests.single.data, isNull);
    });
    for (final deleting in [true, false]) {
      test('${deleting ? '삭제' : '수정'} 응답 ID가 다르면 실패한다', () async {
        adapter.response = {
          'success': true,
          'data': {'meetingId': 2, 'name': '다른 모임'},
        };
        await expectLater(
          deleting
              ? repository.deleteGroup(groupId: 1)
              : repository.updateGroup(groupId: 1, name: '새 이름'),
          throwsA(isA<GroupFailure>()),
        );
      });
    }
    for (final status in {
      401: GroupFailureReason.unauthorized,
      403: GroupFailureReason.forbidden,
      404: GroupFailureReason.notFound,
      500: GroupFailureReason.unavailable,
    }.entries) {
      test('수정·삭제 HTTP ${status.key} 오류를 도메인 실패로 전달한다', () async {
        adapter.status = status.key;
        adapter.response = '';
        for (final action in [
          () => repository.updateGroup(groupId: 1, name: '수정'),
          () => repository.deleteGroup(groupId: 1),
        ]) {
          await expectLater(
            action(),
            throwsA(
              isA<GroupFailure>().having(
                (e) => e.reason,
                'reason',
                status.value,
              ),
            ),
          );
        }
      });
    }
  });

  group('모임 관리 UseCase·ViewModel', () {
    test('구성원이 수정·삭제하면 Repository를 호출하기 전에 거부한다', () {
      final member = makeGroup(MemberRole.member);
      expect(
        () => UpdateGroupImpl(groupRepository: fake)(
          UpdateGroupParams(currentGroup: member, name: '수정'),
        ),
        throwsA(isA<GroupFailure>()),
      );
      expect(
        () => DeleteGroupImpl(groupRepository: fake)(
          DeleteGroupParams(currentGroup: member),
        ),
        throwsA(isA<GroupFailure>()),
      );
      expect(fake.updates + fake.deletes, 0);
    });
    test('공백 이름이나 변경 필드 없는 수정 요청은 거부한다', () {
      final usecase = UpdateGroupImpl(groupRepository: fake);
      final admin = makeGroup(MemberRole.admin);
      for (final name in [null, '   ']) {
        expect(
          () => usecase(UpdateGroupParams(currentGroup: admin, name: name)),
          throwsA(isA<GroupFailure>()),
        );
      }
      expect(fake.updates, 0);
    });
    test('이름 수정 성공 시 목록·상세와 역할·구성원 수를 보존한다', () async {
      await container
          .read(groupProvider.notifier)
          .update(name: ' 새 모임 ', description: '소개');
      final state = container.read(groupProvider);
      expect(fake.sentName, '새 모임');
      expect(fake.sentDescription, isNull);
      expect(state.currentGroup!.group.memberCount, 8);
      expect(state.currentGroup!.membership.userId, 11);
      expect(state.currentGroup!.membership.role, MemberRole.admin);
      expect(state.groups.single, state.currentGroup);
    });
    test('수정해도 다른 모임의 데이터와 목록 순서는 유지한다', () async {
      final second = fake.groups.single.copyWith(
        group: const Group(id: 2, name: '다른 모임'),
        membership: fake.groups.single.membership.copyWith(groupId: 2),
      );
      fake.groups = [...fake.groups, second];
      final vm = container.read(groupProvider.notifier);
      await vm.loadGroups();
      await vm.update(name: '수정', description: '소개');
      final groups = container.read(groupProvider).groups;
      expect(groups.map((entry) => entry.group.id), [1, 2]);
      expect(groups.last, second);
    });

    test('변경 없는 저장은 요청하지 않는다', () async {
      expect(
        await container
            .read(groupProvider.notifier)
            .update(name: '모임', description: '소개'),
        isNull,
      );
      expect(fake.updates, 0);
    });
    test('수정 중 추가 수정·삭제·선택·목록 요청은 기존 작업을 덮어쓰지 않는다', () async {
      fake.pendingUpdate = Completer<Group>();
      final vm = container.read(groupProvider.notifier);
      final pending = vm.update(name: '수정', description: '소개');
      await vm.update(name: '두 번째', description: '소개');
      expect(await vm.deleteCurrentGroup(), false);
      expect(await vm.selectGroup(1), false);
      await vm.loadGroups();
      expect(fake.updates, 1);
      expect(fake.deletes, 0);
      fake.pendingUpdate!.complete(
        const Group(id: 1, name: '수정', description: '소개'),
      );
      await pending;
      expect(container.read(groupProvider).currentGroup!.group.name, '수정');
    });
    test('삭제 중 중복 요청을 막고 성공 후 목록·현재 모임을 정리한다', () async {
      fake.pendingDelete = Completer<void>();
      final vm = container.read(groupProvider.notifier);
      final pending = vm.deleteCurrentGroup();
      expect(await vm.deleteCurrentGroup(), false);
      expect(fake.deletes, 1);
      fake.pendingDelete!.complete();
      expect(await pending, true);
      expect(container.read(groupProvider).currentGroup, isNull);
      expect(container.read(groupProvider).groups, isEmpty);
    });
    test('수정·삭제 실패 시 기존 데이터와 재시도 가능 상태를 보존한다', () async {
      fake.failure = const GroupFailure(GroupFailureReason.notFound);
      final vm = container.read(groupProvider.notifier);
      expect(await vm.update(name: '실패', description: '소개'), isNull);
      expect(await vm.deleteCurrentGroup(), false);
      final state = container.read(groupProvider);
      expect(state.currentGroup!.group.name, '모임');
      expect(state.groups, hasLength(1));
      expect(state.isSubmitting, false);
      expect(state.errorMessage, contains('찾을 수 없습니다'));
      fake.failure = null;
      expect(await vm.deleteCurrentGroup(), true);
    });
  });

  group('모임 관리 화면', () {
    testWidgets('변경 전 저장을 비활성화하고 실패 시 입력을 보존한다', (tester) async {
      await showPage(tester, '/groups/edit');
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
            .onPressed,
        isNull,
      );
      await tester.enterText(find.byType(TextFormField).first, '수정한 이름');
      await tester.pump();
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(find.text('수정한 이름'), findsOneWidget);
      expect(find.textContaining('요청을 완료하지 못했습니다'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
            .onPressed,
        isNotNull,
      );
      fake.failure = null;
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(find.text('모임 정보 수정'), findsNothing);
      expect(container.read(groupProvider).currentGroup!.group.name, '수정한 이름');
    });
    testWidgets('삭제 취소 시 요청하지 않고 확인 후 목록으로 이동한다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();
      expect(fake.deletes, 0);
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();
      expect(fake.deletes, 1);
      expect(router.routeInformationProvider.value.uri.path, '/groups');
    });
    testWidgets('삭제 실패 시 설정 화면을 유지하고 다시 시도할 수 있다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      fake.failure = const GroupFailure(GroupFailureReason.forbidden);
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();
      expect(
        router.routeInformationProvider.value.uri.path,
        '/groups/settings',
      );
      expect(find.text('모임 관리자 권한이 필요합니다.'), findsOneWidget);
      expect(find.text('모임 삭제'), findsOneWidget);
      expect(container.read(groupProvider).groups, hasLength(1));
    });

    testWidgets('구성원은 직접 설정·편집 경로로 들어와도 관리 동작을 볼 수 없다', (tester) async {
      fake.groups = [makeGroup(MemberRole.member)];
      await container.read(groupProvider.notifier).selectGroup(1);
      final router = await showPage(tester, '/groups/settings');
      expect(find.text('모임 삭제'), findsNothing);
      router.go('/groups/edit');
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsNothing);
      expect(find.text('모임 관리자 권한이 필요합니다.'), findsOneWidget);
    });
    for (final width in [393.0, 320.0]) {
      testWidgets('${width.toInt()}px 화면에서 긴 모임 이름과 입력창이 넘치지 않는다', (
        tester,
      ) async {
        tester.view.physicalSize = Size(width, 852);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        fake.groups = [
          fake.groups.single.copyWith(
            group: fake.groups.single.group.copyWith(
              name: '아주 긴 모임 이름을 가진 모임의 관리자 설정',
            ),
          ),
        ];
        await container.read(groupProvider.notifier).selectGroup(1);
        final router = await showPage(tester, '/groups/settings');
        expect(tester.takeException(), isNull);
        router.go('/groups/edit');
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });
}
