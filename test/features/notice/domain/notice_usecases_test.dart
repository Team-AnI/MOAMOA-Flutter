import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/domain/usecases/create_notice.dart';
import 'package:moamoa/features/notice/domain/usecases/delete_notice.dart';
import 'package:moamoa/features/notice/domain/usecases/get_notice_detail.dart';
import 'package:moamoa/features/notice/domain/usecases/get_notices.dart';
import 'package:moamoa/features/notice/domain/usecases/update_notice.dart';

import '../fakes/fake_notice_repository.dart';

void main() {
  group(GetNotices, () {
    late GetNotices getNotices;

    setUp(() {
      final repository = FakeNoticeRepository(
        notices: List.generate(25, (index) => buildNotice(index + 1)),
      );
      getNotices = GetNoticesImpl(noticeRepository: repository);
    });

    test('page 를 지정하지 않으면 첫 페이지를 20개 단위로 조회한다', () async {
      final result = await getNotices(const GetNoticesParams(meetingId: 1));

      expect(result.page, 0);
      expect(result.notices, hasLength(20));
      expect(result.hasNext, isTrue);
    });

    test('25개 중 마지막 페이지를 조회하면 남은 5개만 돌려준다', () async {
      final result = await getNotices(
        const GetNoticesParams(meetingId: 1, page: 1),
      );

      expect(result.notices, hasLength(5));
    });

    test('마지막 페이지를 조회하면 다음 페이지가 없다고 알려준다', () async {
      final result = await getNotices(
        const GetNoticesParams(meetingId: 1, page: 1),
      );

      expect(result.hasNext, isFalse);
    });
  });

  group(GetNoticeDetail, () {
    late GetNoticeDetail getNoticeDetail;

    setUp(() {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부')],
      );
      getNoticeDetail = GetNoticeDetailImpl(noticeRepository: repository);
    });

    test('공지 상세를 내용과 함께 조회한다', () async {
      final notice = await getNoticeDetail(
        const GetNoticeDetailParams(meetingId: 1, noticeId: 1),
      );

      expect(notice.title, '10월 회비 안내');
      expect(notice.content, '10일까지 납부');
    });

    test('없는 공지를 조회하면 NoticeException 예외가 발생한다', () async {
      expect(
        () => getNoticeDetail(
          const GetNoticeDetailParams(meetingId: 1, noticeId: 999),
        ),
        throwsA(isA<NoticeException>()),
      );
    });
  });

  group(CreateNotice, () {
    late FakeNoticeRepository repository;
    late CreateNotice createNotice;

    setUp(() {
      repository = FakeNoticeRepository();
      createNotice = CreateNoticeImpl(noticeRepository: repository);
    });

    test('제목과 내용의 앞뒤 공백을 제거해 공지를 작성한다', () async {
      await createNotice(
        const CreateNoticeParams(
          meetingId: 1,
          title: '  10월 회비 안내  ',
          content: ' 10일까지 납부 ',
        ),
      );

      expect(repository.notices.single.title, '10월 회비 안내');
      expect(repository.notices.single.content, '10일까지 납부');
    });

    test('공지를 작성하면 새 공지의 id 를 반환한다', () async {
      final id = await createNotice(
        const CreateNoticeParams(meetingId: 1, title: '제목', content: '내용'),
      );

      expect(repository.notices.single.id, id);
    });

    test('제목이 비어 있으면 NoticeException 예외가 발생한다', () async {
      await expectLater(
        createNotice(
          const CreateNoticeParams(meetingId: 1, title: '   ', content: '내용'),
        ),
        throwsA(isA<NoticeException>()),
      );
    });

    test('제목이 비어 있으면 공지를 작성하지 않는다', () async {
      try {
        await createNotice(
          const CreateNoticeParams(meetingId: 1, title: '   ', content: '내용'),
        );
      } on NoticeException catch (_) {
        // 예외 발생은 위 테스트에서 확인합니다.
      }

      expect(repository.notices, isEmpty);
    });

    test('내용이 비어 있으면 NoticeException 예외가 발생한다', () async {
      await expectLater(
        createNotice(
          const CreateNoticeParams(meetingId: 1, title: '제목', content: ''),
        ),
        throwsA(isA<NoticeException>()),
      );
    });

    test('내용이 비어 있으면 공지를 작성하지 않는다', () async {
      try {
        await createNotice(
          const CreateNoticeParams(meetingId: 1, title: '제목', content: ''),
        );
      } on NoticeException catch (_) {
        // 예외 발생은 위 테스트에서 확인합니다.
      }

      expect(repository.notices, isEmpty);
    });
  });

  group(UpdateNotice, () {
    late FakeNoticeRepository repository;
    late UpdateNotice updateNotice;

    setUp(() {
      repository = FakeNoticeRepository(
        notices: [buildNotice(1, title: '기존 제목', content: '기존 내용')],
      );
      updateNotice = UpdateNoticeImpl(noticeRepository: repository);
    });

    test('보낸 필드만 수정한다', () async {
      await updateNotice(
        const UpdateNoticeParams(meetingId: 1, noticeId: 1, content: ' 새 내용 '),
      );

      expect(repository.notices.single.title, '기존 제목');
      expect(repository.notices.single.content, '새 내용');
    });

    test('제목을 공백으로 수정하면 NoticeException 예외가 발생한다', () async {
      await expectLater(
        updateNotice(
          const UpdateNoticeParams(meetingId: 1, noticeId: 1, title: '  '),
        ),
        throwsA(isA<NoticeException>()),
      );
    });

    test('제목을 공백으로 수정하면 기존 제목을 유지한다', () async {
      try {
        await updateNotice(
          const UpdateNoticeParams(meetingId: 1, noticeId: 1, title: '  '),
        );
      } on NoticeException catch (_) {
        // 예외 발생은 위 테스트에서 확인합니다.
      }

      expect(repository.notices.single.title, '기존 제목');
    });

    test('내용을 공백으로 수정하면 NoticeException 예외가 발생한다', () async {
      await expectLater(
        updateNotice(
          const UpdateNoticeParams(meetingId: 1, noticeId: 1, content: ''),
        ),
        throwsA(isA<NoticeException>()),
      );
    });

    test('내용을 공백으로 수정하면 기존 내용을 유지한다', () async {
      try {
        await updateNotice(
          const UpdateNoticeParams(meetingId: 1, noticeId: 1, content: ''),
        );
      } on NoticeException catch (_) {
        // 예외 발생은 위 테스트에서 확인합니다.
      }

      expect(repository.notices.single.content, '기존 내용');
    });
  });

  group(DeleteNotice, () {
    test('공지를 삭제한다', () async {
      final repository = FakeNoticeRepository(
        notices: [buildNotice(1), buildNotice(2)],
      );
      final deleteNotice = DeleteNoticeImpl(noticeRepository: repository);

      await deleteNotice(const DeleteNoticeParams(meetingId: 1, noticeId: 1));

      expect(repository.notices.map((notice) => notice.id), [2]);
    });
  });
}
