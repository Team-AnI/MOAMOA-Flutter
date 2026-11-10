import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/presentation/providers/notice_providers.dart';
import 'package:moamoa/features/notice/presentation/viewmodels/notice_detail_view_model.dart';

import '../../fakes/fake_notice_repository.dart';

void main() {
  const args = (meetingId: 1, noticeId: 1);

  group(NoticeDetailViewModel, () {
    late ProviderContainer container;

    setUp(() {
      final repository = FakeNoticeRepository(
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
  });
}
