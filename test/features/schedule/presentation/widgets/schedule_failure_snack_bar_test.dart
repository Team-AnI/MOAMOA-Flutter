import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/presentation/widgets/schedule_failure_snack_bar.dart';

void main() {
  group('ScheduleFailureSnackBar', () {
    testWidgets('전달한 제목과 다시 시도 안내를 함께 보여준다', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  ScheduleFailureSnackBar(message: '일정을 취소하지 못했어요'),
                ),
                child: const Text('실패 알림 열기'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('실패 알림 열기'));
      await tester.pump();

      expect(find.text('일정을 취소하지 못했어요'), findsOneWidget);
      expect(find.text('잠시 후 다시 시도해 주세요'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
