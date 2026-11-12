import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_status.dart';
import 'package:moamoa/features/schedule/presentation/pages/schedule_list_page.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  final voting = Schedule(
    id: 7,
    title: '10월 정기 모임',
    startAt: DateTime(2099, 10, 13, 18),
    location: '강남 스터디룸 3호',
    status: ScheduleStatus.voting,
  );

  late FakeScheduleRepository repository;

  setUp(() {
    repository = FakeScheduleRepository(schedules: [voting]);
  });

  /// 일정 목록과 상세·투표 화면 자리를 둡니다.
  /// 투표 화면 대신 확정했다고 true 를 돌려주는 버튼과 그냥 닫는 버튼을 둡니다.
  Future<void> pumpList(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/meetings/1/schedules',
      routes: [
        GoRoute(
          path: '/meetings/:meetingId/schedules',
          builder: (_, _) => const ScheduleListPage(meetingId: 1),
          routes: [
            GoRoute(
              path: ':scheduleId',
              builder: (_, _) => const Scaffold(body: Text('일정 상세 화면')),
            ),
          ],
        ),
        GoRoute(
          path: '/meetings/:meetingId/schedule-votes/:scheduleId',
          builder: (context, state) => Scaffold(
            body: Column(
              children: [
                Text('투표 화면 ${state.pathParameters['scheduleId']}'),
                TextButton(
                  onPressed: () => context.pop(true),
                  child: const Text('일정 확정 완료'),
                ),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('확정하지 않고 닫기'),
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
          scheduleAdminProvider.overrideWith((ref, meetingId) => false),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('일정 목록의 투표 중 일정', () {
    testWidgets('투표 중 일정은 날짜 대신 투표 배지와 투표 중 라벨을 보여주고 임시 시작 시각은 숨긴다', (
      tester,
    ) async {
      await pumpList(tester);

      expect(find.text('투표'), findsOneWidget);
      expect(find.text('투표 중'), findsOneWidget);
      expect(find.text('확정'), findsNothing);
      expect(find.textContaining('18:00'), findsNothing);
      expect(find.text('강남 스터디룸 3호'), findsOneWidget);
    });

    testWidgets('투표 중 일정을 누르면 상세 대신 투표 화면으로 이동한다', (tester) async {
      await pumpList(tester);

      await tester.tap(find.text('10월 정기 모임'));
      await tester.pumpAndSettle();

      expect(find.text('투표 화면 7'), findsOneWidget);
    });

    testWidgets('투표 화면에서 확정하고 돌아오면 일정 목록을 다시 불러온다', (tester) async {
      await pumpList(tester);
      await tester.tap(find.text('10월 정기 모임'));
      await tester.pumpAndSettle();
      final before = repository.listCallCount;

      await tester.tap(find.text('일정 확정 완료'));
      await tester.pumpAndSettle();

      expect(repository.listCallCount, greaterThan(before));
    });

    testWidgets('확정하지 않고 돌아오면 일정 목록을 다시 불러오지 않는다', (tester) async {
      await pumpList(tester);
      await tester.tap(find.text('10월 정기 모임'));
      await tester.pumpAndSettle();
      final before = repository.listCallCount;

      await tester.tap(find.text('확정하지 않고 닫기'));
      await tester.pumpAndSettle();

      expect(repository.listCallCount, before);
    });

    testWidgets('투표가 아닌 일정을 누르면 일정 상세로 이동한다', (tester) async {
      repository.schedules = [
        voting.copyWith(status: ScheduleStatus.confirmed),
      ];
      await pumpList(tester);

      await tester.tap(find.text('10월 정기 모임'));
      await tester.pumpAndSettle();

      expect(find.text('일정 상세 화면'), findsOneWidget);
    });
  });
}
