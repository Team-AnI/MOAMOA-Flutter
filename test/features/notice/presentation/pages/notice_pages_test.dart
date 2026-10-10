import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/notice/domain/entities/member_role.dart';
import 'package:moamoa/features/notice/domain/entities/notice.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_detail_page.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_list_page.dart';
import 'package:moamoa/features/notice/presentation/notice_routes.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_write_page.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester,
    FakeNoticeRepository repository,
    Widget page,
  ) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
        child: MaterialApp(home: page),
      ),
    );
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

    testWidgets('작성자와 작성 시간을 함께 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1, authorName: '김도윤')]),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('김도윤 · '), findsOneWidget);
    });

    testWidgets('고정된 공지를 따로 보여주고 탭에 개수를 표시한다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            buildNotice(1, title: '회식 정산 안내', isPinned: true),
            buildNotice(2, title: '장소 변경'),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('전체 2'), findsOneWidget);
      expect(find.text('고정 1'), findsOneWidget);
      expect(find.text('고정된 공지'), findsOneWidget);

      await tester.tap(find.text('고정 1'));
      await tester.pumpAndSettle();

      expect(find.text('회식 정산 안내'), findsOneWidget);
      expect(find.text('장소 변경'), findsNothing);
    });

    testWidgets('중요 공지에는 중요 뱃지를 붙이고 중요 탭에서 모아 본다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            buildNotice(1, title: '회비 미납 안내', isImportant: true),
            buildNotice(2, title: '장소 변경'),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('전체 2'), findsOneWidget);
      expect(find.text('중요 1'), findsOneWidget);
      expect(find.text('중요'), findsOneWidget);

      await tester.tap(find.text('중요 1'));
      await tester.pumpAndSettle();

      expect(find.text('회비 미납 안내'), findsOneWidget);
      expect(find.text('장소 변경'), findsNothing);
    });

    testWidgets('중요 공지가 없으면 중요 탭에 안내를 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(notices: [buildNotice(1)]),
        page,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('중요 0'));
      await tester.pumpAndSettle();

      expect(find.text('중요 공지가 없어요'), findsOneWidget);
    });

    testWidgets('수정된 공지에는 날짜 옆에 수정됨을 붙인다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            buildNotice(1, title: '수정한 공지', isEdited: true),
            buildNotice(2, title: '그대로인 공지'),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('수정됨'), findsOneWidget);
    });

    // 예외처리 4-2
    testWidgets('공지가 없으면 관리자에게는 작성 버튼을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(myRole: MemberRole.admin),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('아직 등록된 공지가 없어요'), findsOneWidget);
      expect(find.text('공지 작성하기'), findsOneWidget);
      expect(find.byTooltip('공지 작성'), findsOneWidget);
    });

    testWidgets('공지가 없으면 일반 구성원에게는 작성 버튼을 보여주지 않는다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);
      await tester.pumpAndSettle();

      expect(find.text('아직 등록된 공지가 없어요'), findsOneWidget);
      expect(find.text('공지 작성하기'), findsNothing);
      expect(find.byTooltip('공지 작성'), findsNothing);
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

    testWidgets('작성 화면에는 맨 위 고정 토글이 있다', (tester) async {
      await pumpPage(tester, FakeNoticeRepository(), page);

      expect(find.text('목록 맨 위에 고정'), findsOneWidget);
    });
  });

  group('공지 수정', () {
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
      expect(find.text('목록 맨 위에 고정'), findsOneWidget);
      // 테스트 화면은 작아서 안내 문구가 화면 밖에 있습니다.
      await tester.scrollUntilVisible(
        find.text('저장하면 공지에 수정됨 표시가 붙어요.'),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('저장하면 공지에 수정됨 표시가 붙어요.'), findsOneWidget);
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
        FakeNoticeRepository(
          notices: [buildNotice(1)],
          myRole: MemberRole.admin,
        ),
        page,
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

    testWidgets('고정 뱃지 · 작성자 · 수정됨을 보여준다', (tester) async {
      await pumpPage(
        tester,
        FakeNoticeRepository(
          notices: [
            Notice(
              id: 1,
              title: '회식 정산 안내',
              content: '10월 회비는 10일까지 내 주세요.',
              createdAt: DateTime(2026, 9, 12),
              authorName: '김도윤',
              isPinned: true,
              isEdited: true,
            ),
          ],
        ),
        page,
      );
      await tester.pumpAndSettle();

      expect(find.text('고정된 공지'), findsOneWidget);
      expect(find.text('김도윤 · 9월 12일'), findsOneWidget);
      expect(find.text('수정됨'), findsOneWidget);
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
    const roleError = NoticeException('권한을 확인하지 못했어요');

    testWidgets('공지가 있어도 다시 시도 버튼을 보여주고, 성공하면 작성 버튼이 나타난다', (tester) async {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1)],
        myRole: MemberRole.admin,
      )..myRoleError = roleError;
      await pumpPage(tester, repository, const NoticeListPage(meetingId: 1));
      await tester.pumpAndSettle();

      expect(find.byTooltip('권한 확인 다시 시도'), findsOneWidget);
      expect(find.byTooltip('공지 작성'), findsNothing);

      repository.myRoleError = null;
      await tester.tap(find.byTooltip('권한 확인 다시 시도'));
      await tester.pumpAndSettle();

      expect(find.byTooltip('권한 확인 다시 시도'), findsNothing);
      expect(find.byTooltip('공지 작성'), findsOneWidget);
    });

    testWidgets('공지가 없을 때도 관리자 확인을 다시 시도할 수 있다', (tester) async {
      final repository = FakeNoticeRepository(myRole: MemberRole.admin)
        ..myRoleError = roleError;
      await pumpPage(tester, repository, const NoticeListPage(meetingId: 1));
      await tester.pumpAndSettle();

      expect(find.text('아직 등록된 공지가 없어요'), findsOneWidget);
      expect(find.text('권한 다시 확인'), findsOneWidget);
      expect(find.text('공지 작성하기'), findsNothing);
    });

    testWidgets('상세 화면에서도 다시 시도 버튼을 보여준다', (tester) async {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1)],
        myRole: MemberRole.admin,
      )..myRoleError = roleError;
      await pumpPage(
        tester,
        repository,
        const NoticeDetailPage(meetingId: 1, noticeId: 1),
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
      String location,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
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
      final repository = FakeNoticeRepository(
        notices: notices,
        myRole: MemberRole.admin,
      );

      await openByUrl(tester, repository, '/meetings/1/notices/new');
      expect(find.text('공지 작성'), findsOneWidget);

      await openByUrl(tester, repository, '/meetings/1/notices/1/edit');
      expect(find.text('공지 수정'), findsOneWidget);
    });

    testWidgets('관리자 여부를 확인하지 못하면 작성 화면에 들여보내지 않는다', (tester) async {
      await openByUrl(
        tester,
        FakeNoticeRepository(notices: notices, myRole: MemberRole.admin)
          ..myRoleError = const NoticeException('권한을 확인하지 못했어요'),
        '/meetings/1/notices/new',
      );

      expect(find.text('공지 작성'), findsNothing);
    });
  });
}
