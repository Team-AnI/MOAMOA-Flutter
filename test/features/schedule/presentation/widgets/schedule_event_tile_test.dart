import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_status.dart';
import 'package:moamoa/features/schedule/presentation/widgets/schedule_event_tile.dart';

void main() {
  final schedule = Schedule(
    id: 7,
    title: '10월 정기 모임',
    startAt: DateTime(2099, 10, 13, 18),
  );

  Future<void> pumpTile(WidgetTester tester, Schedule schedule) =>
      tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ScheduleEventTile(schedule: schedule)),
        ),
      );

  group(ScheduleEventTile, () {
    testWidgets('일정은 시작 시각과 확정 라벨을 보여준다', (tester) async {
      await pumpTile(tester, schedule);

      expect(find.text('18:00'), findsOneWidget);
      expect(find.text('확정'), findsOneWidget);
    });

    testWidgets('투표 중 일정은 임시 시작 시각 대신 투표와 투표 중 라벨을 보여준다', (tester) async {
      await pumpTile(tester, schedule.copyWith(status: ScheduleStatus.voting));

      expect(find.text('18:00'), findsNothing);
      expect(find.text('투표'), findsOneWidget);
      expect(find.text('투표 중'), findsOneWidget);
    });
  });
}
