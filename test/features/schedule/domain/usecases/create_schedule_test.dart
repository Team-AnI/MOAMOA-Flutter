import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_exception.dart';
import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';

import '../../fakes/fake_schedule_repository.dart';

void main() {
  late FakeScheduleRepository repository;
  late CreateSchedule createSchedule;

  final startAt = DateTime(2026, 10, 11, 7);
  final endAt = DateTime(2026, 10, 11, 9);

  setUp(() {
    repository = FakeScheduleRepository();
    createSchedule = CreateSchedule(repository);
  });

  test('올바른 입력이면 저장하고 일정 id 를 돌려준다', () async {
    final id = await createSchedule(
      meetingId: 1,
      title: '10월 정기 러닝',
      description: '반포 한강공원 집합',
      startAt: startAt,
      endAt: endAt,
      location: '반포 한강공원',
    );

    expect(id, 100);
    expect(repository.createCalls.single, (
      meetingId: 1,
      title: '10월 정기 러닝',
      description: '반포 한강공원 집합',
      startAt: startAt,
      endAt: endAt,
      location: '반포 한강공원',
    ));
  });

  test('종료 일시는 시작과 같아도 되고, 설명/장소는 선택이다', () async {
    await createSchedule(
      meetingId: 1,
      title: '정모',
      startAt: startAt,
      endAt: startAt,
    );

    final call = repository.createCalls.single;
    expect(call.description, isNull);
    expect(call.location, isNull);
  });

  test('제목 앞뒤 공백은 지우고, 비어 있는 선택 입력은 null 로 보낸다', () async {
    await createSchedule(
      meetingId: 1,
      title: '  정모  ',
      description: '   ',
      startAt: startAt,
      location: '',
    );

    final call = repository.createCalls.single;
    expect(call.title, '정모');
    expect(call.description, isNull);
    expect(call.location, isNull);
  });

  group('잘못된 입력은 저장하지 않고 사유를 알려준다', () {
    final cases =
        <
          String,
          ({
            Future<int> Function(CreateSchedule) run,
            Set<ScheduleValidationError> errors,
          })
        >{
          '제목이 공백뿐': (
            run: (u) => u(meetingId: 1, title: '   ', startAt: startAt),
            errors: {ScheduleValidationError.titleRequired},
          ),
          '시작 일시 없음': (
            run: (u) => u(meetingId: 1, title: '정모'),
            errors: {ScheduleValidationError.startAtRequired},
          ),
          '종료가 시작보다 이전': (
            run: (u) =>
                u(meetingId: 1, title: '정모', startAt: endAt, endAt: startAt),
            errors: {ScheduleValidationError.endBeforeStart},
          ),
          '여러 항목이 동시에 잘못': (
            run: (u) => u(meetingId: 1, title: ''),
            errors: {
              ScheduleValidationError.titleRequired,
              ScheduleValidationError.startAtRequired,
            },
          ),
        };

    cases.forEach((name, c) {
      test(name, () async {
        await expectLater(
          c.run(createSchedule),
          throwsA(
            isA<ScheduleValidationException>().having(
              (e) => e.errors,
              'errors',
              c.errors,
            ),
          ),
        );
        expect(repository.createCalls, isEmpty);
      });
    });
  });
}
