import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/notice/domain/entities/notice.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/notice_routes.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_detail_page.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_list_page.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_write_page.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_group_my_role.dart';
import '../../fakes/fake_notice_repository.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester,
    FakeNoticeRepository repository,
    Widget page, {
    FakeGroupMyRole? myRole,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          noticeRepositoryProvider.overrideWithValue(repository),
          (myRole ?? FakeGroupMyRole()).override,
        ],
        retry: (_, _) => null,
        child: MaterialApp(home: page),
      ),
    );
  }

  /// 뒤로 갈 수 있도록 이전 화면 위에 [page] 를 띄웁니다.
  Future<void> pumpPushedPage(
    WidgetTester tester,
    FakeNoticeRepository repository,
    Widget page, {
    FakeGroupMyRole? myRole,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          noticeRepositoryProvider.overrideWithValue(repository),
          (myRole ?? FakeGroupMyRole()).override,
        ],
        retry: (_, _) => null,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute<void>(builder: (_) => page)),
                child: const Text('이전 화면'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('이전 화면'));
    await tester.pumpAndSettle();
  }

  group('공지 목록', () {
    const page = NoticeListPage(meetingId: 1);

    testWidgets('공지 목록을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1, title: '10월 회비 안내')]),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('10월 회비 안내'), findsOneWidget);
    });

    testWidgets('오래된 공지는 작성 시각을 개월·년 단위로 보여준다', (tester) async {
      final now = DateTime.now();
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            Notice(
              id: 2,
              title: '석 달 전 공지',
              content: '내용',
              createdAt: now.subtract(const Duration(days: 95)),
            ),
            Notice(
              id: 1,
              title: '이 년 전 공지',
              content: '내용',
              createdAt: now.subtract(const Duration(days: 800)),
            ),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('3개월 전'), findsOneWidget);
      expect(find.text('2년 전'), findsOneWidget);
    });

    // 예외처리 4-2
    testWidgets('공지가 없으면 관리자에게는 작성 버튼을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(),
        page,
        myRole: FakeGroupMyRole.admin(),
      );
      await tester.pumpAndSettle();

      expect(find.text('아직 등록된 공지가 없어요'), findsOneWidget);
      expect(find.text('공지 작성하기'), findsOneWidget);
      expect(find.text('첫 공지를 작성해 보세요'), findsOneWidget);
      expect(find.byTooltip('공지 작성'), findsOneWidget);
    });

    testWidgets('공지가 없으면 일반 구성원에게는 작성 버튼을 보여주지 않는다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);
      await tester.pumpAndSettle();

      expect(find.text('아직 등록된 공지가 없어요'), findsOneWidget);
      expect(find.text('첫 공지를 작성해 보세요'), findsNothing);
      expect(find.text('공지 작성하기'), findsNothing);
      expect(find.byTooltip('공지 작성'), findsNothing);
    });

    testWidgets('공지가 없어도 당겨서 새로고침할 수 있다', (tester) async {
      final repository = FakeNoticeRepository();
      await pumpPage(tester, repository, page);
      await tester.pumpAndSettle();
      expect(repository.getNoticesCallCount, 1);

      await tester.drag(find.byType(Scrollable).first, const Offset(0, 300));
      await tester.pumpAndSettle();

      expect(repository.getNoticesCallCount, 2);
    });
  });

  group('공지 작성', () {
    const page = NoticeWritePage(meetingId: 1);

    // 예외처리 4-1
    testWidgets('필수값이 빠진 채 등록하면 빠진 항목을 안내하고 등록하지 않는다', (tester) async {
      final repository = FakeNoticeRepository();
      await pumpPage(tester, repository, page);

      await tester.tap(find.text('공지 등록'));
      await tester.pumpAndSettle();

      expect(find.text('공지 제목을 입력해주세요'), findsOneWidget);
      expect(find.text('공지 내용을 입력해주세요'), findsOneWidget);
      expect(repository.notices, isEmpty);
    });

    testWidgets('빠진 항목을 입력하면 해당 안내가 사라진다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);
      await tester.tap(find.text('공지 등록'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pumpAndSettle();

      expect(find.text('공지 제목을 입력해주세요'), findsNothing);
      expect(find.text('공지 내용을 입력해주세요'), findsOneWidget);
    });

    // 예외처리 4-3
    testWidgets('등록에 실패하면 작성한 내용을 유지하고 다시 시도를 안내한다', (tester) async {
      final repository = FakeNoticeRepository()
        ..error = const NoticeException('네트워크 연결을 확인해주세요.');
      await pumpPage(tester, repository, page);

      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.enterText(find.byType(TextField).last, '10일까지 납부');
      await tester.tap(find.text('공지 등록'));
      await tester.pumpAndSettle();

      expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
      expect(find.text('다시 시도'), findsOneWidget);
      expect(find.text('10월 회비 안내'), findsOneWidget);
      expect(find.text('10일까지 납부'), findsOneWidget);
    });

    String enteredTitle(WidgetTester tester) =>
        tester.widget<TextField>(find.byType(TextField).first).controller!.text;

    testWidgets('제목을 50자까지 입력하면 모두 입력된다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);

      await tester.enterText(find.byType(TextField).first, '가' * 50);
      await tester.pump();

      expect(enteredTitle(tester).length, 50);
    });

    testWidgets('제목을 51자 이상 입력하면 50자까지만 남는다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);

      await tester.enterText(find.byType(TextField).first, '가' * 55);
      await tester.pump();

      expect(enteredTitle(tester).length, 50);
    });

    testWidgets('제목 입력칸 아래에 현재 글자 수를 최대 50자와 함께 보여준다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);

      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pump();

      expect(find.text('9/50'), findsOneWidget);
    });

    testWidgets('내용은 50자를 넘겨도 제한 없이 입력된다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);

      await tester.enterText(find.byType(TextField).last, '가' * 120);
      await tester.pump();

      final content = tester
          .widget<TextField>(find.byType(TextField).last)
          .controller!
          .text;
      expect(content.length, 120);
    });
  });

  group('작성·수정 중 닫기', () {
    const writePage = NoticeWritePage(meetingId: 1);

    testWidgets('입력한 내용이 없으면 확인 없이 바로 닫는다', (tester) async {
      await pumpPushedPage(tester, FakeNoticeRepository(), writePage);

      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      expect(find.byType(NoticeWritePage), findsNothing);
      expect(find.text('작성을 취소할까요?'), findsNothing);
    });

    testWidgets('입력한 내용이 있으면 닫기 전에 취소할지 묻는다', (tester) async {
      await pumpPushedPage(tester, FakeNoticeRepository(), writePage);
      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pump();

      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      expect(find.text('작성을 취소할까요?'), findsOneWidget);
      expect(find.byType(NoticeWritePage), findsOneWidget);
    });

    testWidgets('취소할지 물을 때 계속 작성을 누르면 입력한 내용이 그대로 남는다', (tester) async {
      await pumpPushedPage(tester, FakeNoticeRepository(), writePage);
      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pump();
      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('계속 작성'));
      await tester.pumpAndSettle();

      expect(find.byType(NoticeWritePage), findsOneWidget);
      expect(find.text('10월 회비 안내'), findsOneWidget);
    });

    testWidgets('취소할지 물을 때 나가기를 누르면 화면을 닫는다', (tester) async {
      await pumpPushedPage(tester, FakeNoticeRepository(), writePage);
      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pump();
      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('나가기'));
      await tester.pumpAndSettle();

      expect(find.byType(NoticeWritePage), findsNothing);
    });

    testWidgets('기기의 뒤로 가기도 입력한 내용이 있으면 취소할지 묻는다', (tester) async {
      await pumpPushedPage(tester, FakeNoticeRepository(), writePage);
      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pump();

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.text('작성을 취소할까요?'), findsOneWidget);
      expect(find.byType(NoticeWritePage), findsOneWidget);
    });

    testWidgets('등록에 성공하면 취소할지 묻지 않고 화면을 닫는다', (tester) async {
      final repository = FakeNoticeRepository();
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('이전 화면')),
          ),
          GoRoute(path: '/write', builder: (_, _) => writePage),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
          retry: (_, _) => null,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      unawaited(router.push('/write'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.enterText(find.byType(TextField).last, '10일까지 납부');
      await tester.pump();

      await tester.tap(find.text('공지 등록'));
      await tester.pumpAndSettle();

      expect(find.text('작성을 취소할까요?'), findsNothing);
      expect(find.byType(NoticeWritePage), findsNothing);
      expect(find.text('이전 화면'), findsOneWidget);
      expect(repository.notices, hasLength(1));
    });

    testWidgets('수정 화면에서 내용을 바꾸지 않았으면 확인 없이 닫는다', (tester) async {
      await pumpPushedPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );

      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      expect(find.byType(NoticeWritePage), findsNothing);
    });

    testWidgets('수정 화면에서 공백만 바꾸고 닫으면 확인 없이 닫는다', (tester) async {
      await pumpPushedPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.enterText(find.byType(TextField).first, '10월 회비 안내 ');
      await tester.pump();

      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      expect(find.byType(NoticeWritePage), findsNothing);
      expect(find.text('수정을 취소할까요?'), findsNothing);
    });

    testWidgets('수정 화면에서 내용을 바꾸고 닫으면 수정을 취소할지 묻는다', (tester) async {
      await pumpPushedPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.enterText(find.byType(TextField).first, '11월 회비 안내');
      await tester.pump();

      await tester.tap(find.byTooltip('닫기'));
      await tester.pumpAndSettle();

      expect(find.text('수정을 취소할까요?'), findsOneWidget);
    });
  });

  group('공지 수정', () {
    testWidgets('수정 화면에서도 제목을 51자 이상 입력하면 50자까지만 남는다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, '가' * 55);
      await tester.pump();

      final title = tester
          .widget<TextField>(find.byType(TextField).first)
          .controller!
          .text;
      expect(title.length, 50);
    });

    testWidgets('수정 화면을 열면 기존 제목과 내용이 채워져 있다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pumpAndSettle();

      expect(find.text('공지 수정'), findsOneWidget);
      expect(find.text('10월 회비 안내'), findsOneWidget);
      expect(find.text('10일까지 납부'), findsOneWidget);
    });

    testWidgets('내용을 바꾸지 않으면 수정 완료 버튼을 누를 수 없다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pumpAndSettle();

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('앞뒤 공백만 바꾸면 수정 완료 버튼을 누를 수 없다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, '  10월 회비 안내  ');
      await tester.pump();

      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });

    testWidgets('내용을 바꾸면 수정 완료 버튼을 누를 수 있다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, '11월 회비 안내');
      await tester.pump();

      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNotNull,
      );
    });

    testWidgets('내용을 바꿨다가 원래대로 되돌리면 수정 완료 버튼을 누를 수 없다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
        ),
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '11월 회비 안내');
      await tester.pump();

      await tester.enterText(find.byType(TextField).first, '10월 회비 안내');
      await tester.pump();

      expect(
        tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull,
      );
    });

    testWidgets('작성 화면의 공지 등록 버튼은 입력 전에도 누를 수 있다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(),
        const NoticeWritePage(meetingId: 1),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('기존 내용을 불러오는 동안에는 로딩을 보여주고 입력·저장을 막는다', (tester) async {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
      )..detailGate = Completer<void>();
      await pumpPage(
        tester,
        repository,
        const NoticeWritePage(meetingId: 1, noticeId: 1),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.text('수정 완료'), findsNothing);

      repository.detailGate!.complete();
      await tester.pumpAndSettle();

      expect(find.text('10월 회비 안내'), findsOneWidget);
      expect(find.text('수정 완료'), findsOneWidget);
    });

    testWidgets('기존 내용을 불러오지 못하면 입력칸 대신 오류를 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(),
        const NoticeWritePage(meetingId: 1, noticeId: 999),
      );
      await tester.pumpAndSettle();

      expect(find.text('삭제되었거나 존재하지 않는 공지입니다.'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.text('수정 완료'), findsNothing);
    });
  });

  group('공지 상세', () {
    const page = NoticeDetailPage(meetingId: 1, noticeId: 1);

    testWidgets('관리자에게는 삭제 버튼 옆에 수정 버튼을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1)]),
        page,
        myRole: FakeGroupMyRole.admin(),
      );
      await tester.pumpAndSettle();

      final edit = tester.getCenter(find.byTooltip('공지 수정'));
      final delete = tester.getCenter(find.byTooltip('공지 삭제'));
      expect(edit.dx, lessThan(delete.dx));
    });

    testWidgets('일반 구성원에게는 수정·삭제 버튼을 보여주지 않는다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1)]),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.byTooltip('공지 수정'), findsNothing);
      expect(find.byTooltip('공지 삭제'), findsNothing);
    });

    testWidgets('제목 · 작성일 · 내용을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            Notice(
              id: 1,
              title: '회식 정산 안내',
              content: '10월 회비는 10일까지 내 주세요.',
              createdAt: DateTime(DateTime.now().year, 9, 12),
            ),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('회식 정산 안내'), findsOneWidget);
      expect(find.text('${DateTime.now().year}년 9월 12일'), findsOneWidget);
      expect(find.text('10월 회비는 10일까지 내 주세요.'), findsOneWidget);
    });

    testWidgets('수정 후 상세를 다시 불러오는 동안에도 이전 내용을 그대로 보여준다', (tester) async {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
      );
      await pumpPage(tester, repository, page, myRole: FakeGroupMyRole.admin());
      await tester.pumpAndSettle();
      final container = ProviderScope.containerOf(
        tester.element(find.byType(NoticeDetailPage)),
      );

      repository.detailGate = Completer<void>();
      container.invalidate(noticeDetailProvider((meetingId: 1, noticeId: 1)));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('10월 회비 안내'), findsOneWidget);

      repository.detailGate!.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('삭제에 성공했을 때 닫을 화면이 없으면 목록으로 이동한다', (tester) async {
      final repository = FakeNoticeRepository(notices: [buildNotice(1)]);
      final router = GoRouter(
        initialLocation: '/meetings/1/notices/1',
        routes: [
          GoRoute(
            path: '/meetings/:meetingId/notices',
            builder: (_, _) => const Scaffold(body: Text('목록 화면')),
          ),
          GoRoute(
            path: '/meetings/:meetingId/notices/:noticeId',
            builder: (_, _) => page,
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            noticeRepositoryProvider.overrideWithValue(repository),
            FakeGroupMyRole.admin().override,
          ],
          retry: (_, _) => null,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('공지 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();

      expect(find.byType(NoticeDetailPage), findsNothing);
      expect(find.text('목록 화면'), findsOneWidget);
      expect(repository.notices, isEmpty);
    });

    /// 삭제 확인까지 눌러 삭제 요청이 끝나지 않고 진행 중인 상태를 만듭니다.
    Future<FakeNoticeRepository> startDeleting(WidgetTester tester) async {
      final repository = FakeNoticeRepository(notices: [buildNotice(1)])
        ..deleteGate = Completer<void>();
      await pumpPage(tester, repository, page, myRole: FakeGroupMyRole.admin());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('공지 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('삭제'));
      await tester.pump();
      return repository;
    }

    /// 진행 중이던 삭제 요청을 실패로 끝냅니다.
    Future<void> failDeleting(
      WidgetTester tester,
      FakeNoticeRepository repository,
    ) async {
      repository.error = const NoticeException('삭제에 실패했어요.');
      repository.deleteGate!.complete();
      await tester.pumpAndSettle();
    }

    testWidgets('삭제하는 동안에는 수정·삭제 버튼을 누를 수 없다', (tester) async {
      final repository = await startDeleting(tester);

      final edit = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.edit_outlined),
      );
      final delete = tester.widget<IconButton>(
        find.ancestor(
          of: find.byTooltip('공지 삭제'),
          matching: find.byType(IconButton),
        ),
      );
      expect(edit.onPressed, isNull);
      expect(delete.onPressed, isNull);

      await failDeleting(tester, repository);
    });

    testWidgets('삭제하는 동안에는 삭제 버튼 자리에 진행 표시를 보여준다', (tester) async {
      final repository = await startDeleting(tester);

      expect(
        find.descendant(
          of: find.byTooltip('공지 삭제'),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );

      await failDeleting(tester, repository);
    });

    testWidgets('삭제에 실패하면 오류 안내를 보여준다', (tester) async {
      final repository = await startDeleting(tester);

      await failDeleting(tester, repository);

      expect(find.text('삭제에 실패했어요.'), findsOneWidget);
    });

    testWidgets('삭제에 실패하면 수정·삭제 버튼을 다시 누를 수 있다', (tester) async {
      final repository = await startDeleting(tester);

      await failDeleting(tester, repository);

      final edit = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.edit_outlined),
      );
      expect(edit.onPressed, isNotNull);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    /// 이전 화면 위에 상세를 띄우고 삭제를 끝까지 진행합니다.
    Future<FakeNoticeRepository> deleteSuccessfully(WidgetTester tester) async {
      final repository = FakeNoticeRepository(notices: [buildNotice(1)]);
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('이전 화면')),
          ),
          GoRoute(path: '/detail', builder: (_, _) => page),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            noticeRepositoryProvider.overrideWithValue(repository),
            FakeGroupMyRole.admin().override,
          ],
          retry: (_, _) => null,
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      unawaited(router.push('/detail'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('공지 삭제'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();
      return repository;
    }

    testWidgets('삭제에 성공하면 상세 화면을 닫고 이전 화면으로 돌아간다', (tester) async {
      final repository = await deleteSuccessfully(tester);

      expect(find.byType(NoticeDetailPage), findsNothing);
      expect(find.text('이전 화면'), findsOneWidget);
      expect(repository.notices, isEmpty);
    });

    testWidgets('삭제에 성공하면 공지를 삭제했다는 안내를 보여준다', (tester) async {
      await deleteSuccessfully(tester);

      expect(find.text('공지를 삭제했어요.'), findsOneWidget);
    });

    testWidgets('작년 공지도 작성일에 연도를 함께 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            Notice(
              id: 1,
              title: '작년 공지',
              content: '내용',
              createdAt: DateTime(DateTime.now().year - 1, 9, 12),
            ),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('${DateTime.now().year - 1}년 9월 12일'), findsOneWidget);
    });

    // 예외처리 4-6
    testWidgets('삭제되었거나 없는 공지는 안내하고 목록으로 가는 버튼을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(),
        const NoticeDetailPage(meetingId: 1, noticeId: 999),
      );
      await tester.pumpAndSettle();

      expect(find.text('삭제되었거나 존재하지 않는 공지입니다.'), findsOneWidget);
      expect(find.text('목록으로'), findsOneWidget);
    });
  });

  group('내 역할 조회 실패', () {
    const roleError = GroupFailure(GroupFailureReason.unavailable);

    testWidgets('공지가 있어도 다시 시도 버튼을 보여주고, 성공하면 작성 버튼이 나타난다', (tester) async {
      final myRole = FakeGroupMyRole.admin()..error = roleError;
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1)]),
        const NoticeListPage(meetingId: 1),
        myRole: myRole,
      );
      await tester.pumpAndSettle();

      expect(find.byTooltip('권한 확인 다시 시도'), findsOneWidget);
      expect(find.byTooltip('공지 작성'), findsNothing);

      myRole.error = null;
      await tester.tap(find.byTooltip('권한 확인 다시 시도'));
      await tester.pumpAndSettle();

      expect(find.byTooltip('권한 확인 다시 시도'), findsNothing);
      expect(find.byTooltip('공지 작성'), findsOneWidget);
    });

    testWidgets('공지가 없을 때도 관리자 확인을 다시 시도할 수 있다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(),
        const NoticeListPage(meetingId: 1),
        myRole: FakeGroupMyRole.admin()..error = roleError,
      );
      await tester.pumpAndSettle();

      expect(find.text('아직 등록된 공지가 없어요'), findsOneWidget);
      expect(find.text('권한 다시 확인'), findsOneWidget);
      expect(find.text('공지 작성하기'), findsNothing);
    });

    testWidgets('상세 화면에서도 다시 시도 버튼을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1)]),
        const NoticeDetailPage(meetingId: 1, noticeId: 1),
        myRole: FakeGroupMyRole.admin()..error = roleError,
      );
      await tester.pumpAndSettle();

      expect(find.byTooltip('권한 확인 다시 시도'), findsOneWidget);
      expect(find.byTooltip('공지 삭제'), findsNothing);
    });
  });

  group('작성·수정 화면 진입 권한', () {
    Future<void> openByUrl(
      WidgetTester tester,
      FakeNoticeRepository repository,
      String location, {
      FakeGroupMyRole? myRole,
    }) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            noticeRepositoryProvider.overrideWithValue(repository),
            (myRole ?? FakeGroupMyRole()).override,
          ],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: location,
              routes: noticeRoutes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    final notices = [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')];

    testWidgets('일반 구성원이 주소로 작성 화면에 들어오면 목록으로 보낸다', (tester) async {
      await openByUrl(
        tester,
        FakeNoticeRepository(notices: notices),
        '/meetings/1/notices/new',
      );

      expect(find.text('공지 작성'), findsNothing);
      expect(find.text('10월 회비 안내'), findsOneWidget);
    });

    testWidgets('일반 구성원이 주소로 수정 화면에 들어오면 목록으로 보낸다', (tester) async {
      await openByUrl(
        tester,
        FakeNoticeRepository(notices: notices),
        '/meetings/1/notices/1/edit',
      );

      expect(find.text('공지 수정'), findsNothing);
      expect(find.text('10월 회비 안내'), findsOneWidget);
    });

    testWidgets('관리자는 작성·수정 화면에 들어갈 수 있다', (tester) async {
      final repository = FakeNoticeRepository(notices: notices);
      final myRole = FakeGroupMyRole.admin();

      await openByUrl(
        tester,
        repository,
        '/meetings/1/notices/new',
        myRole: myRole,
      );
      expect(find.text('공지 작성'), findsOneWidget);

      await openByUrl(
        tester,
        repository,
        '/meetings/1/notices/1/edit',
        myRole: myRole,
      );
      expect(find.text('공지 수정'), findsOneWidget);
    });

    testWidgets('관리자 여부를 확인하지 못하면 작성 화면에 들여보내지 않는다', (tester) async {
      await openByUrl(
        tester,
        FakeNoticeRepository(notices: notices),
        '/meetings/1/notices/new',
        myRole: FakeGroupMyRole.admin()
          ..error = const GroupFailure(GroupFailureReason.unavailable),
      );

      expect(find.text('공지 작성'), findsNothing);
    });
  });
}
