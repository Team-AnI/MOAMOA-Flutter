import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/presentation/widgets/notice_date_format.dart';

void main() {
  group('formatNoticeDate', () {
    test('올해 날짜도 연도까지 표시한다', () {
      expect(formatNoticeDate(DateTime(2026, 9, 12)), '2026년 9월 12일');
    });

    test('작년 날짜도 연도까지 표시한다', () {
      expect(formatNoticeDate(DateTime(2025, 12, 31)), '2025년 12월 31일');
    });
  });

  group('formatNoticeRelative', () {
    final now = DateTime(2026, 10, 16, 12);

    String format(Duration ago) =>
        formatNoticeRelative(now.subtract(ago), now: now);

    test('1분이 안 지났으면 방금 전이라고 표시한다', () {
      expect(format(const Duration(seconds: 30)), '방금 전');
    });

    test('1시간이 안 지났으면 분 단위로 표시한다', () {
      expect(format(const Duration(minutes: 5)), '5분 전');
    });

    test('하루가 안 지났으면 시간 단위로 표시한다', () {
      expect(format(const Duration(hours: 3)), '3시간 전');
    });

    test('일주일이 안 지났으면 일 단위로 표시한다', () {
      expect(format(const Duration(days: 3)), '3일 전');
    });

    test('한 달이 안 지났으면 주 단위로 표시한다', () {
      expect(format(const Duration(days: 20)), '2주 전');
    });

    test('한 달이 지났으면 개월 단위로 표시한다', () {
      expect(format(const Duration(days: 30)), '1개월 전');
      expect(format(const Duration(days: 95)), '3개월 전');
      expect(format(const Duration(days: 190)), '6개월 전');
    });

    test('1년이 되기 직전까지는 개월 단위로 표시한다', () {
      expect(format(const Duration(days: 364)), '12개월 전');
    });

    test('1년이 지났으면 년 단위로 표시한다', () {
      expect(format(const Duration(days: 365)), '1년 전');
      expect(format(const Duration(days: 800)), '2년 전');
    });
  });
}
