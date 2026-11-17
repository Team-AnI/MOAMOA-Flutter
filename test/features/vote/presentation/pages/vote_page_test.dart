import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/schedule/presentation/schedule_format.dart';
import 'package:moamoa/features/vote/domain/entities/vote.dart';
import 'package:moamoa/features/vote/domain/entities/vote_candidate.dart';
import 'package:moamoa/features/vote/domain/entities/vote_status.dart';
import 'package:moamoa/features/vote/presentation/pages/vote_page.dart';
import 'package:moamoa/features/vote/presentation/providers/vote_providers.dart';
import 'package:moamoa/features/vote/presentation/widgets/vote_confirm_sheet.dart';
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
        // 확정된 투표의 "일정 보기" 가 이동하는 일정 상세 자리
        GoRoute(
          path: '/meetings/:meetingId/schedules/:scheduleId',
          builder: (_, state) => Scaffold(
            body: Text('일정 상세 ${state.pathParameters['scheduleId']}'),
          ),
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

    // 시안(Figma)과 맞춘 부분: 알약 너비, 상태별 안내 문구, 일정 보기, 공유, 확정 시트 안전영역
    testWidgets('상태 알약은 화면 폭이 아니라 글자 너비만큼만 차지한다', (tester) async {
      await pumpPage(tester, role: MemberRole.member);

      final pill = find
          .ancestor(
            of: find.text('투표 중 · 9월 20일 마감'),
            matching: find.byType(Container),
          )
          .first;

      expect(tester.getSize(pill).width, lessThan(240));
    });

    testWidgets('마감된 투표는 구성원에게 "투표가 끝났어요." 를 보여주고 확정 버튼은 없다', (tester) async {
      repository.vote = sampleVote(votingOpen: false);

      await pumpPage(tester, role: MemberRole.member);

      expect(find.text('투표 마감'), findsOneWidget);
      expect(find.text('투표가 끝났어요.'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsNothing);
    });

    testWidgets('마감된 투표는 관리자에게 확정 전임을 알리고 일정 확정하기를 보여준다', (tester) async {
      repository.vote = sampleVote(votingOpen: false);

      await pumpPage(tester);

      expect(find.text('투표 마감 · 확정 전'), findsOneWidget);
      expect(find.text('투표가 끝났어요. 일정을 확정해 주세요.'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsOneWidget);
    });

    testWidgets('확정된 투표는 안내와 "일정 보기" 만 보여주고, 누르면 일정 상세로 이동한다', (tester) async {
      repository.vote = sampleVote(
        status: VoteStatus.confirmed,
        votingOpen: false,
      );
      await pumpPage(tester, role: MemberRole.member);

      expect(find.text('투표로 정한 일정이에요.'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsNothing);

      await tester.tap(find.text('일정 보기'));
      await tester.pumpAndSettle();

      expect(find.text('일정 상세 7'), findsOneWidget);
    });

    testWidgets('취소된 투표는 안내만 보여주고 버튼은 없다', (tester) async {
      repository.vote = sampleVote(
        status: VoteStatus.canceled,
        votingOpen: false,
      );

      await pumpPage(tester);

      expect(find.text('취소된 투표'), findsOneWidget);
      expect(find.text('관리자가 투표를 취소했어요.'), findsOneWidget);
      expect(find.text('일정 확정하기'), findsNothing);
      expect(find.text('일정 보기'), findsNothing);
    });

    testWidgets('공유 버튼을 누르면 투표 이름과 상태를 복사하고 안내한다', (tester) async {
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String?;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await pumpPage(tester, role: MemberRole.member);

      await tester.tap(find.byTooltip('공유'));
      await tester.pumpAndSettle();

      expect(copied, '[모아모아] 일정 투표 · 10월 정기 모임\n투표 중 · 9월 20일 마감');
      expect(find.text('투표 내용을 복사했어요'), findsOneWidget);
    });

    testWidgets('투표를 불러오지 못하면 공유 버튼을 보여주지 않는다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.network);

      await pumpPage(tester);

      expect(find.byTooltip('공유'), findsNothing);
    });

    testWidgets('확정 시트는 후보가 많아 화면 끝까지 길어져도 상태바·Dynamic Island 아래에서 시작한다', (
      tester,
    ) async {
      // 상단 59pt 가 상태바 영역인 휴대폰 화면
      tester.view
        ..physicalSize = const Size(1179, 2556)
        ..devicePixelRatio = 3
        ..padding = const FakeViewPadding(top: 177);
      addTearDown(tester.view.reset);
      // 시트가 화면 위쪽까지 닿으려면 후보가 많아야 합니다.
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
      await pumpPage(tester);

      await openConfirmSheet(tester);

      expect(
        tester.getTopLeft(find.text('어느 시간으로 확정할까요?')).dy,
        greaterThanOrEqualTo(59),
      );
    });

    // 리뷰(gemini): 후보가 하나도 없어도 화면이 깨지지 않아야 합니다.
    testWidgets('후보가 하나도 없어도 투표 화면이 오류 없이 열린다', (tester) async {
      repository.vote = sampleVote().copyWith(candidates: []);

      await pumpPage(tester, role: MemberRole.member);

      expect(tester.takeException(), isNull);
      expect(find.text('10월 정기 모임'), findsOneWidget);
    });

    testWidgets('후보가 없으면 확정 시트의 확정 버튼은 눌리지 않는다', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: VoteConfirmSheet(candidates: [])),
        ),
      );

      final confirm = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, '이 시간으로 확정'),
      );
      expect(confirm.onPressed, isNull);
      expect(tester.takeException(), isNull);
    });

    // 후보가 많을 때(Figma "후보가 많을 때"): 날짜 5개 × 시각 10줄
    group('후보가 많을 때', () {
      Vote manyVote() => sampleVote().copyWith(
        candidates: [
          for (var day = 1; day <= 5; day++)
            for (var hour = 12; hour < 22; hour++)
              VoteCandidate(
                meetingTime: DateTime(2099, 10, day, hour),
                availableCount: (day + hour) % 9,
                selectedByMe: false,
              ),
        ],
      );

      Future<void> pumpMany(WidgetTester tester) async {
        tester.view
          ..physicalSize = const Size(393, 852)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        repository.vote = manyVote();
        await pumpPage(tester, role: MemberRole.member);
      }

      testWidgets('넘겨 보라는 안내를 보여준다', (tester) async {
        await pumpMany(tester);

        expect(find.text('날짜는 옆으로, 시간은 위아래로 넘겨 보세요.'), findsOneWidget);
      });

      testWidgets('후보가 적으면 안내와 스크롤 영역 없이 보여준다', (tester) async {
        await pumpPage(tester, role: MemberRole.member);

        expect(find.text('날짜는 옆으로, 시간은 위아래로 넘겨 보세요.'), findsNothing);
      });

      testWidgets('칸 영역을 위아래로 넘기면 시각 열이 같이 움직이고 날짜 머리줄은 제자리에 있다', (
        tester,
      ) async {
        await pumpMany(tester);
        final time = find.text('12:00');
        final dateLabel = find.text(DateTime(2099, 10, 1).shortDateLabel);
        final timeBefore = tester.getTopLeft(time).dy;
        final dateBefore = tester.getTopLeft(dateLabel).dy;

        await tester.drag(
          find.byKey(const Key('vote-grid')),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        expect(timeBefore - tester.getTopLeft(time).dy, closeTo(100, 20));
        expect(tester.getTopLeft(dateLabel).dy, dateBefore);
      });

      testWidgets('칸 영역을 옆으로 넘기면 날짜 머리줄이 같이 움직이고 시각 열은 제자리에 있다', (
        tester,
      ) async {
        await pumpMany(tester);
        final time = find.text('12:00');
        final dateLabel = find.text(DateTime(2099, 10, 1).shortDateLabel);
        final dateBefore = tester.getTopLeft(dateLabel).dx;
        final timeBefore = tester.getTopLeft(time).dx;

        await tester.drag(
          find.byKey(const Key('vote-grid')),
          const Offset(-100, 0),
        );
        await tester.pumpAndSettle();

        expect(dateBefore - tester.getTopLeft(dateLabel).dx, closeTo(100, 20));
        expect(tester.getTopLeft(time).dx, timeBefore);
      });

      testWidgets('칸 영역 높이를 286 으로 고정해 아래 줄은 밖에 있다', (tester) async {
        await pumpMany(tester);

        final top = tester.getTopLeft(find.text('12:00')).dy;
        // 시각 열의 마지막 줄은 고정된 영역(286) 밖에 있어 화면에 닿지 않고 스크롤로만 보입니다.
        expect(
          tester.getTopLeft(find.text('21:00')).dy - top,
          greaterThan(286),
        );
      });
    });
  });
}
