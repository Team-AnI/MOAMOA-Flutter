import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';

void main() {
  /// [onPressed] 를 실행하는 버튼 하나만 있는 화면을 띄웁니다.
  Future<void> pumpHost(
    WidgetTester tester,
    void Function(BuildContext context) onPressed,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => onPressed(context),
              child: const Text('열기'),
            ),
          ),
        ),
      ),
    );
  }

  group('showMoaSnackBar', () {
    testWidgets('메시지를 보여준다', (tester) async {
      await pumpHost(
        tester,
        (context) => showMoaSnackBar(context, message: '저장했어요.'),
      );

      await tester.tap(find.text('열기'));
      await tester.pump();

      expect(find.text('저장했어요.'), findsOneWidget);
    });

    testWidgets('동작 문구를 주지 않으면 동작 버튼을 보여주지 않는다', (tester) async {
      await pumpHost(
        tester,
        (context) => showMoaSnackBar(context, message: '저장했어요.'),
      );

      await tester.tap(find.text('열기'));
      await tester.pump();

      expect(find.byType(SnackBarAction), findsNothing);
    });

    testWidgets('동작 문구를 주면 동작 버튼을 보여준다', (tester) async {
      await pumpHost(
        tester,
        (context) => showMoaSnackBar(
          context,
          message: '등록하지 못했어요.',
          actionLabel: '다시 시도',
          onAction: () {},
        ),
      );

      await tester.tap(find.text('열기'));
      await tester.pump();

      expect(find.text('다시 시도'), findsOneWidget);
    });

    testWidgets('동작 버튼을 누르면 넘겨 준 동작을 실행한다', (tester) async {
      var pressed = 0;
      await pumpHost(
        tester,
        (context) => showMoaSnackBar(
          context,
          message: '등록하지 못했어요.',
          actionLabel: '다시 시도',
          onAction: () => pressed++,
        ),
      );
      await tester.tap(find.text('열기'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('다시 시도'));
      await tester.pump();

      expect(pressed, 1);
    });

    testWidgets('동작 없이 동작 문구만 넘기면 AssertionError 예외가 발생한다', (tester) async {
      await pumpHost(
        tester,
        (context) => showMoaSnackBar(
          context,
          message: '등록하지 못했어요.',
          actionLabel: '다시 시도',
        ),
      );

      await tester.tap(find.text('열기'));
      await tester.pump();

      expect(tester.takeException(), isAssertionError);
    });

    testWidgets('동작 문구 없이 동작만 넘기면 AssertionError 예외가 발생한다', (tester) async {
      await pumpHost(
        tester,
        (context) =>
            showMoaSnackBar(context, message: '등록하지 못했어요.', onAction: () {}),
      );

      await tester.tap(find.text('열기'));
      await tester.pump();

      expect(tester.takeException(), isAssertionError);
    });
  });
}
