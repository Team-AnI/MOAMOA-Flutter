import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_create_page.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_detail_page.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_list_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  final now = DateTime.now();
  final today7pm = DateTime(now.year, now.month, now.day, 19);
  final run = Schedule(
    id: 20,
    title: '10월 정기 러닝',
    description: '반포 한강공원 집합',
    startAt: today7pm,
    endAt: today7pm.add(const Duration(hours: 2)),
    location: '반포 한강공원',
  );

  late FakeScheduleRepository repository;

  setUp(() {
    repository = FakeScheduleRepository(schedules: [run]);
  });

  Future<void> pumpPage(
    WidgetTester tester,
    Widget page, {
    bool isAdmin = true,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          scheduleRepositoryProvider.overrideWithValue(repository),
          scheduleAdminProvider.overrideWithValue(isAdmin),
        ],
        child: MaterialApp(home: page),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('일정 목록', () {
    testWidgets('일정 카드에 제목, 장소, 상태를 보여준다', (tester) async {
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));

      expect(find.text('10월 정기 러닝'), findsOneWidget);
      expect(find.text('반포 한강공원'), findsOneWidget);
      expect(find.text('${today7pm.month}월'), findsOneWidget);
      expect(find.text('${today7pm.day}'), findsOneWidget);
      expect(find.textContaining('19:00'), findsOneWidget); // 요일과 함께 표시
    });

    testWidgets('일정이 없으면 안내 문구를 보여준다', (tester) async {
      repository.schedules = [];

      await pumpPage(tester, const ScheduleListPage(meetingId: 1));

      expect(find.text('등록된 일정이 없어요'), findsOneWidget);
    });

    testWidgets('관리자에게만 일정 만들기 버튼을 보여준다', (tester) async {
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));
      expect(find.byKey(const Key('schedule-add-button')), findsOneWidget);

      await pumpPage(
        tester,
        const ScheduleListPage(meetingId: 1),
        isAdmin: false,
      );
      expect(find.byKey(const Key('schedule-add-button')), findsNothing);
    });

    testWidgets('캘린더 탭에서 선택한 날짜의 일정을 보여준다', (tester) async {
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));

      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();

      expect(find.text('${now.year}년 ${now.month}월'), findsOneWidget);
      expect(find.text('19:00'), findsOneWidget);
      expect(find.text('2시간'), findsOneWidget);
      expect(find.text('10월 정기 러닝'), findsOneWidget);
    });
  });

  group('일정 만들기', () {
    testWidgets('필수 입력 없이 만들면 저장하지 않고 오류 문구를 보여준다', (tester) async {
      await pumpPage(tester, const ScheduleCreatePage(meetingId: 1));

      await tester.tap(find.widgetWithText(FilledButton, '일정 만들기'));
      await tester.pumpAndSettle();

      expect(find.text('일정 이름을 입력해 주세요.'), findsOneWidget);
      expect(find.text('시작 일시를 선택해 주세요.'), findsOneWidget);
      expect(repository.createCalls, isEmpty);
    });

    testWidgets('제목만 입력하면 시작 일시 오류만 남는다', (tester) async {
      await pumpPage(tester, const ScheduleCreatePage(meetingId: 1));

      await tester.enterText(find.byType(TextField).first, '정모');
      await tester.tap(find.widgetWithText(FilledButton, '일정 만들기'));
      await tester.pumpAndSettle();

      expect(find.text('일정 이름을 입력해 주세요.'), findsNothing);
      expect(find.text('시작 일시를 선택해 주세요.'), findsOneWidget);
    });
  });

  testWidgets('이전에 만든 일정이 있어도 잘못된 입력이면 화면을 닫지 않고 오류를 보여준다', (tester) async {
    final container = ProviderContainer(
      overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final provider = scheduleCreateProvider(1);
    container.listen(provider, (_, _) {}); // 이전 제출 결과가 남아 있는 상황
    await container
        .read(provider.notifier)
        .submit(title: '정모', startAt: DateTime(2026, 10, 11, 7));
    expect(container.read(provider).value, 100);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: ScheduleCreatePage(meetingId: 1)),
      ),
    );
    await tester.tap(find.widgetWithText(FilledButton, '일정 만들기'));
    await tester.pumpAndSettle();

    expect(find.text('일정 이름을 입력해 주세요.'), findsOneWidget);
  });

  testWidgets('일정 상세에 제목, 일시, 장소, 설명을 보여준다', (tester) async {
    await pumpPage(
      tester,
      const ScheduleDetailPage(meetingId: 1, scheduleId: 20),
    );

    expect(find.text('10월 정기 러닝'), findsOneWidget);
    expect(find.textContaining('19:00 ~ 21:00'), findsOneWidget);
    expect(find.text('반포 한강공원'), findsOneWidget);
    expect(find.text('반포 한강공원 집합'), findsOneWidget);
  });
}
