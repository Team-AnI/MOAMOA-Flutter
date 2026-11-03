import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/group_member_profile.dart';
import 'package:moamoa/features/group/domain/entities/group_profile_color.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/group_routes.dart';
import 'package:moamoa/features/group/presentation/pages/group_members_page.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../fake_group_repository.dart';
import 'group_list_design_test.dart' show capture;

class _Repository extends FakeGroupRepository {
  Object? failure;
  Completer<List<GroupMemberProfile>>? pending;
  final calls = <int>[];
  @override
  Future<List<GroupMemberProfile>> getMembers({required int groupId}) async {
    calls.add(groupId);
    if (failure != null) throw failure!;
    return pending == null ? members : pending!.future;
  }
}

void main() {
  setUpAll(() async {
    await (FontLoader(
      'Pretendard',
    )..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'))).load();
  });
  late _Repository fake;
  late ProviderContainer container;
  setUp(() {
    fake = _Repository()
      ..groups = [
        makeGroup(MemberRole.admin).copyWith(
          group: makeGroup(MemberRole.admin).group.copyWith(memberCount: 4),
        ),
      ]
      ..members = [
        const GroupMemberProfile(
          memberId: 3,
          userName: '김모아',
          role: MemberRole.admin,
        ),
        const GroupMemberProfile(
          memberId: 5,
          userName: '이모아',
          role: MemberRole.member,
          profileColor: GroupProfileColor.gray,
        ),
        const GroupMemberProfile(
          memberId: 7,
          userName: '박모아',
          role: MemberRole.member,
          profileColor: GroupProfileColor.blue,
        ),
        const GroupMemberProfile(
          memberId: 9,
          role: MemberRole.member,
          profileColor: GroupProfileColor.dark,
        ),
      ];
    container = ProviderContainer(
      overrides: [groupRepositoryProvider.overrideWithValue(fake)],
      retry: (_, _) => null,
    );
  });
  tearDown(() => container.dispose());
  Future<(GoRouter, GlobalKey)> showPage(
    WidgetTester tester, {
    String path = '/groups/1/members',
    double width = 393,
  }) async {
    tester.view.physicalSize = Size(width, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final router = GoRouter(initialLocation: path, routes: groupRoutes);
    addTearDown(router.dispose);
    final key = GlobalKey();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: RepaintBoundary(
          key: key,
          child: MaterialApp.router(
            theme: AppTheme.light,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
    await tester.pump();
    return (router, key);
  }

  group(GroupMembersPage, () {
    for (final width in [393.0, 320.0]) {
      testWidgets('${width.toInt()}px에서 역할·프로필·이름 미설정을 표시한다', (tester) async {
        final (_, key) = await showPage(tester, width: width);
        await tester.pumpAndSettle();
        expect(find.text('총 4명'), findsOneWidget);
        expect(find.text('김모아'), findsOneWidget);
        expect(find.text('관리자'), findsOneWidget);
        expect(find.text('이름 미설정'), findsOneWidget);
        expect(find.text('강퇴'), findsNothing);
        expect(find.text('가입 승인'), findsNothing);
        expect(tester.takeException(), isNull);
        await capture(tester, key, 'members-${width.toInt()}');
      });
    }
    testWidgets('긴 이름도 작은 화면과 큰 글자에서 잘리지 않고 줄바꿈한다', (tester) async {
      fake.members = [
        fake.members.first.copyWith(userName: '아주 긴 이름의 구성원 테스트입니다'),
      ];
      await showPage(tester, width: 320);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light,
            home: const MediaQuery(
              data: MediaQueryData(
                size: Size(320, 852),
                textScaler: TextScaler.linear(2),
              ),
              child: GroupMembersPage(groupId: 1),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('아주 긴 이름의 구성원 테스트입니다'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
    testWidgets('요청이 끝나기 전에는 로딩을 표시한다', (tester) async {
      fake.pending = Completer<List<GroupMemberProfile>>();
      await showPage(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('총 4명'), findsNothing);
      fake.pending!.complete(fake.members);
      await tester.pumpAndSettle();
      expect(find.text('총 4명'), findsOneWidget);
    });
    testWidgets('빈 목록도 새로고침할 수 있다', (tester) async {
      fake.members = [];
      final (_, key) = await showPage(tester);
      await tester.pumpAndSettle();
      expect(find.text('표시할 구성원이 없어요.'), findsOneWidget);
      await capture(tester, key, 'members-empty-393');
      fake.members = [
        const GroupMemberProfile(
          memberId: 2,
          userName: '새 구성원',
          role: MemberRole.member,
        ),
      ];
      await tester.drag(find.byType(ListView), const Offset(0, 350));
      await tester.pumpAndSettle();
      expect(find.text('새 구성원'), findsOneWidget);
      expect(fake.calls, [1, 1]);
    });
    testWidgets('조회 실패 후 재시도하면 목록을 표시한다', (tester) async {
      fake.failure = const GroupFailure(GroupFailureReason.unavailable);
      final (_, key) = await showPage(tester);
      await tester.pumpAndSettle();
      expect(find.text('다시 시도'), findsOneWidget);
      await capture(tester, key, 'members-failure-393');
      fake.failure = null;
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();
      expect(find.text('김모아'), findsOneWidget);
      expect(fake.calls, [1, 1]);
    });
    for (final entry in {
      GroupFailureReason.unauthorized: '로그인이 필요해요.',
      GroupFailureReason.forbidden: '이 모임의 구성원만 목록을 볼 수 있어요.',
      GroupFailureReason.notFound: '모임을 찾을 수 없어요.',
    }.entries) {
      testWidgets('${entry.key} 실패를 빈 목록으로 오인하지 않게 안내한다', (tester) async {
        fake.failure = GroupFailure(entry.key);
        await showPage(tester);
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
        expect(find.text('표시할 구성원이 없어요.'), findsNothing);
        expect(find.text('다시 시도'), findsNothing);
      });
    }
    testWidgets('많은 구성원도 아래로 스크롤해 마지막 항목을 볼 수 있다', (tester) async {
      fake.members = List.generate(
        40,
        (index) => GroupMemberProfile(
          memberId: index + 1,
          userName: '구성원 ${index + 1}',
          role: MemberRole.member,
        ),
      );
      await showPage(tester);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('구성원 40'),
        300,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text('구성원 40'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
    testWidgets('직접 진입해도 URL의 모임 ID로 조회한다', (tester) async {
      fake.groups = [];
      final (router, _) = await showPage(tester, path: '/groups/7/members');
      await tester.pumpAndSettle();
      expect(fake.calls, [7]);
      await tester.tap(find.byTooltip('뒤로'));
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, '/groups');
    });
    testWidgets('잘못된 모임 ID로는 서버를 호출하지 않는다', (tester) async {
      await showPage(tester, path: '/groups/invalid/members');
      await tester.pumpAndSettle();
      expect(fake.calls, isEmpty);
      expect(tester.takeException(), isNull);
    });
    for (final role in MemberRole.values) {
      testWidgets('$role도 홈의 전체 보기에서 목록으로 들어갔다 돌아온다', (tester) async {
        fake.groups = [
          makeGroup(role)
              .copyWith(group: makeGroup(role).group.copyWith(memberCount: 4)),
        ];
        await container.read(groupProvider.notifier).loadGroups();
        await container.read(groupProvider.notifier).selectGroup(1);
        final (router, key) = await showPage(tester, path: '/groups/home');
        await tester.pumpAndSettle();
        if (role == MemberRole.admin) {
          await capture(tester, key, 'members-home-393');
        }
        await tester.tap(find.text('전체 보기'));
        await tester.pumpAndSettle();
        expect(find.byType(GroupMembersPage), findsOneWidget);
        expect(fake.calls, [1]);
        expect(find.text('김모아'), findsOneWidget);
        await tester.tap(find.byTooltip('뒤로'));
        await tester.pumpAndSettle();
        expect(router.routeInformationProvider.value.uri.path, '/groups/home');
      });
    }
  });
}
