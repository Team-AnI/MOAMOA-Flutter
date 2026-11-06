import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_edit_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/schedule_format.dart';

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

  /// 화면을 닫는 동작(context.pop)을 확인할 수 있게 GoRouter 위에 수정 화면을 올려 둡니다.
  Future<void> pumpEditPage(WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Scaffold()),
        GoRoute(
          path: '/edit',
          builder: (_, _) =>
              const ScheduleEditPage(meetingId: 1, scheduleId: 20),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [scheduleRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    router.push('/edit');
    await tester.pumpAndSettle();
  }

  FilledButton submitButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, '수정 완료'));

  /// [field] 글자가 보이는 일시 칸을 눌러, 같은 달의 [day] 일을 고르고 시간은 그대로 확인합니다.
  Future<void> pickDay(WidgetTester tester, String field, int day) async {
    await tester.tap(find.text(field));
    await tester.pumpAndSettle();
    await tester.tap(find.text('$day'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
  }

  group('ScheduleEditPage', () {
    testWidgets('기존 일정 값을 채워서 보여준다', (tester) async {
      await pumpEditPage(tester);

      expect(find.text('10월 정기 러닝'), findsOneWidget);
      expect(find.text('반포 한강공원'), findsOneWidget);
      expect(find.text('반포 한강공원 집합'), findsOneWidget);
      expect(find.textContaining('10월 20일'), findsNWidgets(2));
    });

    testWidgets('아무것도 바꾸지 않으면 수정 완료 버튼이 비활성화된다', (tester) async {
      await pumpEditPage(tester);

      expect(submitButton(tester).onPressed, isNull);
    });

    testWidgets('이름 앞뒤에 공백만 넣으면 수정 완료 버튼이 비활성화된다', (tester) async {
      await pumpEditPage(tester);

      await tester.enterText(find.byType(TextField).first, '  10월 정기 러닝  ');
      await tester.pump();

      expect(submitButton(tester).onPressed, isNull);
    });

    // 서버 응답의 시각은 UTC 로 오고, 입력 폼은 로컬 시각으로 보여준다.
    testWidgets('UTC 로 받은 일정을 바꾸지 않으면 수정 완료 버튼이 비활성화된다', (tester) async {
      repository.schedules = [
        run.copyWith(startAt: run.startAt.toUtc(), endAt: run.endAt!.toUtc()),
      ];
      await pumpEditPage(tester);

      expect(submitButton(tester).onPressed, isNull);
    });

    testWidgets('이름을 비우면 수정 완료 버튼이 비활성화된다', (tester) async {
      await pumpEditPage(tester);
      await tester.enterText(find.byType(TextField).first, '');
      await tester.pump();

      expect(submitButton(tester).onPressed, isNull);
    });

    testWidgets('이름을 바꾸고 수정 완료를 누르면 바뀐 이름만 저장하고 화면을 닫는다', (tester) async {
      await pumpEditPage(tester);

      await tester.enterText(find.byType(TextField).first, '11월 정기 러닝');
      await tester.pump();
      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();

      final request = repository.updateCalls.single;
      expect(request.title, '11월 정기 러닝');
      expect(request.location, isNull);
      expect(find.byType(ScheduleEditPage), findsNothing);
    });

    testWidgets('저장에 실패하면 안내를 보여주고 화면을 유지한다', (tester) async {
      await pumpEditPage(tester);
      repository.error = Exception('network');

      await tester.enterText(find.byType(TextField).first, '11월 정기 러닝');
      await tester.pump();
      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();

      expect(find.text('일정을 수정하지 못했어요'), findsOneWidget);
      expect(find.byType(ScheduleEditPage), findsOneWidget);
    });

    testWidgets('저장에 두 번 연속 실패하면 두 번째에도 안내를 보여준다', (tester) async {
      await pumpEditPage(tester);
      repository.error = Exception('network');
      await tester.enterText(find.byType(TextField).first, '11월 정기 러닝');
      await tester.pump();
      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();
      // 첫 안내가 사라질 때까지 기다린다.
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      expect(find.text('일정을 수정하지 못했어요'), findsNothing);

      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();

      expect(repository.updateCalls, hasLength(2));
      expect(find.text('일정을 수정하지 못했어요'), findsOneWidget);
    });

    testWidgets('설명을 공백으로, 장소를 비우면 둘 다 빈 문자열로 저장한다', (tester) async {
      await pumpEditPage(tester);

      await tester.enterText(find.byType(TextField).at(1), '');
      await tester.enterText(find.byType(TextField).at(2), '   ');
      await tester.pump();
      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();

      final request = repository.updateCalls.single;
      expect(request.location, '');
      expect(request.description, '');
      expect(request.title, isNull);
    });

    testWidgets('시작 일시만 바꾸면 바뀐 시작 일시만 저장한다', (tester) async {
      await pumpEditPage(tester);

      await pickDay(tester, startAt.fieldLabel, 21);
      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();

      final request = repository.updateCalls.single;
      expect(request.startAt, DateTime(2026, 10, 21, 19));
      expect(request.endAt, isNull);
      expect(request.title, isNull);
    });

    testWidgets('종료 일시가 없던 일정에 종료 일시를 넣으면 종료 일시를 저장한다', (tester) async {
      repository.schedules = [run.copyWith(endAt: null)];
      await pumpEditPage(tester);

      await pickDay(tester, '날짜와 시간을 선택해 주세요', 21);
      await tester.tap(find.text('수정 완료'));
      await tester.pumpAndSettle();

      final request = repository.updateCalls.single;
      expect(request.endAt, DateTime(2026, 10, 21, 19));
      expect(request.startAt, isNull);
    });

    testWidgets('일정을 불러오지 못하면 안내 문구를 보여준다', (tester) async {
      repository.error = Exception('network');

      await pumpEditPage(tester);

      expect(find.text('일정을 불러오지 못했어요'), findsOneWidget);
    });

    testWidgets('3년 넘게 지난 일정도 시작 일시를 누르면 오류 없이 날짜 선택창이 열린다', (tester) async {
      final oldStart = DateTime(DateTime.now().year - 3, 5, 10, 19);
      repository.schedules = [run.copyWith(startAt: oldStart, endAt: null)];
      await pumpEditPage(tester);

      await tester.tap(find.text(oldStart.fieldLabel));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('10년 뒤의 먼 일정도 시작 일시를 누르면 오류 없이 날짜 선택창이 열린다', (tester) async {
      final farStart = DateTime(DateTime.now().year + 10, 5, 10, 19);
      repository.schedules = [run.copyWith(startAt: farStart, endAt: null)];
      await pumpEditPage(tester);

      await tester.tap(find.text(farStart.fieldLabel));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(DatePickerDialog), findsOneWidget);
    });
  });
}
