import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/data/dtos/schedule_response.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

void main() {
  test('상세 응답의 ISO-8601(KST) 일시를 DateTime 으로 바꿔 Entity 로 변환한다', () {
    final entity = ScheduleResponse.fromJson(const {
      'scheduleId': 20,
      'title': '10월 정기 러닝',
      'description': '반포 한강공원 집합',
      'startAt': '2026-10-11T07:00:00+09:00',
      'endAt': '2026-10-11T09:00:00+09:00',
      'location': '반포 한강공원',
    }).toEntity();

    expect(
      entity,
      Schedule(
        id: 20,
        title: '10월 정기 러닝',
        description: '반포 한강공원 집합',
        startAt: DateTime.utc(2026, 10, 10, 22),
        endAt: DateTime.utc(2026, 10, 11),
        location: '반포 한강공원',
      ),
    );
  });

  test('목록 응답처럼 description, endAt, location 이 없어도 변환할 수 있다', () {
    final entity = ScheduleResponse.fromJson(const {
      'scheduleId': 21,
      'title': '정모',
      'startAt': '2026-10-11T07:00:00+09:00',
      'endAt': null,
    }).toEntity();

    expect(entity.description, '');
    expect(entity.endAt, isNull);
    expect(entity.location, '');
  });

  test('서버가 설명과 장소를 null 로 내려줘도 빈 문자열로 변환한다', () {
    final entity = ScheduleResponse.fromJson(const {
      'scheduleId': 22,
      'title': '정모',
      'description': null,
      'startAt': '2026-10-11T07:00:00+09:00',
      'location': null,
    }).toEntity();

    expect(entity.description, '');
    expect(entity.location, '');
  });
}
