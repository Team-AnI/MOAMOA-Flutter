import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedule.dart';

import '../providers/schedule_providers.dart';
import '../schedule_id.dart';

/// 일정 한 건의 상세 정보
class ScheduleDetailViewModel extends AsyncNotifier<Schedule> {
  ScheduleDetailViewModel({required this.id});

  final ScheduleId id;

  @override
  Future<Schedule> build() {
    return ref.read(getScheduleProvider)(
      GetScheduleParams(meetingId: id.meetingId, scheduleId: id.scheduleId),
    );
  }
}
