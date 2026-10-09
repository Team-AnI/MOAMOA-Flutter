import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/member_role.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/domain/usecases/create_notice.dart';
import 'package:moamoa/features/notice/domain/usecases/delete_notice.dart';
import 'package:moamoa/features/notice/domain/usecases/get_my_role.dart';
import 'package:moamoa/features/notice/domain/usecases/get_notice_detail.dart';
import 'package:moamoa/features/notice/domain/usecases/get_notices.dart';
import 'package:moamoa/features/notice/domain/usecases/set_notice_pinned.dart';
import 'package:moamoa/features/notice/domain/usecases/update_notice.dart';

import '../fakes/fake_notice_repository.dart';

void main() {
  group('GetNotices', () {
    late GetNotices getNotices;

    setUp(() {
      final repository = FakeNoticeRepository(
        notices: List.generate(25, (index) => buildNotice(index + 1)),
      );
      getNotices = GetNoticesImpl(repository: repository);
    });

    test('page 를 지정하지 않으면 첫 페이지를 20개 단위로 조회한다', () async {
      final result = await getNotices(const GetNoticesParams(meetingId: 1));

      expect(result.page, 0);
      expect(result.notices, hasLength(20));
      expect(result.hasNext, isTrue);
    });

    test('마지막 페이지는 남은 공지만 조회하고 hasNext 가 false 다', () async {
      final result = await getNotices(
        const GetNoticesParams(meetingId: 1, page: 1),
      );

      expect(result.notices, hasLength(5));
      expect(result.hasNext, isFalse);
    });
  });

  group('GetNoticeDetail', () {
    late GetNoticeDetail getNoticeDetail;

    setUp(() {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
      );
      getNoticeDetail = GetNoticeDetailImpl(repository: repository);
    });

    test('공지 상세를 내용과 함께 조회한다', () async {
      final notice = await getNoticeDetail(
        const GetNoticeDetailParams(meetingId: 1, noticeId: 1),
      );

      expect(notice.title, '10월 회비 안내');
      expect(notice.content, '10일까지 납부');
    });

    test('없는 공지를 조회하면 NoticeException 을 던진다', () async {
      expect(
        () => getNoticeDetail(
          const GetNoticeDetailParams(meetingId: 1, noticeId: 999),
        ),
        throwsA(isA<NoticeException>()),
      );
    });
  });

  group('CreateNotice', () {
    late FakeNoticeRepository repository;
    late CreateNotice createNotice;

    setUp(() {
      repository = FakeNoticeRepository();
      createNotice = CreateNoticeImpl(repository: repository);
    });

    test('제목과 내용의 앞뒤 공백을 제거해 공지를 작성하고 id 를 반환한다', () async {
      final id = await createNotice(
        const CreateNoticeParams(
          meetingId: 1,
          title: '  10월 회비 안내  ',
          content: ' 10일까지 납부 ',
        ),
      );

      expect(repository.notices.single.id, id);
      expect(repository.notices.single.title, '10월 회비 안내');
      expect(repository.notices.single.content, '10일까지 납부');
    });

    test('제목이 비어 있으면 작성하지 않고 NoticeException 을 던진다', () async {
      await expectLater(
        createNotice(
          const CreateNoticeParams(meetingId: 1, title: '   ', content: '내용'),
        ),
        throwsA(isA<NoticeException>()),
      );
      expect(repository.notices, isEmpty);
    });

    test('내용이 비어 있으면 작성하지 않고 NoticeException 을 던진다', () async {
      await expectLater(
        createNotice(
          const CreateNoticeParams(meetingId: 1, title: '제목', content: ''),
        ),
        throwsA(isA<NoticeException>()),
      );
      expect(repository.notices, isEmpty);
    });
  });

  group('UpdateNotice', () {
    late FakeNoticeRepository repository;
    late UpdateNotice updateNotice;

    setUp(() {
      repository = FakeNoticeRepository(
        notices: [buildNotice(1, title: '기존 제목', content: '기존 내용')],
      );
      updateNotice = UpdateNoticeImpl(repository: repository);
    });

    test('보낸 필드만 수정한다', () async {
      await updateNotice(
        const UpdateNoticeParams(meetingId: 1, noticeId: 1, content: ' 새 내용 '),
      );

      expect(repository.notices.single.title, '기존 제목');
      expect(repository.notices.single.content, '새 내용');
    });

    test('제목을 공백으로 수정하면 NoticeException 을 던진다', () async {
      await expectLater(
        updateNotice(
          const UpdateNoticeParams(meetingId: 1, noticeId: 1, title: '  '),
        ),
        throwsA(isA<NoticeException>()),
      );
      expect(repository.notices.single.title, '기존 제목');
    });

    test('내용을 공백으로 수정하면 NoticeException 을 던진다', () async {
      await expectLater(
        updateNotice(
          const UpdateNoticeParams(meetingId: 1, noticeId: 1, content: ''),
        ),
        throwsA(isA<NoticeException>()),
      );
      expect(repository.notices.single.content, '기존 내용');
    });
  });

  group('DeleteNotice', () {
    test('공지를 삭제한다', () async {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1), buildNotice(2)],
      );
      final deleteNotice = DeleteNoticeImpl(repository: repository);

      await deleteNotice(const DeleteNoticeParams(meetingId: 1, noticeId: 1));

      expect(repository.notices.map((notice) => notice.id), [2]);
    });
  });

  group('GetMyRole', () {
    test('모임에서 내 역할을 조회한다', () async {
      final repository = FakeNoticeRepository(myRole: MemberRole.admin);
      final getMyRole = GetMyRoleImpl(repository: repository);

      final role = await getMyRole(const GetMyRoleParams(meetingId: 1));

      expect(role, MemberRole.admin);
      expect(role.isAdmin, isTrue);
    });
  });

  group('SetNoticePinned', () {
    late FakeNoticeRepository repository;
    late SetNoticePinned setNoticePinned;

    setUp(() {
      repository = FakeNoticeRepository(notices: [buildNotice(1)]);
      setNoticePinned = SetNoticePinnedImpl(repository: repository);
    });

    test('공지를 고정한다', () async {
      await setNoticePinned(
        const SetNoticePinnedParams(meetingId: 1, noticeId: 1, pinned: true),
      );

      expect(repository.notices.single.isPinned, isTrue);
    });

    test('공지 고정을 해제한다', () async {
      repository.notices[0] = buildNotice(1, isPinned: true);

      await setNoticePinned(
        const SetNoticePinnedParams(meetingId: 1, noticeId: 1, pinned: false),
      );

      expect(repository.notices.single.isPinned, isFalse);
    });
  });
}
