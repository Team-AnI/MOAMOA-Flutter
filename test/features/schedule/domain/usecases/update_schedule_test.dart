import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_update_request.dart';
import 'package:moamoa/features/schedule/domain/usecases/update_schedule.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late UpdateSchedule updateSchedule;

  setUp(() {
    repository = FakeScheduleRepository();
    updateSchedule = UpdateScheduleImpl(scheduleRepository: repository);
  });

  group('UpdateSchedule', () {
    test('받은 필드를 요청 객체로 만들어 수정을 요청한다', () async {
      await updateSchedule(
        const UpdateScheduleParams(
          meetingId: 1,
          scheduleId: 20,
          title: '11월 정기 러닝',
          location: '잠실 공원',
        ),
      );

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
  });
}
