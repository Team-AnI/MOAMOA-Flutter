import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/member_role.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_detail_page.dart';
import 'package:moamoa/features/notice/presentation/pages/notice_list_page.dart';
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
}
