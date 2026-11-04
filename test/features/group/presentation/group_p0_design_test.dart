import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/group_routes.dart';
import 'package:moamoa/features/group/presentation/pages/group_archived_page.dart';
import 'package:moamoa/features/group/presentation/providers/group_list_preferences_provider.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../fake_group_repository.dart';
import 'group_list_design_test.dart' show capture;

class _FailingManagementRepository extends FakeGroupRepository {
  @override
  Future<Group> updateGroup({
    required int groupId,
    String? name,
    String? description,
  }) async => throw const GroupFailure(GroupFailureReason.unavailable);

  @override
  Future<void> deleteGroup({required int groupId}) async =>
      throw const GroupFailure(GroupFailureReason.unavailable);
}

void main() {
  setUpAll(() async {
    await (FontLoader(
      'Pretendard',
    )..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'))).load();
  });

  for (final width in [393.0, 320.0]) {
    group('GroupArchivedPage ${width.toInt()}px', () {
      testWidgets('마지막 모임을 복원하면 완료 상태를 표시한다', (tester) async {
        tester.view.physicalSize = Size(width, 852);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final fake = FakeGroupRepository()
          ..groups = [
            makeGroup(MemberRole.member).copyWith(
              group: const Group(id: 1, name: '독서 모임', memberCount: 6),
            ),
          ];
        final container = ProviderContainer(
          overrides: [groupRepositoryProvider.overrideWithValue(fake)],
        );
        addTearDown(container.dispose);
        await container.read(groupProvider.notifier).loadGroups();
        container.read(groupListPreferencesProvider.notifier).toggleArchive(1);
        final key = GlobalKey();
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: RepaintBoundary(
              key: key,
              child: MaterialApp(
                theme: AppTheme.light,
                debugShowCheckedModeBanner: false,
                home: const GroupArchivedPage(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await capture(tester, key, 'archive-list-${width.toInt()}');
        await tester.tap(find.text('복원'));
        await tester.pumpAndSettle();
        expect(find.text('보관한 모임이 없어요'), findsOneWidget);
        expect(find.text('“독서 모임” 모임을 목록으로 돌려놨어요'), findsOneWidget);
        expect(container.read(groupProvider).groups, fake.groups);
        expect(
          container.read(groupListPreferencesProvider).archivedIds,
          isEmpty,
        );
        expect(tester.takeException(), isNull);
        await capture(tester, key, 'archive-restored-${width.toInt()}');

        // 같은 공유 상태로 화면을 다시 열어도 이전 복원 안내는 남지 않습니다.
        await tester.pumpWidget(const SizedBox());
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: AppTheme.light,
              home: const GroupArchivedPage(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('보관한 모임이 없어요'), findsOneWidget);
        expect(find.text('“독서 모임” 모임을 목록으로 돌려놨어요'), findsNothing);
        expect(
          container.read(groupListPreferencesProvider).archivedIds,
          isEmpty,
        );
      });
    });
    group('GroupEditPage ${width.toInt()}px', () {
      testWidgets('저장 실패에도 수정한 입력을 유지한다', (tester) async {
        tester.view.physicalSize = Size(width, 852);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final fake = _FailingManagementRepository()
          ..groups = [
            makeGroup(MemberRole.admin).copyWith(
              group: const Group(
                id: 1,
                name: '스터디 모아',
                description: '매주 수요일 강남에서 책 읽는 모임',
                memberCount: 8,
              ),
            ),
          ];
        final container = ProviderContainer(
          overrides: [groupRepositoryProvider.overrideWithValue(fake)],
        );
        addTearDown(container.dispose);
        await container.read(groupProvider.notifier).loadGroups();
        await container.read(groupProvider.notifier).selectGroup(1);
        final router = GoRouter(
          initialLocation: '/groups/edit',
          routes: groupRoutes,
        );
        addTearDown(router.dispose);
        final key = GlobalKey();
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: RepaintBoundary(
              key: key,
              child: MaterialApp.router(
                theme: AppTheme.light,
                debugShowCheckedModeBanner: false,
                routerConfig: router,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await capture(tester, key, 'edit-${width.toInt()}');
        await tester.enterText(find.byType(TextFormField).first, '스터디 모아 수정');
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        await tester.tap(find.text('저장'));
        await tester.pumpAndSettle();
        expect(find.text('스터디 모아 수정'), findsOneWidget);
        expect(find.text('저장 결과를 확인하지 못했어요'), findsOneWidget);
        expect(
          tester
              .widget<FilledButton>(find.widgetWithText(FilledButton, '저장'))
              .onPressed,
          isNotNull,
        );
        expect(tester.takeException(), isNull);
        await capture(tester, key, 'edit-failure-${width.toInt()}');
      });
    });
    group('GroupSettingsPage ${width.toInt()}px', () {
      testWidgets('삭제 실패 안내를 닫으면 설정 화면으로 복귀한다', (tester) async {
        tester.view.physicalSize = Size(width, 852);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final fake = _FailingManagementRepository()
          ..groups = [
            makeGroup(MemberRole.admin).copyWith(
              group: const Group(id: 1, name: '스터디 모아', memberCount: 8),
            ),
          ];
        final container = ProviderContainer(
          overrides: [groupRepositoryProvider.overrideWithValue(fake)],
        );
        addTearDown(container.dispose);
        await container.read(groupProvider.notifier).loadGroups();
        await container.read(groupProvider.notifier).selectGroup(1);
        final router = GoRouter(
          initialLocation: '/groups/settings',
          routes: groupRoutes,
        );
        addTearDown(router.dispose);
        final key = GlobalKey();
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: RepaintBoundary(
              key: key,
              child: MaterialApp.router(
                theme: AppTheme.light,
                debugShowCheckedModeBanner: false,
                routerConfig: router,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await capture(tester, key, 'settings-${width.toInt()}');
        await tester.tap(find.text('모임 삭제'));
        await tester.pumpAndSettle();
        expect(find.textContaining('기록이 모두 사라'), findsNothing);
        expect(tester.takeException(), isNull);
        await capture(tester, key, 'delete-confirm-${width.toInt()}');
        await tester.tap(find.widgetWithText(FilledButton, '모임 삭제'));
        await tester.pumpAndSettle();
        expect(find.text('삭제 결과를 확인하지 못했어요'), findsOneWidget);
        expect(find.text('다시 시도'), findsOneWidget);
        expect(container.read(groupProvider).groups, hasLength(1));
        expect(tester.takeException(), isNull);
        await capture(tester, key, 'delete-failure-${width.toInt()}');
        await tester.tap(find.text('닫기'));
        await tester.pumpAndSettle();
        expect(find.text('삭제 결과를 확인하지 못했어요'), findsNothing);
      });
    });
  }
}
