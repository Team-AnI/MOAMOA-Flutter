import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/domain/entities/notice.dart';
import 'package:moamoa/features/notice/domain/entities/notice_author.dart';
import 'package:moamoa/features/notice/presentation/notice_format.dart';

void main() {
  group('formatNoticeDate', () {
    test('올해 날짜도 연도를 포함해 2026년 9월 12일로 표시한다', () {
      expect(formatNoticeDate(DateTime(2026, 9, 12)), '2026년 9월 12일');
    });

    test('작년 날짜도 연도를 포함해 2025년 12월 31일로 표시한다', () {
      expect(formatNoticeDate(DateTime(2025, 12, 31)), '2025년 12월 31일');
    });
  });

  group('formatNoticeRelative', () {
    final now = DateTime(2026, 10, 16, 12);

    String format(Duration ago) =>
        formatNoticeRelative(now.subtract(ago), now: now);

    test('30초가 지났으면 방금 전으로 표시한다', () {
      expect(format(const Duration(seconds: 30)), '방금 전');
    });

    test('5분이 지났으면 5분 전으로 표시한다', () {
      expect(format(const Duration(minutes: 5)), '5분 전');
    });

    test('3시간이 지났으면 3시간 전으로 표시한다', () {
      expect(format(const Duration(hours: 3)), '3시간 전');
    });

    test('3일이 지났으면 3일 전으로 표시한다', () {
      expect(format(const Duration(days: 3)), '3일 전');
    });

    test('20일이 지났으면 2주 전으로 표시한다', () {
      expect(format(const Duration(days: 20)), '2주 전');
    });

    test('30일부터 개월 단위로 표시해 30일은 1개월 전, 95일은 3개월 전, 190일은 6개월 전으로 표시한다', () {
      expect(format(const Duration(days: 30)), '1개월 전');
      expect(format(const Duration(days: 95)), '3개월 전');
      expect(format(const Duration(days: 190)), '6개월 전');
    });

    test('59초는 방금 전, 1분부터는 1분 전으로 표시한다', () {
      expect(format(const Duration(seconds: 59)), '방금 전');
      expect(format(const Duration(minutes: 1)), '1분 전');
    });

    test('59분은 59분 전, 1시간부터는 1시간 전으로 표시한다', () {
      expect(format(const Duration(minutes: 59)), '59분 전');
      expect(format(const Duration(hours: 1)), '1시간 전');
    });

    test('23시간은 23시간 전, 1일부터는 1일 전으로 표시한다', () {
      expect(format(const Duration(hours: 23)), '23시간 전');
      expect(format(const Duration(days: 1)), '1일 전');
    });

    test('6일은 6일 전, 7일부터는 1주 전으로 표시한다', () {
      expect(format(const Duration(days: 6)), '6일 전');
      expect(format(const Duration(days: 7)), '1주 전');
    });

    test('29일은 4주 전, 30일부터는 1개월 전으로 표시한다', () {
      expect(format(const Duration(days: 29)), '4주 전');
      expect(format(const Duration(days: 30)), '1개월 전');
    });

    test('364일은 1년이 되기 전이라 12개월 전으로 표시한다', () {
      expect(format(const Duration(days: 364)), '12개월 전');
    });

    test('365일부터 년 단위로 표시해 365일은 1년 전, 800일은 2년 전으로 표시한다', () {
      expect(format(const Duration(days: 365)), '1년 전');
      expect(format(const Duration(days: 800)), '2년 전');
    });
  });

  group('NoticeMetaX', () {
    Notice noticeBy(NoticeAuthor? author, {DateTime? createdAt}) => Notice(
      id: 1,
      title: '10월 회비 안내',
      createdAt: createdAt ?? DateTime(2026, 9, 12),
      author: author,
    );

    test('목록에는 작성자 이름과 작성 시각을 가운뎃점으로 이어 보여준다', () {
      final notice = noticeBy(
        const NoticeAuthor(memberId: 3, userName: '김모아'),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(notice.listMeta, '김모아 · 1일 전');
    });

    test('상세에는 작성자 이름과 작성일을 가운뎃점으로 이어 보여준다', () {
      final notice = noticeBy(const NoticeAuthor(memberId: 3, userName: '김모아'));

      expect(notice.detailMeta, '김모아 · 2026년 9월 12일');
    });

    test('작성자 이름이 없으면 이름 미설정으로 보여준다', () {
      final notice = noticeBy(const NoticeAuthor(memberId: 3));

      expect(notice.detailMeta, '이름 미설정 · 2026년 9월 12일');
    });

    test('나간 작성자는 서버가 보낸 탈퇴한 사용자를 그대로 보여준다', () {
      final notice = noticeBy(
        const NoticeAuthor(memberId: 3, userName: '탈퇴한 사용자'),
      );

      expect(notice.detailMeta, '탈퇴한 사용자 · 2026년 9월 12일');
    });

    test('작성자를 받지 못한 공지는 작성 시각만 보여준다', () {
      final notice = noticeBy(null);

      expect(notice.detailMeta, '2026년 9월 12일');
    });
  });
}
