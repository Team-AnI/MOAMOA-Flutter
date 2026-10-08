import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/member_role.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';
import 'package:moamoa/features/notice/presentation/viewmodels/notice_list_state.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const meetingId = 1;
  late FakeNoticeRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeNoticeRepository(
      notices: List.generate(25, (index) => buildNotice(index + 1)),
    );
    container = ProviderContainer.test(
      overrides: [noticeRepositoryProvider.overrideWithValue(repository)],
      retry: (_, _) => null,
    );
  });

  /// 화면에 들어온 것처럼 목록을 구독하고 첫 로딩을 기다립니다.
  Future<NoticeListState> openList() {
    container.listen(noticeListProvider(meetingId), (_, _) {});
    return container.read(noticeListProvider(meetingId).future);
  }

  test('처음 화면에 들어오면 첫 페이지를 불러온다', () async {
    final state = await openList();

    expect(state.notices, hasLength(20));
    expect(state.hasNext, isTrue);
    expect(state.isEmpty, isFalse);
  });

  test('공지가 없으면 빈 상태가 된다', () async {
    repository.notices.clear();

    final state = await openList();

    expect(state.isEmpty, isTrue);
    expect(state.hasNext, isFalse);
  });

  test('loadMore 를 하면 다음 페이지를 이어 붙인다', () async {
    await openList();

    await container.read(noticeListProvider(meetingId).notifier).loadMore();

    final state = container.read(noticeListProvider(meetingId)).requireValue;
    expect(state.notices, hasLength(25));
    expect(state.page, 1);
    expect(state.hasNext, isFalse);
  });

  test('다음 페이지가 없으면 loadMore 를 해도 조회하지 않는다', () async {
    repository.notices.removeRange(5, 25);
    await openList();
    final callCount = repository.getNoticesCallCount;

    await container.read(noticeListProvider(meetingId).notifier).loadMore();

    expect(repository.getNoticesCallCount, callCount);
  });

  test('refresh 를 하면 첫 페이지를 다시 불러온다', () async {
    await openList();
    repository.notices.insert(0, buildNotice(100, title: '새 공지'));

    await container.read(noticeListProvider(meetingId).notifier).refresh();

    final state = container.read(noticeListProvider(meetingId)).requireValue;
    expect(state.notices.first.title, '새 공지');
  });

  test('조회에 실패하면 에러 상태가 된다', () async {
    repository.error = const NoticeException('모임 구성원이 아닙니다.');

    await expectLater(openList(), throwsA(isA<NoticeException>()));
    expect(container.read(noticeListProvider(meetingId)).hasError, isTrue);
  });

  test('모임에서 내 역할을 불러온다 (작성 버튼 노출용)', () async {
    repository.myRole = MemberRole.admin;
    container.listen(noticeMyRoleProvider(meetingId), (_, _) {});

    final role = await container.read(noticeMyRoleProvider(meetingId).future);

    expect(role.isAdmin, isTrue);
  });
}
