import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_list_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;

  setUp(() {
    repository = FakeScheduleRepository();
  });

  /// 일정 목록(관리자)에서 만들기 화면 두 곳으로 갈 수 있게 라우터를 꾸리고, 만들기 버튼을 누릅니다.
  /// 투표 만들기 화면 대신 만든 일정 id(21)를 돌려주는 버튼과 그냥 닫는 버튼을 둡니다.
  Future<void> pumpList(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/meetings/1/schedules',
      routes: [
        GoRoute(
          path: '/meetings/:meetingId/schedules',
          builder: (_, _) => const ScheduleListPage(meetingId: 1),
          routes: [
            GoRoute(
              path: 'new',
              builder: (_, _) => const Scaffold(body: Text('바로 만들기 화면')),
            ),
          ],
        ),
        GoRoute(
          path: '/meetings/:meetingId/schedule-votes/new',
          builder: (context, _) => Scaffold(
            body: Column(
              children: [
                const Text('투표 만들기 화면'),
                TextButton(
                  onPressed: () => context.pop(21),
                  child: const Text('투표 만들기 완료'),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('투표 만들기 취소'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          scheduleRepositoryProvider.overrideWithValue(repository),
          scheduleAdminProvider.overrideWith((ref, meetingId) => true),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('schedule-add-button')));
    await tester.pumpAndSettle();
  }

  group('일정 목록의 만들기 방식 선택', () {
    testWidgets('일정 만들기 버튼을 누르면 바로 정하기와 투표로 정하기를 보여준다', (tester) async {
      await pumpList(tester);

      expect(find.text('시간을 어떻게 정할까요?'), findsOneWidget);
      expect(find.text('바로 정하기'), findsOneWidget);
      expect(find.text('투표로 정하기'), findsOneWidget);
    });

    testWidgets('바로 정하기를 누르면 일정 만들기 화면으로 이동한다', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text('바로 정하기'));
      await tester.pumpAndSettle();

      expect(find.text('바로 만들기 화면'), findsOneWidget);
    });

    testWidgets('투표로 정하기를 누르면 투표 만들기 화면으로 이동한다', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text('투표로 정하기'));
      await tester.pumpAndSettle();

      expect(find.text('투표 만들기 화면'), findsOneWidget);
    });

    testWidgets('투표를 만들고 돌아오면 일정 목록을 다시 불러온다', (tester) async {
      await pumpList(tester);
      await tester.tap(find.text('투표로 정하기'));
      await tester.pumpAndSettle();
      final before = repository.listCallCount;

      await tester.tap(find.text('투표 만들기 완료'));
      await tester.pumpAndSettle();

      expect(repository.listCallCount, greaterThan(before));
    });

    testWidgets('투표를 만들지 않고 돌아오면 일정 목록을 다시 불러오지 않는다', (tester) async {
      await pumpList(tester);
      await tester.tap(find.text('투표로 정하기'));
      await tester.pumpAndSettle();
      final before = repository.listCallCount;

      await tester.tap(find.text('투표 만들기 취소'));
      await tester.pumpAndSettle();

      expect(repository.listCallCount, before);
    });
  });
}
