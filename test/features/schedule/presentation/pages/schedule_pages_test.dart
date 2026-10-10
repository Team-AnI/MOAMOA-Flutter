import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_create_page.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_detail_page.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_list_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/widgets/schedule_calendar.dart';

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

  FilledButton submitButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, '일정 만들기'));

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
    testWidgets('캘린더 탭에서 불러오지 못하면 오류 문구를 보여준다', (tester) async {
      repository.error = Exception('network');
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));

      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();

      expect(find.text('일정을 불러오지 못했어요'), findsOneWidget);
      expect(find.text('다시 시도'), findsOneWidget);
    });

    testWidgets('캘린더 탭에서 선택한 날짜에 일정이 없으면 안내 문구를 보여준다', (tester) async {
      repository.schedules = [];
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));

      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();

      expect(find.text('선택한 날짜에 일정이 없어요'), findsOneWidget);
    });
    testWidgets('캘린더에서 월을 바꾸면 선택 날짜도 그 달로 옮긴다', (tester) async {
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));
      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();
      final next = DateTime(now.year, now.month + 1);

      await tester.tap(find.byKey(const Key('calendar-next-month')));
      await tester.pumpAndSettle();

      // 다음 달로 가면 그 달 1일이 선택된다. (이전 달 날짜가 남아 있으면 안 된다)
      expect(find.textContaining('${next.month}월 1일 '), findsOneWidget);

      await tester.tap(find.byKey(const Key('calendar-prev-month')));
      await tester.pumpAndSettle();

      // 이번 달로 돌아오면 오늘이 선택된다.
      expect(find.textContaining('${now.month}월 ${now.day}일 '), findsOneWidget);
    });
    testWidgets('목록과 캘린더를 오가도 보던 달과 선택 날짜가 유지된다', (tester) async {
      await pumpPage(tester, const ScheduleListPage(meetingId: 1));
      final next = DateTime(now.year, now.month + 1);
      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('calendar-next-month')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('목록'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();

      expect(find.text('${next.year}년 ${next.month}월'), findsOneWidget);
      expect(find.textContaining('${next.month}월 1일 '), findsOneWidget);
    });
  });

  group('일정 만들기', () {
    testWidgets('상단 바는 AppBar 를 사용한다', (tester) async {
      await pumpPage(tester, const ScheduleCreatePage(meetingId: 1));

      expect(find.byType(MoaAppBar), findsOneWidget);
    });

    testWidgets('필수 입력이 없으면 만들기 버튼이 비활성화된다', (tester) async {
      await pumpPage(tester, const ScheduleCreatePage(meetingId: 1));

      expect(submitButton(tester).onPressed, isNull);

      await tester.enterText(find.byType(TextField).first, '정모');
      await tester.pump();
      expect(submitButton(tester).onPressed, isNull);
    });

    testWidgets('이름과 시작 일시를 입력하면 만들기 버튼이 활성화된다', (tester) async {
      await pumpPage(tester, const ScheduleCreatePage(meetingId: 1));

      await tester.enterText(find.byType(TextField).first, '정모');
      await tester.tap(find.text('날짜와 시간을 선택해 주세요').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(submitButton(tester).onPressed, isNotNull);
    });
  });

  testWidgets('달력은 month 가 1일이 아니어도 1일의 요일 위치가 같다', (tester) async {
    Future<Offset> firstDayPosition(DateTime month) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScheduleCalendar(
              month: month,
              selected: DateTime(2026, 10, 20),
              markedDays: const {},
              onMonthChanged: (_) {},
              onSelected: (_) {},
            ),
          ),
        ),
      );
      return tester.getTopLeft(find.text('1'));
    }

    final fromFirst = await firstDayPosition(DateTime(2026, 10));
    final fromMiddle = await firstDayPosition(DateTime(2026, 10, 16));

    expect(fromMiddle, fromFirst);
  });

  testWidgets('일정 상세에 제목, 일시, 장소, 설명을 보여준다', (tester) async {
    await pumpPage(
      tester,
      const ScheduleDetailPage(meetingId: 1, scheduleId: 20),
    );

    expect(find.byType(MoaAppBar), findsOneWidget);
    expect(find.text('10월 정기 러닝'), findsOneWidget);
    expect(find.textContaining('19:00 ~ 21:00'), findsOneWidget);
    expect(find.text('반포 한강공원'), findsOneWidget);
    expect(find.text('반포 한강공원 집합'), findsOneWidget);
  });
}
