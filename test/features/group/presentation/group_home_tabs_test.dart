import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/app/router/app_router.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/pages/group_home_page.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/notice/domain/entities/notice_list_result.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_list_page.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_list_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../notice/fakes/fake_notice_repository.dart';
import '../../schedule/fakes/fake_schedule_repository.dart';
import '../fake_group_repository.dart';
import 'group_list_design_test.dart' show capture;

class _Schedules extends FakeScheduleRepository {
  final requestedIds = <int>[];

  @override
  Future<List<Schedule>> getSchedules(ScheduleListRequest request) {
    requestedIds.add(request.meetingId);
    return super.getSchedules(request);
  }
}

class _Notices extends FakeNoticeRepository {
  final requestedIds = <int>[];

  @override
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  }) {
    requestedIds.add(meetingId);
    return super.getNotices(meetingId: meetingId, page: page, size: size);
  }
}

void main() {
  setUpAll(() async {
    await (FontLoader(
      'Pretendard',
    )..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });
  late ProviderContainer container;
  late _Schedules schedules;
  late _Notices notices;

  Future<(GoRouter, GlobalKey)> open(
    WidgetTester tester, {
    MemberRole role = MemberRole.member,
    int groupId = 7,
    double width = 393,
    bool selected = true,
    bool scheduleFailure = false,
  }) async {
    tester.view.physicalSize = Size(width, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    schedules = _Schedules()
      ..schedules = [
        Schedule(id: 31, title: '연결된 일정', startAt: DateTime.now()),
      ];
    notices = _Notices()..notices.add(buildNotice(41, title: '연결된 공지'));
    final group = makeGroup(role);
    final groups = FakeGroupRepository()
      ..groups = [
        group.copyWith(
          group: group.group.copyWith(id: groupId, name: '연결 테스트 모임'),
          membership: group.membership.copyWith(groupId: groupId),
        ),
      ];
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        groupRepositoryProvider.overrideWithValue(groups),
        if (!scheduleFailure)
          scheduleRepositoryProvider.overrideWithValue(schedules),
        noticeRepositoryProvider.overrideWithValue(notices),
      ],
    );
    addTearDown(container.dispose);
    if (selected) {
      await container.read(groupProvider.notifier).selectGroup(groupId);
    }
    final router = container.read(appRouterProvider);
    router.go('/groups/home');
    final boundary = GlobalKey();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: RepaintBoundary(
          key: boundary,
          child: MaterialApp.router(
            theme: AppTheme.light,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return (router, boundary);
  }

  group(GroupHomePage, () {
    for (final (roleLabel, role) in [
      ('관리자', MemberRole.admin),
      ('일반 구성원', MemberRole.member),
    ]) {
      for (final (width, groupId) in [(393.0, 7), (320.0, 19)]) {
        for (final tab in ['일정', '공지']) {
          testWidgets(
            '$roleLabel 역할로 ${width.toInt()}px 홈의 $tab 탭을 누르면 선택 모임 목록을 열고 뒤로 돌아온다',
            (tester) async {
              final (router, boundary) = await open(
                tester,
                role: role,
                groupId: groupId,
                width: width,
              );
              if (role == MemberRole.admin && tab == '일정') {
                await capture(tester, boundary, 'home-tabs-${width.toInt()}');
              }
              await tester.tap(find.text(tab));
              await tester.pumpAndSettle();
              if (tab == '일정') {
                expect(find.byType(ScheduleListPage), findsOneWidget);
                expect(schedules.requestedIds, [groupId]);
                expect(find.text('연결된 일정'), findsOneWidget);
              } else {
                expect(find.byType(NoticeListPage), findsOneWidget);
                expect(notices.requestedIds, [groupId]);
                expect(find.text('연결된 공지'), findsOneWidget);
              }
              if (role == MemberRole.admin) {
                await capture(
                  tester,
                  boundary,
                  '${tab == '일정' ? 'schedules' : 'notices'}-entry-${width.toInt()}',
                );
              }
              await tester.binding.handlePopRoute();
              await tester.pumpAndSettle();
              expect(find.byType(GroupHomePage), findsOneWidget);
              expect(
                router.routeInformationProvider.value.uri.path,
                '/groups/home',
              );
              expect(
                container.read(groupProvider).currentGroup?.group.id,
                groupId,
              );
              expect(tester.takeException(), isNull);
            },
          );
        }
      }
    }
    testWidgets('선택한 모임이 없으면 일정·공지 탭을 눌러도 홈에 머문다', (tester) async {
      await open(tester, selected: false);
      for (final tab in ['일정', '공지']) {
        await tester.tap(find.text(tab));
        await tester.pumpAndSettle();
        expect(find.byType(GroupHomePage), findsOneWidget);
        await tester.longPress(find.text(tab));
        await tester.pumpAndSettle();
        expect(find.text('모임을 선택해주세요'), findsOneWidget);
        expect(find.text('$tab · 준비 중'), findsNothing);
        await tester.tapAt(const Offset(10, 100));
        await tester.pumpAndSettle();
      }
      expect(schedules.requestedIds, isEmpty);
      expect(notices.requestedIds, isEmpty);
    });
    testWidgets('일정 API 연결이 없으면 기존 오류 화면을 표시하고 홈으로 돌아온다', (tester) async {
      await open(tester, scheduleFailure: true);
      await tester.tap(find.text('일정'));
      await tester.pumpAndSettle();
      expect(find.byType(ScheduleListPage), findsOneWidget);
      expect(find.text('다시 시도'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(GroupHomePage), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
