import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/vote/presentation/pages/vote_create_page.dart';
import 'package:moamoa/features/vote/presentation/providers/vote_providers.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_time_range.dart';
import 'package:moamoa/features/vote/presentation/vote_format.dart';
import 'package:moamoa/features/vote/presentation/widgets/vote_time_sheet.dart';

import '../../fakes/fake_vote_repository.dart';

void main() {
  late FakeVoteRepository repository;

  /// 만들기 화면을 띄운 push 의 결과. 화면이 닫힐 때 돌려준 값이 담깁니다.
  late Future<int?> pushed;

  setUp(() {
    repository = FakeVoteRepository();
  });

  /// 목록 화면(`/start`) 위에 만들기 화면을 띄웁니다. 만들기가 끝나 화면이 닫히면 목록 문구가 보입니다.
  Future<ProviderContainer> pumpPage(WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: '/start',
      routes: [
        GoRoute(
          path: '/start',
          builder: (_, _) => const Scaffold(body: Text('목록')),
        ),
        GoRoute(
          path: '/create',
          builder: (_, _) => const VoteCreatePage(meetingId: 1),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [voteRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    pushed = router.push<int>('/create');
    await tester.pumpAndSettle();
    return ProviderScope.containerOf(
      tester.element(find.byType(VoteCreatePage)),
    );
  }

  void fillAll(ProviderContainer container) {
    container.read(voteCreateProvider(1).notifier)
      ..changeTitle('10월 정기 모임')
      ..changeDates([DateTime(2026, 10, 13)])
      ..changeDeadline(DateTime(2099, 10, 12, 23, 59));
  }

  group(VoteCreatePage, () {
    testWidgets('처음에는 빈 항목 수를 안내하고 기본 후보 시간을 보여준다', (tester) async {
      await pumpPage(tester);

      expect(find.text('3개 항목을 채우면 투표를 시작할 수 있어요'), findsOneWidget);
      expect(find.text('18:00 ~ 20:30 · 30분 단위'), findsOneWidget);
      expect(find.text('날짜를 골라 주세요'), findsOneWidget);
    });

    testWidgets('빈 항목이 있는데 시작하기를 누르면 항목마다 오류 문구를 보여준다', (tester) async {
      await pumpPage(tester);

      await tester.tap(find.text('투표 시작하기'));
      await tester.pump();

      expect(find.text('일정 이름을 입력해 주세요'), findsOneWidget);
      expect(find.text('후보 날짜를 하나 이상 골라 주세요'), findsOneWidget);
      expect(find.text('투표 마감을 골라 주세요'), findsOneWidget);
      expect(repository.createCalls, isEmpty);
    });

    testWidgets('후보 날짜 시트에서 두 날짜를 고르고 완료하면 칸에 고른 날짜를 보여준다', (tester) async {
      final now = DateTime.now();
      final first = DateTime(now.year, now.month, 13);
      final second = DateTime(now.year, now.month, 14);
      await pumpPage(tester);

      await tester.tap(find.text('날짜를 골라 주세요'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('13'));
      await tester.tap(find.text('14'));
      await tester.pump();

      expect(find.text('2일 선택'), findsOneWidget);
      await tester.tap(find.text('2일 선택 완료'));
      await tester.pumpAndSettle();

      expect(
        find.text('${first.shortDateLabel} · ${second.shortDateLabel}'),
        findsOneWidget,
      );
      expect(find.text('2개 항목을 채우면 투표를 시작할 수 있어요'), findsOneWidget);
    });

    testWidgets('후보 날짜 시트에서 칩을 누르면 그 날짜를 뺀다', (tester) async {
      final now = DateTime.now();
      final picked = DateTime(now.year, now.month, 13);
      await pumpPage(tester);

      await tester.tap(find.text('날짜를 골라 주세요'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('13'));
      await tester.pump();
      await tester.tap(find.text(picked.shortDateLabel));
      await tester.pump();

      expect(find.text(picked.shortDateLabel), findsNothing);
      expect(find.text('날짜를 골라 주세요'), findsWidgets); // 칸 문구 + 비활성 완료 버튼
    });

    testWidgets('후보 시간 시트에서 1시간 간격을 고르고 적용하면 칸 문구가 바뀐다', (tester) async {
      await pumpPage(tester);

      await tester.tap(find.text('18:00 ~ 20:30 · 30분 단위'));
      await tester.pumpAndSettle();
      expect(find.text('18:00부터 20:30까지 5칸으로 투표해요'), findsOneWidget);

      await tester.tap(find.text('1시간'));
      await tester.pump();
      expect(find.text('18:00부터 20:30까지 3칸으로 투표해요'), findsOneWidget);

      await tester.tap(find.text('적용'));
      await tester.pumpAndSettle();

      expect(find.text('18:00 ~ 20:30 · 1시간 단위'), findsOneWidget);
    });

    testWidgets('모두 채우고 시작하기를 누르면 투표를 만들고 만든 일정 id 를 돌려주며 화면을 닫는다', (
      tester,
    ) async {
      final container = await pumpPage(tester);
      fillAll(container);
      await tester.pump();

      await tester.tap(find.text('투표 시작하기'));
      await tester.pumpAndSettle();

      expect(repository.createCalls, hasLength(1));
      expect(find.text('목록'), findsOneWidget);
      expect(await pushed, 21);
    });

    testWidgets('만드는 중에는 뒤로가기로 화면을 닫지 않고 끝나면 일정 id 를 돌려준다', (tester) async {
      repository.createCompleter = Completer<int>();
      final container = await pumpPage(tester);
      fillAll(container);
      await tester.pump();

      await tester.tap(find.text('투표 시작하기'));
      await tester.pump();
      await tester.binding.handlePopRoute();
      await tester.pump();

      expect(find.byType(VoteCreatePage), findsOneWidget);

      repository.createCompleter!.complete(21);
      await tester.pumpAndSettle();

      expect(find.text('목록'), findsOneWidget);
      expect(await pushed, 21);
    });

    testWidgets('투표 마감을 지금 이전으로 고르면 마감 칸에 오류 문구를 보여준다', (tester) async {
      final container = await pumpPage(tester);
      container
          .read(voteCreateProvider(1).notifier)
          .changeDeadline(DateTime.now().subtract(const Duration(hours: 1)));
      await tester.pump();

      expect(find.text('투표 마감은 지금 이후로 골라 주세요'), findsOneWidget);
    });

    testWidgets('만들기에 실패하면 서버 문구를 안내하고 화면에 남는다', (tester) async {
      repository.error = const ApiException(
        code: ApiErrorCode.validation,
        message: '투표 마감 일시는 현재 이후여야 합니다.',
      );
      final container = await pumpPage(tester);
      fillAll(container);
      await tester.pump();

      await tester.tap(find.text('투표 시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('투표 마감 일시는 현재 이후여야 합니다.'), findsOneWidget);
      expect(find.byType(VoteCreatePage), findsOneWidget);
    });
  });

  group(VoteTimeSheet, () {
    testWidgets('종료가 시작보다 늦지 않으면 오류 문구를 보여주고 적용할 수 없다', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: VoteTimeSheet(
              initialRange: VoteTimeRange(
                end: Duration(hours: 17, minutes: 30),
              ),
            ),
          ),
        ),
      );

      expect(find.text('종료 시간은 시작 시간보다 늦어야 해요'), findsOneWidget);
      final apply = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, '적용'),
      );
      expect(apply.onPressed, isNull);
    });
  });
}
