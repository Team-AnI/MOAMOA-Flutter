import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/current_group.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/group_member.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/pages/group_list_page.dart';
import 'package:moamoa/features/group/presentation/pages/group_list_manage_page.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_list_preferences_provider.dart';
import 'package:moamoa/features/group/presentation/widgets/group_list_section.dart';
import 'package:moamoa/features/group/presentation/widgets/group_todo_tile.dart';

import '../fake_group_repository.dart';

CurrentGroup makeDesignGroup(int id, String name, MemberRole role) =>
    CurrentGroup(
      group: Group(id: id, name: name, memberCount: id + 2),
      membership: GroupMember(groupId: id, role: role),
    );

void main() {
  setUpAll(() async {
    await (FontLoader(
      'Pretendard',
    )..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'))).load();
  });
  final groups = [
    makeDesignGroup(1, '스터디 모아', MemberRole.admin),
    makeDesignGroup(2, '독서 클럽', MemberRole.admin),
    makeDesignGroup(3, '주말 등산 모임', MemberRole.member),
    makeDesignGroup(4, '사이드 프로젝트 팀', MemberRole.member),
  ];
  ProviderContainer container() {
    final repo = FakeGroupRepository()..groups = groups;
    final value = ProviderContainer(
      overrides: [
        groupRepositoryProvider.overrideWithValue(repo),
        groupCurrentUserNameProvider.overrideWithValue('성은'),
      ],
    );
    addTearDown(value.dispose);
    return value;
  }

  Future<void> open(
    WidgetTester tester,
    ProviderContainer value, {
    Widget? page,
    GlobalKey? boundary,
  }) async {
    await value.read(groupProvider.notifier).loadGroups();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: value,
        child: RepaintBoundary(
          key: boundary,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: page ?? const GroupListPage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('내 모임 목록 표시 설정', () {
    testWidgets('더보기에서 고정하면 같은 역할의 목록 맨 위로 이동한다', (tester) async {
      final value = container();
      await open(tester, value);
      await tester.tap(find.byTooltip('독서 클럽 메뉴'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('맨 위에 고정'));
      await tester.pumpAndSettle();
      final section = tester
          .widgetList<GroupListSection>(find.byType(GroupListSection))
          .first;
      expect(section.groups.map((current) => current.group.id), [2, 1]);
      expect(value.read(groupProvider).groups, groups);
    });

    testWidgets('보관한 마지막 모임도 관리 화면에서 다시 표시할 수 있다', (tester) async {
      final value = container();
      await open(tester, value);
      for (final current in groups) {
        value
            .read(groupListPreferencesProvider.notifier)
            .toggleArchive(current.group.id);
      }
      await tester.pumpAndSettle();
      expect(find.byType(GroupListSection), findsNothing);
      await tester.tap(find.text('모임 관리 · 보관한 모임 4'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('보관한 모임'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('목록에 다시 표시').first);
      await tester.pumpAndSettle();
      expect(value.read(groupListPreferencesProvider).archivedIds, [2, 3, 4]);
      expect(value.read(groupProvider).groups.length, 4);
      expect(tester.takeException(), isNull);
    });

    testWidgets('역할별 드래그 정렬 후 새로고침해도 순서와 고정이 유지된다', (tester) async {
      final value = container();
      await open(tester, value, page: const GroupListManagePage());
      final reorder = tester
          .widgetList<ReorderableListView>(find.byType(ReorderableListView))
          .first;
      reorder.onReorderItem!(0, 1);
      value.read(groupListPreferencesProvider.notifier).togglePin(3);
      await value.read(groupProvider.notifier).loadGroups();
      await tester.pumpAndSettle();
      expect(value.read(groupListPreferencesProvider).orderedIds, [2, 1]);
      expect(value.read(groupListPreferencesProvider).pinnedIds, [3]);
      expect(
        tester.getTopLeft(find.text('독서 클럽')).dy,
        lessThan(tester.getTopLeft(find.text('스터디 모아')).dy),
      );
    });

    testWidgets('처리할 일을 접고 펼칠 수 있고 연결된 작업을 누를 수 있다', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(393, 852);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var tapped = false;
      final value = container();
      final boundary = GlobalKey();
      await open(
        tester,
        value,
        boundary: boundary,
        page: GroupListPage(
          tasks: [
            GroupTodoTile(
              title: '납부 확인 2건',
              subtitle: '스터디 모아 · 관리자',
              icon: 'list_receipt',
              onTap: () => tapped = true,
            ),
            const GroupTodoTile(
              title: '가입 요청 2건',
              subtitle: '스터디 모아 · 관리자',
              icon: 'list_user_plus',
            ),
            const GroupTodoTile(
              title: '납부하기 15,000원',
              subtitle: '주말 등산 모임',
              icon: 'list_receipt',
            ),
            const GroupTodoTile(
              title: '일정 투표 · 9월 18일 마감',
              subtitle: '주말 등산 모임',
              icon: 'list_calendar_check',
            ),
          ],
        ),
      );
      await capture(tester, boundary, 'list-with-tasks');
      await tester.tap(find.text('납부 확인 2건'));
      expect(tapped, isTrue);
      await tester.tap(find.byTooltip('처리할 일 접기'));
      await tester.pumpAndSettle();
      expect(find.text('납부 확인 2건 외 3개'), findsOneWidget);
      expect(find.text('가입 요청 2건'), findsNothing);
      await capture(tester, boundary, 'list-collapsed');
      await tester.tap(find.byTooltip('처리할 일 펼치기'));
      await tester.pumpAndSettle();
      expect(find.text('가입 요청 2건'), findsOneWidget);
    });

    for (final size in [const Size(393, 852), const Size(320, 568)]) {
      testWidgets('목록·메뉴·관리가 ${size.width} 폭에서 잘리지 않는다', (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final value = container();
        final boundary = GlobalKey();
        await open(tester, value, boundary: boundary);
        await capture(tester, boundary, 'list-${size.width.toInt()}');
        await tester.tap(find.byTooltip('스터디 모아 메뉴'));
        await tester.pumpAndSettle();
        expect(find.text('관리자는 모임을 나갈 수 없어요'), findsOneWidget);
        await capture(tester, boundary, 'menu-${size.width.toInt()}');
        expect(tester.takeException(), isNull);
        await tester.tap(find.text('맨 위에 고정'));
        await tester.pumpAndSettle();
        final manageBoundary = GlobalKey();
        await open(
          tester,
          value,
          page: const GroupListManagePage(),
          boundary: manageBoundary,
        );
        await capture(tester, manageBoundary, 'manage-${size.width.toInt()}');
        expect(tester.takeException(), isNull);
      });
    }
  });
}

Future<void> capture(WidgetTester tester, GlobalKey key, String name) async {
  const outputDirectory = String.fromEnvironment('GROUP_SCREENSHOTS');
  if (outputDirectory.isEmpty) return;
  await tester.pumpAndSettle();
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final directory = Directory(outputDirectory);
    await directory.create(recursive: true);
    await File(
      '${directory.path}/$name.png',
    ).writeAsBytes(bytes!.buffer.asUint8List());
  });
}
