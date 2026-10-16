import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_update_request.dart';
import 'package:moamoa/features/schedule/domain/usecases/update_schedule.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late UpdateSchedule updateSchedule;

  final startAt = DateTime(2026, 10, 11, 7);
  final endAt = DateTime(2026, 10, 11, 9);
  final original = Schedule(
    id: 20,
    title: '10월 정기 러닝',
    description: '반포 한강공원 집합',
    startAt: startAt,
    endAt: endAt,
    location: '반포 한강공원',
  );

  setUp(() {
    repository = FakeScheduleRepository();
    updateSchedule = UpdateScheduleImpl(scheduleRepository: repository);
  });

  UpdateScheduleParams params({
    String title = '10월 정기 러닝',
    String description = '반포 한강공원 집합',
    DateTime? start,
    DateTime? end,
    String location = '반포 한강공원',
  }) {
    return UpdateScheduleParams(
      meetingId: 1,
      original: original,
      title: title,
      description: description,
      startAt: start ?? startAt,
      endAt: end ?? endAt,
      location: location,
    );
  }

  group('UpdateSchedule', () {
    test('바뀐 필드만 요청에 담아 저장한다', () async {
      await updateSchedule(params(title: '11월 정기 러닝', location: '잠실 공원'));

      expect(
        repository.updateCalls.single,
        const ScheduleUpdateRequest(
          meetingId: 1,
          scheduleId: 20,
          title: '11월 정기 러닝',
          location: '잠실 공원',
        ),
      );
    });

    test('시작·종료 일시가 바뀌면 바뀐 일시를 요청에 담는다', () async {
      final newStart = DateTime(2026, 10, 12, 7);
      final newEnd = DateTime(2026, 10, 12, 9);

      await updateSchedule(params(start: newStart, end: newEnd));

      final request = repository.updateCalls.single;
      expect(request.startAt, newStart);
      expect(request.endAt, newEnd);
      expect(request.title, isNull);
    });

    test('바뀐 필드가 없으면 저장하지 않는다', () async {
      await updateSchedule(params());

      expect(repository.updateCalls, isEmpty);
    });

    test('제목 앞뒤 공백은 지우고, 공백만 바뀐 입력은 바뀌지 않은 것으로 본다', () async {
      await updateSchedule(params(title: '  10월 정기 러닝  '));

      expect(repository.updateCalls, isEmpty);
    });

    test('설명이나 장소를 비우면 빈 문자열로 보낸다', () async {
      await updateSchedule(params(description: '   ', location: ''));

      final request = repository.updateCalls.single;
      expect(request.description, '');
      expect(request.location, '');
    });
  });
}
