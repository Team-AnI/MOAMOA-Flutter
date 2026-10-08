import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const meetingId = 1;
  late FakeNoticeRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeNoticeRepository(
      notices: [buildNotice(1, title: '기존 제목', content: '기존 내용')],
    );
    container = ProviderContainer.test(
      overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
      retry: (_, _) => null,
    );
    container.listen(noticeWriteProvider(meetingId), (_, _) {});
  });

  test('공지를 작성하면 true 를 반환하고 목록에 새 공지가 보인다', () async {
    container.listen(noticeListProvider(meetingId), (_, _) {});
    await container.read(noticeListProvider(meetingId).future);

    final success = await container
        .read(noticeWriteProvider(meetingId).notifier)
        .submit(title: '10월 회비 안내', content: '10일까지 납부');

    expect(success, isTrue);
    final list = await container.read(noticeListProvider(meetingId).future);
    expect(list.notices.first.title, '10월 회비 안내');
  });

  test('제목이 비어 있으면 등록하지 않고 에러 상태가 된다', () async {
    final success = await container
        .read(noticeWriteProvider(meetingId).notifier)
        .submit(title: ' ', content: '내용');

    expect(success, isFalse);
    expect(repository.notices, hasLength(1));
    expect(
      container.read(noticeWriteProvider(meetingId)).error,
      isA<NoticeException>(),
    );
  });

  test('noticeId 를 넘기면 공지를 수정한다', () async {
    final success = await container
        .read(noticeWriteProvider(meetingId).notifier)
        .submit(noticeId: 1, title: '새 제목', content: '새 내용');

    expect(success, isTrue);
    expect(repository.notices.single.title, '새 제목');
    expect(repository.notices.single.content, '새 내용');
  });

  test('서버에서 실패하면 false 를 반환하고 에러 상태가 된다', () async {
    repository.error = const NoticeException('ADMIN 이 아닙니다.');

    final success = await container
        .read(noticeWriteProvider(meetingId).notifier)
        .submit(title: '제목', content: '내용');

    expect(success, isFalse);
    expect(
      container.read(noticeWriteProvider(meetingId)).error,
      isA<NoticeException>(),
    );
  });
}
