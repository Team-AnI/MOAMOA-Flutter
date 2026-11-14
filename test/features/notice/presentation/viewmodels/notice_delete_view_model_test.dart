import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice_detail_request.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';
import 'package:moamoa/features/notice/presentation/viewmodels/notice_delete_state.dart';
import 'package:moamoa/features/notice/presentation/viewmodels/notice_delete_status.dart';
import 'package:moamoa/features/notice/presentation/viewmodels/notice_delete_view_model.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const request = NoticeDetailRequest(meetingId: 1, noticeId: 1);

  group(NoticeDeleteViewModel, () {
    late FakeNoticeRepository repository;
    late ProviderContainer container;
    late ProviderSubscription<NoticeDeleteState> screen;

    setUp(() {
      repository = FakeNoticeRepository(
        notices: [buildNotice(1), buildNotice(2)],
      );
      container = ProviderContainer.test(
        overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      // 상세 화면이 열려 있는 상태
      screen = container.listen(noticeDeleteProvider(request), (_, _) {});
    });

    NoticeDeleteStatus status() =>
        container.read(noticeDeleteProvider(request)).status;

    test('처음에는 삭제를 요청하지 않은 상태로 시작한다', () {
      expect(status(), NoticeDeleteStatus.initial);
    });

    test('삭제를 요청하면 응답 전까지 삭제 중 상태가 된다', () async {
      final gate = Completer<void>();
      repository.deleteGate = gate;

      final delete = container
          .read(noticeDeleteProvider(request).notifier)
          .delete();

      expect(status(), NoticeDeleteStatus.deleting);
      gate.complete();
      await delete;
    });

    test('삭제에 성공하면 성공 상태가 된다', () async {
      await container.read(noticeDeleteProvider(request).notifier).delete();

      expect(status(), NoticeDeleteStatus.success);
    });

    test('삭제에 성공하면 다시 불러온 목록에서 삭제한 공지가 빠진다', () async {
      container.listen(noticeListProvider(request.meetingId), (_, _) {});
      await container.read(noticeListProvider(request.meetingId).future);

      await container.read(noticeDeleteProvider(request).notifier).delete();

      final list = await container.read(
        noticeListProvider(request.meetingId).future,
      );
      expect(list.notices.map((notice) => notice.id), [2]);
    });

    test('삭제 요청 중에 화면을 닫아도 삭제가 끝나면 목록을 다시 불러온다', () async {
      final gate = Completer<void>();
      repository.deleteGate = gate;
      container.listen(noticeListProvider(request.meetingId), (_, _) {});
      await container.read(noticeListProvider(request.meetingId).future);
      final delete = container
          .read(noticeDeleteProvider(request).notifier)
          .delete();

      // 응답이 오기 전에 화면을 닫는다. (구독이 끊겨 provider 가 dispose 대상이 됨)
      screen.close();
      await Future<void>.delayed(Duration.zero);
      gate.complete();
      await delete;

      final list = await container.read(
        noticeListProvider(request.meetingId).future,
      );
      expect(list.notices.map((notice) => notice.id), [2]);
    });

    test('삭제에 실패하면 실패 상태가 되고 원인을 담는다', () async {
      repository.error = const NoticeException('ADMIN 이 아닙니다.');

      await container.read(noticeDeleteProvider(request).notifier).delete();

      final state = container.read(noticeDeleteProvider(request));
      expect(state.status, NoticeDeleteStatus.failure);
      expect(state.error, isA<NoticeException>());
    });

    test('삭제 중에 다시 요청하면 무시하고 첫 요청의 결과를 유지한다', () async {
      final gate = Completer<void>();
      repository.deleteGate = gate;
      final notifier = container.read(noticeDeleteProvider(request).notifier);

      final first = notifier.delete();
      final second = notifier.delete();
      gate.complete();
      await Future.wait([first, second]);

      // 두 번째 요청이 나갔다면 이미 지워진 공지라 NOT_FOUND 로 실패 상태가 됩니다.
      expect(status(), NoticeDeleteStatus.success);
      expect(repository.notices.map((notice) => notice.id), [2]);
    });
  });
}
