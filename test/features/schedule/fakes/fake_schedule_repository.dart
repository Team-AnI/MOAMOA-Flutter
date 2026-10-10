import 'dart:async';

import 'package:moamoa/features/schedule/domain/entities/created_schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_create_request.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// 테스트용 Fake Repository. mocktail 대신 직접 구현합니다.
class FakeScheduleRepository implements ScheduleRepository {
  FakeScheduleRepository({this.schedules = const []});

  List<Schedule> schedules;
  final List<ScheduleCreateRequest> createCalls = [];
  int listCallCount = 0;

  /// 지정하면 이 Future 가 끝날 때까지 createSchedule 이 완료되지 않습니다.
  Completer<int>? createCompleter;

  /// 지정하면 모든 호출이 이 예외를 던집니다.
  Object? error;

  @override
  Future<CreatedSchedule> createSchedule(ScheduleCreateRequest request) async {
    createCalls.add(request);
    if (error != null) throw error!;
    final id = await (createCompleter?.future ?? Future.value(100));
    return CreatedSchedule(
      id: id,
      title: request.title,
      startAt: request.startAt,
    );
  }

  @override
  Future<List<Schedule>> getSchedules(ScheduleListRequest request) async {
    listCallCount++;
    if (error != null) throw error!;
    return schedules;
  }

  @override
  Future<Schedule> getSchedule(ScheduleDetailRequest request) async {
    if (error != null) throw error!;
    return schedules.firstWhere((s) => s.id == request.scheduleId);
  }
}
