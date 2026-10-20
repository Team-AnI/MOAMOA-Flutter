import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_detail_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  final startAt = DateTime(2026, 10, 20, 19);
  final run = Schedule(
    id: 20,
    title: '10월 정기 러닝',
    description: '반포 한강공원 집합',
    startAt: startAt,
    endAt: startAt.add(const Duration(hours: 2)),
    location: '반포 한강공원',
  );

  late FakeScheduleRepository repository;

  setUp(() {
    repository = FakeScheduleRepository(schedules: [run]);
  });

  /// 화면을 닫는 동작(context.pop)을 확인할 수 있게 GoRouter 위에 상세 화면을 올려 둡니다.
  Future<void> pumpDetailPage(
    WidgetTester tester, {
    bool isAdmin = true,
  }) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/detail',
          builder: (_, _) =>
              const ScheduleDetailPage(meetingId: 1, scheduleId: 20),
        ),
        GoRoute(
          path: '/meetings/1/schedules/20/edit',
          builder: (_, _) => const Scaffold(body: Text('수정 화면')),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          scheduleRepositoryProvider.overrideWithValue(repository),
          scheduleAdminProvider.overrideWithValue(isAdmin),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    router.push('/detail');
    await tester.pumpAndSettle();
  }

  Future<void> tapCancelAndConfirm(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key('schedule-cancel-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('일정 취소'));
    await tester.pumpAndSettle();
  }

  group('ScheduleDetailPage', () {
    testWidgets('제목, 일시, 진행 시간, 장소, 메모를 보여준다', (tester) async {
      await pumpDetailPage(tester);

      expect(find.text('10월 정기 러닝'), findsOneWidget);
      expect(find.text('화요일 오후 7:00'), findsOneWidget);
      expect(find.text('약 2시간 진행'), findsOneWidget);
      expect(find.text('반포 한강공원'), findsOneWidget);
      expect(find.text('메모'), findsOneWidget);
      expect(find.text('반포 한강공원 집합'), findsOneWidget);
    });

    testWidgets('종료 일시가 없으면 진행 시간을 보여주지 않는다', (tester) async {
      repository.schedules = [run.copyWith(endAt: null)];

      await pumpDetailPage(tester);

      expect(find.textContaining('진행'), findsNothing);
    });

    testWidgets('관리자에게만 수정 버튼과 일정 취소하기를 보여준다', (tester) async {
      await pumpDetailPage(tester);
      expect(find.byKey(const Key('schedule-edit-button')), findsOneWidget);
      expect(find.byKey(const Key('schedule-cancel-button')), findsOneWidget);

      await pumpDetailPage(tester, isAdmin: false);
      expect(find.byKey(const Key('schedule-edit-button')), findsNothing);
      expect(find.byKey(const Key('schedule-cancel-button')), findsNothing);
    });

    testWidgets('일정 취소하기를 누르면 확인 팝업을 보여주고 닫기를 누르면 취소하지 않는다', (tester) async {
      await pumpDetailPage(tester);

      await tester.tap(find.byKey(const Key('schedule-cancel-button')));
      await tester.pumpAndSettle();
      expect(find.text('이 일정을 취소할까요?'), findsOneWidget);
      expect(find.text('취소한 일정은 되돌릴 수 없어요.'), findsOneWidget);

      await tester.tap(find.text('닫기'));
      await tester.pumpAndSettle();

      expect(find.text('이 일정을 취소할까요?'), findsNothing);
      expect(repository.deleteCalls, isEmpty);
    });

    testWidgets('팝업에서 일정 취소를 누르면 일정을 취소하고 화면을 닫는다', (tester) async {
      await pumpDetailPage(tester);

      await tapCancelAndConfirm(tester);

      expect(repository.deleteCalls.single.scheduleId, 20);
      expect(find.byType(ScheduleDetailPage), findsNothing);
    });

    testWidgets('취소에 실패하면 안내를 보여주고 화면을 유지한다', (tester) async {
      await pumpDetailPage(tester);
      repository.error = Exception('network');

      await tapCancelAndConfirm(tester);

      expect(find.text('일정을 취소하지 못했어요'), findsOneWidget);
      expect(find.byType(ScheduleDetailPage), findsOneWidget);
    });

    testWidgets('취소 요청 중에는 일정 취소하기를 눌러도 확인 팝업이 다시 열리지 않는다', (tester) async {
      repository.deleteCompleter = Completer<void>();
      await pumpDetailPage(tester);

      await tapCancelAndConfirm(tester);
      await tester.tap(find.byKey(const Key('schedule-cancel-button')));
      await tester.pumpAndSettle();

      expect(find.text('이 일정을 취소할까요?'), findsNothing);

      repository.deleteCompleter!.complete();
      await tester.pumpAndSettle();

      expect(repository.deleteCalls, hasLength(1));
      expect(find.byType(ScheduleDetailPage), findsNothing);
    });

    testWidgets('취소 요청 중에는 수정 버튼을 눌러도 수정 화면으로 이동하지 않는다', (tester) async {
      repository.deleteCompleter = Completer<void>();
      await pumpDetailPage(tester);

      await tapCancelAndConfirm(tester);
      await tester.tap(find.byKey(const Key('schedule-edit-button')));
      await tester.pumpAndSettle();

      expect(find.text('수정 화면'), findsNothing);
    });

    testWidgets('일정을 불러오지 못하면 안내 문구를 보여준다', (tester) async {
      repository.error = Exception('network');

      await pumpDetailPage(tester);

      expect(find.text('일정을 불러오지 못했어요'), findsOneWidget);
    });
  });
}
