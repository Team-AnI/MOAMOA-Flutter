import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';
import 'package:moamoa/features/notice/presentation/viewmodels/notice_detail_view_model.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const args = (meetingId: 1, noticeId: 1);

  group(NoticeDetailViewModel, () {
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
      // 상세 화면이 열려 있는 상태
      container.listen(noticeDetailProvider(args), (_, _) {});
    });

    test('공지 상세를 불러온다', () async {
      final notice = await container.read(noticeDetailProvider(args).future);

      expect(notice.title, '10월 회비 안내');
      expect(notice.content, '10일까지 납부');
    });

    test('상세를 불러오면 해당 공지의 읽음 처리를 한 번 요청한다', () async {
      await container.read(noticeDetailProvider(args).future);
      await Future<void>.delayed(Duration.zero);

      expect(repository.readNoticeIds, [1]);
    });

    test('상세를 불러오지 못하면 읽음 처리를 요청하지 않는다', () async {
      // setUp 의 화면은 이미 불러오기 시작했으므로, 처음부터 실패하는 화면을 따로 엽니다.
      final failing = FakeNoticeRepository()
        ..error = const NoticeException('공지를 찾을 수 없습니다.');
      final failingContainer = ProviderContainer.test(
        overrides: [noticeRepositoryProvider.overrideWithValue(failing)],
        retry: (_, _) => null,
      );
      failingContainer.listen(noticeDetailProvider(args), (_, _) {});

      await expectLater(
        failingContainer.read(noticeDetailProvider(args).future),
        throwsA(isA<NoticeException>()),
      );
      await Future<void>.delayed(Duration.zero);

      expect(failing.readNoticeIds, isEmpty);
    });

    test('읽음 처리가 실패해도 불러온 상세를 그대로 보여준다', () async {
      repository.readError = const NoticeException('모임 구성원이 아닙니다.');

      final notice = await container.read(noticeDetailProvider(args).future);
      await Future<void>.delayed(Duration.zero);

      expect(notice.title, '10월 회비 안내');
      expect(container.read(noticeDetailProvider(args)).hasError, isFalse);
    });

    test('읽음 처리가 실패해도 처리되지 않은 오류를 남기지 않는다', () async {
      final uncaught = <Object>[];
      await runZonedGuarded(() async {
        final failing = FakeNoticeRepository(notices: [buildNotice(1)])
          ..readError = const NoticeException('모임 구성원이 아닙니다.');
        final zoned = ProviderContainer.test(
          overrides: [noticeRepositoryProvider.overrideWithValue(failing)],
          retry: (_, _) => null,
        );
        zoned.listen(noticeDetailProvider(args), (_, _) {});
        await zoned.read(noticeDetailProvider(args).future);
        await Future<void>.delayed(Duration.zero);
      }, (error, _) => uncaught.add(error));

      expect(uncaught, isEmpty);
    });

    test('같은 화면에서 상세를 다시 불러와도 읽음 처리는 다시 요청하지 않는다', () async {
      await container.read(noticeDetailProvider(args).future);
      container.invalidate(noticeDetailProvider(args));
      await container.read(noticeDetailProvider(args).future);
      await Future<void>.delayed(Duration.zero);

      expect(repository.readNoticeIds, [1]);
    });
  });
}
