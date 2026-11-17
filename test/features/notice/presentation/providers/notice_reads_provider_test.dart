import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice.dart';
import 'package:moamoa/features/notice/domain/entities/notice_detail_request.dart';
import 'package:moamoa/features/notice/domain/entities/notice_read_member.dart';
import 'package:moamoa/features/notice/domain/entities/notice_reads.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const request = NoticeDetailRequest(meetingId: 1, noticeId: 3);
  const reads = NoticeReads(
    readCount: 1,
    totalCount: 2,
    readMembers: [NoticeReadMember(memberId: 3, userName: '김모아')],
    unreadMembers: [NoticeReadMember(memberId: 5, userName: '이모아')],
  );

  group('noticeReadsProvider', () {
    late FakeNoticeRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeNoticeRepository(notices: [buildNotice(3)])
        ..readsByNoticeId[3] = reads;
      container = ProviderContainer.test(
        overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
    });

    test('해당 공지의 읽음 현황을 불러온다', () async {
      final result = await container.read(noticeReadsProvider(request).future);

      expect(result, reads);
    });

    test('내 읽음 처리를 요청한 뒤에 읽음 현황을 불러온다', () async {
      await container.read(noticeReadsProvider(request).future);

      expect(repository.readNoticeIdsAtReadsRequest, [
        [3],
      ]);
    });

    test('내 읽음 처리가 실패해도 읽음 현황을 불러온다', () async {
      repository.readError = Exception('시간 초과');

      final result = await container.read(noticeReadsProvider(request).future);

      expect(result, reads);
    });

    test('읽음 현황을 불러오지 못하면 오류 상태가 된다', () async {
      repository.readsError = Exception('시간 초과');
      container.listen(noticeReadsProvider(request), (_, _) {});

      await expectLater(
        container.read(noticeReadsProvider(request).future),
        throwsA(isA<Exception>()),
      );

      expect(container.read(noticeReadsProvider(request)).hasError, isTrue);
    });
  });

  group('noticeReadsProvider 의 목록 갱신', () {
    late FakeNoticeRepository repository;
    late ProviderContainer container;

    List<Notice> listedNotices() =>
        container.read(noticeListProvider(1)).requireValue.notices;

    setUp(() {
      repository = FakeNoticeRepository(
        notices: [
          for (var id = 1; id <= 25; id++)
            buildNotice(id, readCount: 0, totalCount: 2),
        ],
      )..readsByNoticeId[22] = reads;
      container = ProviderContainer.test(
        overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
    });

    /// 공지 목록 화면이 열려 있는 것처럼 구독하고 첫 페이지를 기다립니다.
    Future<void> openList() async {
      container.listen(noticeListProvider(1), (_, _) {});
      await container.read(noticeListProvider(1).future);
    }

    test('읽음 현황을 받으면 목록에서 그 공지의 읽은 수만 바꾼다', () async {
      await openList();
      const firstPageRequest = NoticeDetailRequest(meetingId: 1, noticeId: 3);
      repository.readsByNoticeId[3] = reads;

      await container.read(noticeReadsProvider(firstPageRequest).future);

      final notices = listedNotices();
      expect(notices.firstWhere((notice) => notice.id == 3).readCount, 1);
      expect(notices.where((notice) => notice.readCount == 0), hasLength(19));
    });

    test('더 불러온 페이지의 공지를 읽어도 불러온 페이지를 유지한다', () async {
      await openList();
      await container.read(noticeListProvider(1).notifier).loadMore();
      const secondPageRequest = NoticeDetailRequest(meetingId: 1, noticeId: 22);

      await container.read(noticeReadsProvider(secondPageRequest).future);

      expect(repository.getNoticesCallCount, 2);
      expect(listedNotices(), hasLength(25));
      expect(
        listedNotices().firstWhere((notice) => notice.id == 22).readCount,
        1,
      );
    });

    test('읽음 현황 응답 전에 상세 화면을 닫으면 목록을 바꾸지 않는다', () async {
      await openList();
      final gate = repository.readsGate = Completer<void>();
      const request = NoticeDetailRequest(meetingId: 1, noticeId: 22);
      final subscription = container.listen(
        noticeReadsProvider(request),
        (_, _) {},
      );
      await Future<void>.delayed(Duration.zero);

      subscription.close();
      await Future<void>.delayed(Duration.zero);
      gate.complete();
      await Future<void>.delayed(Duration.zero);

      expect(repository.readNoticeIdsAtReadsRequest, hasLength(1));
      expect(listedNotices().every((notice) => notice.readCount == 0), isTrue);
    });

    test('공지 목록이 열려 있지 않으면 읽음 현황을 받아도 목록을 불러오지 않는다', () async {
      const request = NoticeDetailRequest(meetingId: 1, noticeId: 22);

      await container.read(noticeReadsProvider(request).future);

      expect(repository.getNoticesCallCount, 0);
    });
  });
}
