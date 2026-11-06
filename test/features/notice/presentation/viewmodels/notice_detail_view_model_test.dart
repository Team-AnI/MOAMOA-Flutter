import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const args = (meetingId: 1, noticeId: 1);

  group('NoticeDetailViewModel', () {
    late FakeNoticeRepository repository;
    late ProviderContainer container;
    late ProviderSubscription<Object?> screen;

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
      // 상세 화면이 열려 있는 상태
      screen = container.listen(noticeDetailProvider(args), (_, _) {});
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

    test('삭제 요청 중에 화면을 닫아도 삭제가 끝나면 목록을 다시 불러온다', () async {
      final gate = Completer<void>();
      repository.deleteGate = gate;
      container.listen(noticeListProvider(args.meetingId), (_, _) {});
      await container.read(noticeListProvider(args.meetingId).future);
      await container.read(noticeDetailProvider(args).future);
      final delete = container
          .read(noticeDetailProvider(args).notifier)
          .delete();

      // 응답이 오기 전에 화면을 닫는다. (구독이 끊겨 provider 가 dispose 대상이 됨)
      screen.close();
      await Future<void>.delayed(Duration.zero);
      gate.complete();
      await delete;

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
  });
}
