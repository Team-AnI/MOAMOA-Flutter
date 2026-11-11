import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/presentation/schedule_format.dart';

void main() {
  group('ScheduleDateFormatX.meridiemTime', () {
    test('19시 0분은 "오후 7:00" 으로 표시된다', () {
      expect(DateTime(2026, 10, 11, 19).meridiemTime, '오후 7:00');
    });

    test('0시 30분(자정)은 "오전 12:30" 으로 표시된다', () {
      expect(DateTime(2026, 10, 11, 0, 30).meridiemTime, '오전 12:30');
    });

    test('12시 5분(정오)은 "오후 12:05" 로 표시된다', () {
      expect(DateTime(2026, 10, 11, 12, 5).meridiemTime, '오후 12:05');
    });
  });
}
