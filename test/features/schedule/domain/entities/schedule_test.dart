import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

void main() {
  test('설명과 장소는 입력하지 않으면 빈 문자열이고, 종료 일시만 null 이다', () {
    final schedule = Schedule(
      id: 1,
      title: '정모',
      startAt: DateTime(2026, 10, 11, 7),
    );

    expect(schedule.description, '');
    expect(schedule.location, '');
    expect(schedule.endAt, isNull);
  });
}
