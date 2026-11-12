import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/schedule/presentation/schedule_format.dart';
import 'package:moamoa/features/vote/domain/entities/vote_candidate.dart';
import 'package:moamoa/features/vote/domain/entities/vote_status.dart';
import 'package:moamoa/features/vote/presentation/pages/vote_page.dart';
import 'package:moamoa/features/vote/presentation/providers/vote_providers.dart';
import 'package:moamoa/features/vote/presentation/vote_format.dart';

import '../../fakes/fake_vote_repository.dart';
import '../../fakes/vote_fixtures.dart';

void main() {
  late FakeVoteRepository repository;

  /// 투표 화면을 띄운 push 의 결과. 확정하고 화면이 닫히면 true 가 담깁니다.
  late Future<bool?> pushed;

  setUp(() {
    repository = FakeVoteRepository(
      vote: sampleVote(),
      responses: sampleResponses(),
    );
  });

  /// 목록 화면(`/start`) 위에 투표 화면을 띄웁니다. 화면이 닫히면 목록 문구가 보입니다.
  Future<void> pumpPage(
    WidgetTester tester, {
    MemberRole role = MemberRole.admin,
  }) async {
    final router = GoRouter(
      initialLocation: '/start',
      routes: [
        GoRoute(
          path: '/start',
          builder: (_, _) => const Scaffold(body: Text('목록')),
        ),
        GoRoute(
          path: '/vote',
          builder: (_, _) => const VotePage(meetingId: 1, scheduleId: 7),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        retry: (_, _) => null,
        overrides: [
          voteRepositoryProvider.overrideWithValue(repository),
          groupMyRoleProvider.overrideWith((ref, groupId) async => role),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    pushed = router.push<bool>('/vote');
    await tester.pumpAndSettle();
  }

  Future<void> openConfirmSheet(WidgetTester tester) async {
    await tester.tap(find.text('일정 확정하기'));
    await tester.pumpAndSettle();
  }

  group(VotePage, () {
    testWidgets('후보 날짜·시각 표에 칸마다 가능 인원을 보여준다', (tester) async {
      // 관리자 응답 수(7·1)와 칸 숫자가 겹치지 않게 구성원으로 본다.
      await pumpPage(tester, role: MemberRole.member);

      expect(find.text('투표 중 · 9월 20일 마감'), findsOneWidget);
      expect(find.text('10월 정기 모임'), findsOneWidget);
      expect(find.text(DateTime(2099, 10, 13).shortDateLabel), findsOneWidget);
      expect(find.text(DateTime(2099, 10, 14).shortDateLabel), findsOneWidget);
      expect(find.text('18:00'), findsOneWidget);
      expect(find.text('19:00'), findsOneWidget);
      for (final count in ['2', '5', '0', '7']) {
        expect(find.text(count), findsOneWidget);
      }
    });

    testWidgets('후보 날짜가 많아도 표가 깨지지 않고 옆으로 넘겨 볼 수 있다', (tester) async {
      repository.vote = sampleVote().copyWith(
        candidates: [
          for (var day = 1; day <= 12; day++)
            VoteCandidate(
              meetingTime: DateTime(2099, 10, day, 19),
              availableCount: day % 8,
              selectedByMe: false,
            ),
        ],
      );

      // 375pt 폭 휴대폰 화면
      tester.view
        ..physicalSize = const Size(1125, 2436)
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      await pumpPage(tester, role: MemberRole.member);

      final header = find.text(DateTime(2099, 10, 1).shortDateLabel);
      expect(tester.takeException(), isNull);
      // 날짜 칸이 좁아지지 않아 머리글이 한 줄(머리줄 높이 20)에 들어간다
      expect(tester.getSize(header).width, greaterThanOrEqualTo(64));
      expect(tester.getSize(header).height, lessThanOrEqualTo(20));
    });

    testWidgets('관리자면 응답·미응답 수와 미응답 구성원 이름을 보여준다', (tester) async {
      await pumpPage(tester);

      expect(find.text('7/8명'), findsOneWidget);
      expect(find.text('응답'), findsOneWidget);
      expect(find.text('미응답'), findsOneWidget);
      expect(find.text('미응답 이름 미설정'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsOneWidget);
    });

    testWidgets('구성원이면 응답 인원만 보여주고 확정 버튼은 없다', (tester) async {
      await pumpPage(tester, role: MemberRole.member);

      expect(find.text('응답 7/8명'), findsOneWidget);
      expect(find.text('미응답'), findsNothing);
      expect(find.text('일정 확정하기'), findsNothing);
    });

    testWidgets('확정된 투표는 관리자에게도 확정 버튼을 보여주지 않는다', (tester) async {
      repository.vote = sampleVote(
        status: VoteStatus.confirmed,
        votingOpen: false,
      );

      await pumpPage(tester);

      expect(find.text('확정'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsNothing);
    });

    testWidgets('불러오지 못하면 안내와 다시 시도를 보여주고, 다시 시도하면 다시 불러온다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.network);
      await pumpPage(tester);

      expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);

      repository.error = null;
      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();

      expect(find.text('10월 정기 모임'), findsOneWidget);
    });

    testWidgets('확정 시트는 가능 인원이 많은 순으로 보여주고 맨 위를 골라 둔다', (tester) async {
      await pumpPage(tester);

      await openConfirmSheet(tester);

      expect(find.text('어느 시간으로 확정할까요?'), findsOneWidget);
      expect(find.text(DateTime(2099, 10, 14, 19).fieldLabel), findsOneWidget);
      expect(find.text('7명 가능 · 가장 많음'), findsOneWidget);
      expect(find.text('5명 가능'), findsOneWidget);
    });

    testWidgets('확정 시트에서 고른 시간으로 확정하면 true 를 돌려주며 화면을 닫는다', (tester) async {
      await pumpPage(tester);
      await openConfirmSheet(tester);

      await tester.tap(find.text(DateTime(2099, 10, 13, 19).fieldLabel));
      await tester.pumpAndSettle();
      await tester.tap(find.text('이 시간으로 확정'));
      await tester.pumpAndSettle();

      expect(
        repository.confirmCalls.single['meetingTime'],
        DateTime(2099, 10, 13, 19),
      );
      expect(await pushed, isTrue);
      expect(find.text('목록'), findsOneWidget);
    });

    testWidgets('다른 관리자가 먼저 확정해 실패하면 화면에 남아 안내하고 확정된 투표를 다시 보여준다', (
      tester,
    ) async {
      await pumpPage(tester);
      await openConfirmSheet(tester);
      repository
        ..confirmError = const ApiException(
          code: ApiErrorCode.unprocessableEntity,
          message: '이미 확정된 일정입니다.',
        )
        ..vote = sampleVote(status: VoteStatus.confirmed, votingOpen: false);

      await tester.tap(find.text('이 시간으로 확정'));
      await tester.pumpAndSettle();

      expect(find.text('이미 확정된 일정입니다.'), findsOneWidget);
      expect(find.byType(VotePage), findsOneWidget);
      expect(find.text('확정'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsNothing);
    });
  });
}
