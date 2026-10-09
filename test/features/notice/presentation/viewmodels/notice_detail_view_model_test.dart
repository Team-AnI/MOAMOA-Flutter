import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const args = (meetingId: 1, noticeId: 1);
  late FakeNoticeRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeNoticeRepository(
      notices: [
        buildNotice(1, title: '10월 회비 안내', content: '10일까지 납부'),
        buildNotice(2),
      ],
    );
    container = ProviderContainer.test(
      overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
      retry: (_, _) => null,
    );
    container.listen(noticeDetailProvider(args), (_, _) {});
  });

  test('공지 상세를 불러온다', () async {
    final notice = await container.read(noticeDetailProvider(args).future);

    expect(notice.title, '10월 회비 안내');
    expect(notice.content, '10일까지 납부');
  });

  test('delete 를 하면 공지를 삭제하고 목록을 다시 불러온다', () async {
    container.listen(noticeListProvider(args.meetingId), (_, _) {});
    await container.read(noticeListProvider(args.meetingId).future);
    await container.read(noticeDetailProvider(args).future);

    await container.read(noticeDetailProvider(args).notifier).delete();

    final list = await container.read(
      noticeListProvider(args.meetingId).future,
    );
    expect(list.notices.map((notice) => notice.id), [2]);
  });

  test('삭제에 실패하면 NoticeException 을 던진다', () async {
    await container.read(noticeDetailProvider(args).future);
    repository.error = const NoticeException('ADMIN 이 아닙니다.');

    await expectLater(
      container.read(noticeDetailProvider(args).notifier).delete(),
      throwsA(isA<NoticeException>()),
    );
  });

  test('togglePin 을 하면 고정 상태를 바꾸고 상세를 다시 불러온다', () async {
    await container.read(noticeDetailProvider(args).future);

    await container.read(noticeDetailProvider(args).notifier).togglePin();

    final notice = await container.read(noticeDetailProvider(args).future);
    expect(notice.isPinned, isTrue);
  });

  test('고정 변경에 실패하면 NoticeException 을 던진다', () async {
    await container.read(noticeDetailProvider(args).future);
    repository.error = const NoticeException('ADMIN 이 아닙니다.');

    await expectLater(
      container.read(noticeDetailProvider(args).notifier).togglePin(),
      throwsA(isA<NoticeException>()),
    );
  });
}
