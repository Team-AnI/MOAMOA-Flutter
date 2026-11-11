import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_delete_request.dart';
import 'package:moamoa/features/schedule/domain/usecases/delete_schedule.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late DeleteSchedule deleteSchedule;

  setUp(() {
    repository = FakeScheduleRepository();
    deleteSchedule = DeleteScheduleImpl(scheduleRepository: repository);
  });

  group('DeleteSchedule', () {
    test('모임과 일정을 요청 객체로 만들어 취소를 요청한다', () async {
      await deleteSchedule(
        const DeleteScheduleParams(meetingId: 1, scheduleId: 20),
      );

      expect(
        repository.deleteCalls.single,
        const ScheduleDeleteRequest(meetingId: 1, scheduleId: 20),
      );
    });

    test('저장소가 실패하면 예외가 발생한다', () async {
      repository.error = Exception('network');

      expect(
        () => deleteSchedule(
          const DeleteScheduleParams(meetingId: 1, scheduleId: 20),
        ),
        throwsException,
      );
    });
  });
}
