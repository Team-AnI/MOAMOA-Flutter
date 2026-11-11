import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const args = (meetingId: 1, noticeId: 3);

  group('noticeReadProvider', () {
    late FakeNoticeRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeNoticeRepository(notices: [buildNotice(3)]);
      container = ProviderContainer.test(
        overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
    });

    test('해당 공지의 읽음 처리를 요청한다', () async {
      await container.read(noticeReadProvider(args).future);

      expect(repository.readNoticeIds, [3]);
    });

    test('구독하는 동안에는 읽음 처리를 다시 요청하지 않는다', () async {
      container.listen(noticeReadProvider(args), (_, _) {});
      await container.read(noticeReadProvider(args).future);
      await container.read(noticeReadProvider(args).future);

      expect(repository.readNoticeIds, [3]);
    });

    test('읽음 처리가 공지 예외로 실패해도 오류 없이 끝난다', () async {
      repository.readError = const NoticeException('모임 구성원이 아닙니다.');

      await container.read(noticeReadProvider(args).future);

      expect(container.read(noticeReadProvider(args)).hasError, isFalse);
    });

    test('읽음 처리가 공지 예외가 아닌 오류로 실패해도 오류 없이 끝난다', () async {
      repository.readError = Exception('시간 초과');

      await container.read(noticeReadProvider(args).future);

      expect(container.read(noticeReadProvider(args)).hasError, isFalse);
    });
  });
}
