import 'dart:async';
import 'dart:typed_data';

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
  Exception? failure;
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

/// 서버의 변경은 끝났지만 응답만 시간 초과된 상황을 재현합니다.
class _ResponseTimeoutAdapter extends StubAdapter {
  bool deletedOnServer = false, updatedOnServer = false;
  int deletes = 0, updates = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    status = 200;
    if (options.method == 'DELETE') {
      deletes++;
      if (!deletedOnServer) {
        deletedOnServer = true;
        requests.add(options);
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.receiveTimeout,
        );
      }
      status = 404;
      response = {
        'success': false,
        'error': {'code': 'NOT_FOUND'},
      };
    } else if (options.method == 'PATCH') {
      updates++;
      if (!updatedOnServer) {
        updatedOnServer = true;
        requests.add(options);
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.receiveTimeout,
        );
      }
      response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '새 이름', 'description': '소개'},
      };
    } else if (options.path.endsWith('/me/meetings')) {
      response = {
        'success': true,
        'data': {
          'meetings': deletedOnServer
              ? []
              : [
                  {'meetingId': 1, 'name': '모임', 'myRole': 'ADMIN'},
                ],
        },
      };
    } else {
      response = {
        'success': true,
        'data': {
          'meetingId': 1,
          'name': '모임',
          'description': '소개',
          'myRole': 'ADMIN',
        },
      };
    }
    return super.fetch(options, requestStream, cancelFuture);
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

  group('GroupRepositoryImpl', () {
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

    test('이름만 수정하면 PATCH 본문에서 소개와 경로 ID를 제외한다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '새 모임', 'description': '소개'},
      };
      await repository.updateGroup(groupId: 1, name: '새 모임');
      expect(adapter.requests.single.method, 'PATCH');
      expect(
        adapter.requests.single.path,
        'https://example.test/v1/meetings/1',
      );
      expect(adapter.requests.single.data, {'name': '새 모임'});
    });
    test('역할 없는 수정 응답을 Group으로 변환한다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '새 모임', 'description': '소개'},
      };
      final group = await repository.updateGroup(groupId: 1, name: '새 모임');
      expect(group.name, '새 모임');
      expect(group.description, '소개');
    });
    test('소개를 비우면 이름은 생략하고 description null을 전송한다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '모임', 'description': null},
      };
      await repository.updateGroup(groupId: 1, description: '');
      expect(adapter.requests.single.data, {'description': null});
    });
    test('소개를 변경하면 입력한 문자열이 전송된다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 1, 'name': '모임', 'description': '새 소개'},
      };
      await repository.updateGroup(groupId: 1, description: '새 소개');
      expect(adapter.requests.single.data, {'description': '새 소개'});
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
    test('수정 응답의 ID를 화면 상태에 적용할 수 있도록 그대로 전달한다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 2, 'name': '다른 모임'},
      };
      expect((await repository.updateGroup(groupId: 1, name: '새 이름')).id, 2);
    });
    test('삭제 성공 응답의 ID로 추가 실패를 만들지 않는다', () async {
      adapter.response = {
        'success': true,
        'data': {'meetingId': 2},
      };
      await repository.deleteGroup(groupId: 1);
      expect(adapter.requests.single.method, 'DELETE');
    });
    for (final status in {
      401: GroupFailureReason.unauthorized,
      403: GroupFailureReason.forbidden,
      404: GroupFailureReason.notFound,
      500: GroupFailureReason.unavailable,
    }.entries) {
      for (final deleting in [false, true]) {
        test(
          '${deleting ? '삭제' : '수정'} HTTP ${status.key} 오류를 도메인 실패로 전달한다',
          () async {
            adapter.status = status.key;
            adapter.response = '';
            await expectLater(
              deleting
                  ? repository.deleteGroup(groupId: 1)
                  : repository.updateGroup(groupId: 1, name: '수정'),
              throwsA(
                isA<GroupFailure>().having(
                  (e) => e.reason,
                  'reason',
                  status.value,
                ),
              ),
            );
          },
        );
      }
    }
  });

  group('DeleteGroupImpl', () {
    test('구성원의 삭제는 Repository 호출 전에 거부한다', () {
      expect(
        () => DeleteGroupImpl(groupRepository: fake)(
          DeleteGroupParams(currentGroup: makeGroup(MemberRole.member)),
        ),
        throwsA(isA<GroupFailure>()),
      );
      expect(fake.deletes, 0);
    });
  });
  group('UpdateGroupImpl', () {
    test('구성원의 수정은 Repository 호출 전에 거부한다', () {
      expect(
        () => UpdateGroupImpl(groupRepository: fake)(
          UpdateGroupParams(
            currentGroup: makeGroup(MemberRole.member),
            name: '수정',
          ),
        ),
        throwsA(isA<GroupFailure>()),
      );
      expect(fake.updates, 0);
    });
    for (final entry in <String, String?>{
      '변경 필드 없음': null,
      '공백 이름': '   ',
      '20자 초과 이름': '가' * 21,
    }.entries) {
      test('${entry.key} 요청을 거부한다', () {
        final usecase = UpdateGroupImpl(groupRepository: fake);
        expect(
          () => usecase(
            UpdateGroupParams(
              currentGroup: makeGroup(MemberRole.admin),
              name: entry.value,
            ),
          ),
          throwsA(isA<GroupFailure>()),
        );
        expect(fake.updates, 0);
      });
    }
  });

  group('GroupViewModel', () {
    test('수정 응답이 다른 모임이면 기존 목록과 선택 모임을 유지한다', () async {
      final previous = container.read(groupProvider);
      fake.pendingUpdate = Completer<Group>()
        ..complete(const Group(id: 2, name: '다른 모임'));
      final result = await container
          .read(groupProvider.notifier)
          .update(name: '새 이름', description: '소개');
      final state = container.read(groupProvider);
      expect(result, isNull);
      expect(state.groups, previous.groups);
      expect(state.currentGroup, previous.currentGroup);
      expect(state.failureReason, GroupFailureReason.invalidResponse);
    });
    test('20자 이름은 저장할 수 있다', () async {
      await container
          .read(groupProvider.notifier)
          .update(name: '가' * 20, description: '소개');
      expect(fake.sentName, '가' * 20);
    });
    test('소개를 비운 뒤 이름만 수정해도 비워진 소개가 유지된다', () async {
      final vm = container.read(groupProvider.notifier);
      await vm.update(name: '모임', description: '');
      expect(
        container.read(groupProvider).currentGroup!.group.description,
        isNull,
      );
      await vm.update(name: '새 이름', description: '');
      expect(fake.sentDescription, isNull);
      expect(
        container.read(groupProvider).currentGroup!.group.description,
        isNull,
      );
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
    for (final action in ['수정', '삭제', '선택', '목록 조회']) {
      test('수정 중 $action 요청은 진행 중인 작업을 덮어쓰지 않는다', () async {
        fake.pendingUpdate = Completer<Group>();
        final vm = container.read(groupProvider.notifier);
        final pending = vm.update(name: '수정', description: '소개');
        switch (action) {
          case '수정':
            expect(await vm.update(name: '두 번째', description: '소개'), isNull);
          case '삭제':
            expect(await vm.deleteCurrentGroup(), false);
          case '선택':
            expect(await vm.selectGroup(1), false);
          case '목록 조회':
            await vm.loadGroups();
        }
        expect(fake.updates, 1);
        expect(fake.deletes, 0);
        expect(container.read(groupProvider).isSubmitting, true);
        fake.pendingUpdate!.complete(
          const Group(id: 1, name: '수정', description: '소개'),
        );
        await pending;
        expect(container.read(groupProvider).currentGroup!.group.name, '수정');
      });
    }
    test('삭제 중 중복 요청을 차단한다', () async {
      fake.pendingDelete = Completer<void>();
      final vm = container.read(groupProvider.notifier);
      final pending = vm.deleteCurrentGroup();
      expect(await vm.deleteCurrentGroup(), false);
      expect(fake.deletes, 1);
      fake.pendingDelete!.complete();
      await pending;
    });
    test('삭제 성공 후 목록과 현재 모임을 정리한다', () async {
      expect(
        await container.read(groupProvider.notifier).deleteCurrentGroup(),
        true,
      );
      expect(container.read(groupProvider).currentGroup, isNull);
      expect(container.read(groupProvider).groups, isEmpty);
    });
    test('삭제 404는 이미 삭제된 모임을 목록과 선택에서 정리한다', () async {
      fake.failure = const GroupFailure(GroupFailureReason.notFound);
      expect(
        await container.read(groupProvider.notifier).deleteCurrentGroup(),
        true,
      );
      final state = container.read(groupProvider);
      expect(state.groups, isEmpty);
      expect(state.currentGroup, isNull);
      expect(state.isSubmitting, false);
      expect(state.errorMessage, isNull);
    });
    for (final deleting in [false, true]) {
      test('${deleting ? '삭제' : '수정'} 실패 시 기존 데이터와 입력 가능한 상태를 보존한다', () async {
        fake.failure = const GroupFailure(GroupFailureReason.unavailable);
        final vm = container.read(groupProvider.notifier);
        if (deleting) {
          expect(await vm.deleteCurrentGroup(), false);
        } else {
          expect(await vm.update(name: '실패', description: '소개'), isNull);
        }
        final state = container.read(groupProvider);
        expect(state.currentGroup!.group.name, '모임');
        expect(state.groups, hasLength(1));
        expect(state.isSubmitting, false);
        expect(state.errorMessage, contains('요청을 완료하지 못했습니다'));
      });
    }
  });

  group('GroupEditPage', () {
    testWidgets('변경 전에는 저장을 비활성화한다', (tester) async {
      await showPage(tester, '/groups/edit');
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
            .onPressed,
        isNull,
      );
    });
    testWidgets('저장 실패 시 입력을 보존한다', (tester) async {
      await showPage(tester, '/groups/edit');
      await tester.enterText(find.byType(TextFormField).first, '수정한 이름');
      await tester.pump();
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(find.text('수정한 이름'), findsOneWidget);
      expect(find.text('저장 결과를 확인하지 못했어요'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
            .onPressed,
        isNotNull,
      );
    });
    testWidgets('저장 실패 후 재시도하면 변경 내용을 저장한다', (tester) async {
      await showPage(tester, '/groups/edit');
      await tester.enterText(find.byType(TextFormField).first, '수정한 이름');
      await tester.pump();
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      fake.failure = null;
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(fake.updates, 2);
      expect(container.read(groupProvider).currentGroup!.group.name, '수정한 이름');
    });
    testWidgets('모임 이름 입력은 20자까지 허용된다', (tester) async {
      await showPage(tester, '/groups/edit');
      await tester.enterText(find.byType(TextFormField).first, '가' * 21);
      await tester.pump();
      final field = tester.widget<TextFormField>(
        find.byType(TextFormField).first,
      );
      expect(field.controller!.text, '가' * 20);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
            .onPressed,
        isNotNull,
      );
    });
    for (final field in [0, 1]) {
      testWidgets('저장 실패 후 ${field == 0 ? '이름을' : '소개를'} 수정하면 이전 오류 안내를 지운다', (
        tester,
      ) async {
        await showPage(tester, '/groups/edit');
        await tester.enterText(find.byType(TextFormField).first, '수정한 이름');
        await tester.pump();
        fake.failure = const GroupFailure(GroupFailureReason.unavailable);
        await tester.tap(find.text('저장'));
        await tester.pumpAndSettle();
        expect(find.text('저장 결과를 확인하지 못했어요'), findsOneWidget);
        await tester.enterText(find.byType(TextFormField).at(field), '다시 수정');
        await tester.pump();
        expect(find.text('저장 결과를 확인하지 못했어요'), findsNothing);
        expect(find.text('다시 수정'), findsOneWidget);
        expect(
          tester
              .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
              .onPressed,
          isNotNull,
        );
        expect(fake.updates, 1);
      });
    }
    testWidgets('알 수 없는 예외로 저장에 실패해도 입력 보존 안내를 표시한다', (tester) async {
      await showPage(tester, '/groups/edit');
      await tester.enterText(find.byType(TextFormField).first, '새 모임');
      await tester.pump();
      fake.failure = Exception('unexpected');
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(find.text('입력한 내용은 그대로 두었어요. 다시 시도해 주세요'), findsOneWidget);
    });
  });
  group('GroupSettingsPage', () {
    testWidgets('이미 삭제된 모임을 삭제하면 목록으로 이동한다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      fake.failure = const GroupFailure(GroupFailureReason.notFound);
      fake.groups = []; // 서버에서도 이미 삭제되어 목록 재조회에 포함되지 않습니다.
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/groups');
      expect(container.read(groupProvider).groups, isEmpty);
    });
    testWidgets('삭제를 취소하면 요청하지 않는다', (tester) async {
      await showPage(tester, '/groups/settings');
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('닫기'));
      await tester.pumpAndSettle();
      expect(fake.deletes, 0);
    });
    testWidgets('삭제를 확인하면 목록으로 이동한다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      expect(fake.deletes, 1);
      expect(router.routeInformationProvider.value.uri.path, '/groups');
    });
    testWidgets('삭제에 실패하면 실패 확인창에 오류를 표시한다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      fake.failure = const GroupFailure(GroupFailureReason.forbidden);
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      expect(
        router.routeInformationProvider.value.uri.path,
        '/groups/settings',
      );
      expect(find.text('모임 관리자 권한이 필요합니다.'), findsOneWidget);
      expect(find.text('모임 삭제'), findsOneWidget);
      expect(container.read(groupProvider).groups, hasLength(1));
    });
    testWidgets('삭제 실패 후 다시 시도하면 삭제하고 목록으로 이동한다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      fake.failure = null;
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();
      expect(fake.deletes, 2);
      expect(router.routeInformationProvider.value.uri.path, '/groups');
      expect(container.read(groupProvider).currentGroup, isNull);
    });

    for (final reason in [
      GroupFailureReason.forbidden,
      GroupFailureReason.validation,
      GroupFailureReason.unauthorized,
    ]) {
      testWidgets('${reason.name}로 삭제에 실패하면 재시도 동작을 제공하지 않는다', (tester) async {
        await showPage(tester, '/groups/settings');
        fake.failure = GroupFailure(reason);
        await tester.tap(find.text('모임 삭제'));
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
        await tester.pumpAndSettle();
        expect(find.text('모임을 삭제하지 못했어요'), findsOneWidget);
        expect(find.text('다시 시도'), findsNothing);
        await tester.tap(find.text('닫기'));
        await tester.pumpAndSettle();
        expect(fake.deletes, 1);
      });
    }
    testWidgets('알 수 없는 예외로 삭제에 실패하면 재시도할 수 있다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      fake.failure = Exception('unexpected');
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      expect(find.text('다시 시도'), findsOneWidget);
      fake.failure = null;
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/groups');
      expect(fake.deletes, 2);
    });
    for (final name in ['독서 모임', '스터디 모아']) {
      testWidgets('$name 삭제 확인은 조사 오류 없이 대상을 표시한다', (tester) async {
        fake.groups = [
          fake.groups.single.copyWith(
            group: fake.groups.single.group.copyWith(name: name),
          ),
        ];
        await container.read(groupProvider.notifier).selectGroup(1);
        await showPage(tester, '/groups/settings');
        await tester.tap(find.text('모임 삭제'));
        await tester.pumpAndSettle();
        expect(find.text('“$name” 모임을 삭제할까요?'), findsOneWidget);
      });
    }
  });
  group('GroupSettingsPage / GroupEditPage', () {
    Future<_ResponseTimeoutAdapter> useApiRepository() async {
      final adapter = _ResponseTimeoutAdapter();
      final dio = Dio()..httpClientAdapter = adapter;
      addTearDown(() => dio.close());
      container.dispose();
      container = ProviderContainer(
        overrides: [
          groupRepositoryProvider.overrideWithValue(
            GroupRepositoryImpl(
              remoteDataSource: GroupRemoteDataSourceImpl(
                dio: dio,
                baseUrl: 'https://example.test',
                authHeaders: () => {'Authorization': 'test'},
              ),
            ),
          ),
        ],
      );
      await container.read(groupProvider.notifier).loadGroups();
      await container.read(groupProvider.notifier).selectGroup(1);
      return adapter;
    }

    testWidgets('서버 삭제 후 응답 시간 초과에서는 모임 잔존을 단정하지 않고 재시도 404를 정리한다', (
      tester,
    ) async {
      final adapter = (await tester.runAsync(useApiRepository))!;
      final router = await showPage(tester, '/groups/settings');
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      expect(adapter.deletedOnServer, isTrue);
      expect(find.text('삭제 결과를 확인하지 못했어요'), findsOneWidget);
      expect(find.textContaining('그대로 남아'), findsNothing);
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();
      expect(adapter.deletes, 2);
      expect(container.read(groupProvider).groups, isEmpty);
      expect(router.routeInformationProvider.value.uri.path, '/groups');
    });
    testWidgets('서버 수정 후 응답 시간 초과에서도 저장 실패를 단정하지 않고 입력을 보존한다', (tester) async {
      final adapter = (await tester.runAsync(useApiRepository))!;
      await showPage(tester, '/groups/edit');
      await tester.enterText(find.byType(TextFormField).first, '새 이름');
      await tester.pump();
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(adapter.updatedOnServer, isTrue);
      expect(find.text('저장 결과를 확인하지 못했어요'), findsOneWidget);
      expect(find.text('새 이름'), findsOneWidget);
      expect(find.textContaining('바로 바뀌어'), findsNothing);
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(adapter.updates, 2);
      expect(container.read(groupProvider).currentGroup?.group.name, '새 이름');
    });

    testWidgets('저장 실패 문구는 설정으로 돌아가면 표시하지 않는다', (tester) async {
      final router = await showPage(tester, '/groups/edit');
      await tester.enterText(find.byType(TextFormField).first, '수정');
      await tester.pump();
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
      expect(find.text('저장 결과를 확인하지 못했어요'), findsOneWidget);
      router.go('/groups/settings');
      await tester.pumpAndSettle();
      expect(find.text('저장 결과를 확인하지 못했어요'), findsNothing);
    });
    testWidgets('삭제 실패 문구는 편집 화면에 전달하지 않는다', (tester) async {
      final router = await showPage(tester, '/groups/settings');
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      await tester.tap(find.text('모임 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
      await tester.pumpAndSettle();
      expect(find.text('삭제 결과를 확인하지 못했어요'), findsOneWidget);
      await tester.tap(find.text('닫기'));
      await tester.pumpAndSettle();
      router.go('/groups/edit');
      await tester.pumpAndSettle();
      expect(find.text('삭제 결과를 확인하지 못했어요'), findsNothing);
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
  for (final editing in [true, false]) {
    group(editing ? 'GroupEditPage' : 'GroupSettingsPage', () {
      testWidgets('요청 처리 중 기기 뒤로 가기를 막고 완료 후 허용한다', (tester) async {
        final router = await showPage(tester, '/groups/home');
        final route = editing ? '/groups/edit' : '/groups/settings';
        unawaited(router.push(route));
        await tester.pumpAndSettle();
        if (editing) {
          fake.pendingUpdate = Completer<Group>();
          await tester.enterText(find.byType(TextFormField).first, '수정');
          await tester.pump();
          await tester.tap(find.text('저장'));
        } else {
          fake.pendingDelete = Completer<void>();
          await tester.tap(find.text('모임 삭제'));
          await tester.pumpAndSettle();
          await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
        }
        await tester.pumpAndSettle();
        expect(container.read(groupProvider).isSubmitting, true);
        await tester.binding.handlePopRoute();
        for (var frame = 0; frame < 10; frame++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(find.text(editing ? '모임 정보 수정' : '모임 설정'), findsOneWidget);
        if (editing) {
          fake.pendingUpdate!.completeError(
            const GroupFailure(GroupFailureReason.unavailable),
          );
        } else {
          fake.pendingDelete!.completeError(
            const GroupFailure(GroupFailureReason.unavailable),
          );
        }
        await tester.pumpAndSettle();
        if (!editing) {
          await tester.tap(find.text('닫기'));
          await tester.pumpAndSettle();
        }
        await tester.binding.handlePopRoute();
        for (var frame = 0; frame < 10; frame++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(router.routeInformationProvider.value.uri.path, '/groups/home');
      });
    });
  }
}
