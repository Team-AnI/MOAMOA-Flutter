import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_slot_interval.dart';
import 'package:moamoa/features/vote/presentation/viewmodels/vote_time_range.dart';

void main() {
  group(VoteTimeRange, () {
    test('기본값으로 만들면 18:00~20:30 을 30분 간격으로 나눠 5칸이 된다', () {
      const range = VoteTimeRange();

      expect(range.slots, [
        const Duration(hours: 18),
        const Duration(hours: 18, minutes: 30),
        const Duration(hours: 19),
        const Duration(hours: 19, minutes: 30),
        const Duration(hours: 20),
      ]);
      expect(range.label, '18:00 ~ 20:30 · 30분 단위');
      expect(range.summary, '18:00부터 20:30까지 5칸으로 투표해요');
    });

    test('1시간 간격으로 바꾸면 종료 전까지 18:00·19:00·20:00 3칸이 된다', () {
      const range = VoteTimeRange(interval: VoteSlotInterval.oneHour);

      expect(range.slots, [
        const Duration(hours: 18),
        const Duration(hours: 19),
        const Duration(hours: 20),
      ]);
      expect(range.label, '18:00 ~ 20:30 · 1시간 단위');
    });

    const invalidEnds = {
      '18:00': Duration(hours: 18),
      '17:30': Duration(hours: 17, minutes: 30),
    };

    for (final MapEntry(key: label, value: end) in invalidEnds.entries) {
      test('시작 18:00 · 종료 $label 이면 잘못된 범위가 되어 후보를 만들지 않는다', () {
        final range = VoteTimeRange(end: end);

        expect(range.isValid, isFalse);
        expect(range.slots, isEmpty);
      });
    }
  });
}
