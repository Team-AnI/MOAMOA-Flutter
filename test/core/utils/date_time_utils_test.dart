import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/utils/date_time_utils.dart';

void main() {
  group('isSameMoment', () {
    test('같은 순간을 UTC 와 로컬 시각으로 넘기면 같다고 판단한다', () {
      final utc = DateTime.utc(2026, 10, 11, 7);

      expect(isSameMoment(utc, utc.toLocal()), isTrue);
    });

    test('1분이라도 다르면 다르다고 판단한다', () {
      final a = DateTime(2026, 10, 11, 7);

      expect(isSameMoment(a, a.add(const Duration(minutes: 1))), isFalse);
    });

    test('둘 다 null 이면 같다고 판단한다', () {
      expect(isSameMoment(null, null), isTrue);
    });

    test('한쪽만 null 이면 다르다고 판단한다', () {
      final a = DateTime(2026, 10, 11, 7);

      expect(isSameMoment(a, null), isFalse);
      expect(isSameMoment(null, a), isFalse);
    });
  });
}
