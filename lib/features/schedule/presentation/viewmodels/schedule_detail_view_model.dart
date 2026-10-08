import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../providers/schedule_providers.dart';

typedef ScheduleDetailArgs = ({int meetingId, int scheduleId});

/// 일정 한 건의 상세 정보
class ScheduleDetailViewModel extends AsyncNotifier<Schedule> {
  ScheduleDetailViewModel(this.args);

  final ScheduleDetailArgs args;

  @override
  Future<Schedule> build() {
    return ref
        .read(scheduleRepositoryProvider)
        .getSchedule(meetingId: args.meetingId, scheduleId: args.scheduleId);
  }
}
