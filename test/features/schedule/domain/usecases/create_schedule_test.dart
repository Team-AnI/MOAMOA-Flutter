import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_create_request.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_error.dart';
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
    createSchedule = CreateScheduleImpl(repository: repository);
  });

  test('올바른 입력이면 요청 객체로 저장하고 일정 id 를 돌려준다', () async {
    final id = await createSchedule(
      CreateScheduleParams(
        meetingId: 1,
        title: '10월 정기 러닝',
        description: '반포 한강공원 집합',
        startAt: startAt,
        endAt: endAt,
        location: '반포 한강공원',
      ),
    );

    expect(id, 100);
    expect(
      repository.createCalls.single,
      ScheduleCreateRequest(
        meetingId: 1,
        title: '10월 정기 러닝',
        description: '반포 한강공원 집합',
        startAt: startAt,
        endAt: endAt,
        location: '반포 한강공원',
      ),
    );
  });

  test('종료 일시는 시작과 같아도 되고, 설명/장소는 선택이다', () async {
    await createSchedule(
      CreateScheduleParams(
        meetingId: 1,
        title: '정모',
        startAt: startAt,
        endAt: startAt,
      ),
    );

    final request = repository.createCalls.single;
    expect(request.description, '');
    expect(request.location, '');
  });

  test('제목 앞뒤 공백은 지우고, 공백뿐인 선택 입력은 빈 문자열로 보낸다', () async {
    await createSchedule(
      CreateScheduleParams(
        meetingId: 1,
        title: '  정모  ',
        description: '   ',
        startAt: startAt,
        location: '  ',
      ),
    );

    final request = repository.createCalls.single;
    expect(request.title, '정모');
    expect(request.description, '');
    expect(request.location, '');
  });

  group('잘못된 입력은 저장하지 않고 사유를 알려준다', () {
    final cases =
        <
          String,
          ({CreateScheduleParams params, Set<ScheduleValidationError> errors})
        >{
          '제목이 공백뿐': (
            params: CreateScheduleParams(
              meetingId: 1,
              title: '   ',
              startAt: startAt,
            ),
            errors: {ScheduleValidationError.titleRequired},
          ),
          '시작 일시 없음': (
            params: const CreateScheduleParams(meetingId: 1, title: '정모'),
            errors: {ScheduleValidationError.startAtRequired},
          ),
          '종료가 시작보다 이전': (
            params: CreateScheduleParams(
              meetingId: 1,
              title: '정모',
              startAt: endAt,
              endAt: startAt,
            ),
            errors: {ScheduleValidationError.endBeforeStart},
          ),
          '여러 항목이 동시에 잘못': (
            params: const CreateScheduleParams(meetingId: 1, title: ''),
            errors: {
              ScheduleValidationError.titleRequired,
              ScheduleValidationError.startAtRequired,
            },
          ),
        };

    cases.forEach((name, c) {
      test(name, () async {
        await expectLater(
          createSchedule(c.params),
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
