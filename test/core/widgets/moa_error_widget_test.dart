import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/widgets/moa_error_widget.dart';

void main() {
  group(MoaErrorWidget, () {
    Future<void> pumpErrorWidget(
      WidgetTester tester, {
      VoidCallback? onAction,
      String? actionLabel,
    }) {
      return tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: actionLabel == null
                ? MoaErrorWidget(
                    message: '불러오지 못했어요.',
                    onAction: onAction ?? () {},
                  )
                : MoaErrorWidget(
                    message: '불러오지 못했어요.',
                    actionLabel: actionLabel,
                    onAction: onAction ?? () {},
                  ),
          ),
        ),
      );
    }

    testWidgets('안내 문구를 보여준다', (tester) async {
      await pumpErrorWidget(tester);

      expect(find.text('불러오지 못했어요.'), findsOneWidget);
    });

    testWidgets('버튼 문구를 정하지 않으면 다시 시도를 보여준다', (tester) async {
      await pumpErrorWidget(tester);

      expect(find.widgetWithText(FilledButton, '다시 시도'), findsOneWidget);
    });

    testWidgets('지정한 버튼 문구를 보여준다', (tester) async {
      await pumpErrorWidget(tester, actionLabel: '목록으로');

      expect(find.widgetWithText(FilledButton, '목록으로'), findsOneWidget);
      expect(find.text('다시 시도'), findsNothing);
    });

    testWidgets('버튼을 누르면 넘겨 준 동작을 실행한다', (tester) async {
      var pressed = 0;
      await pumpErrorWidget(tester, onAction: () => pressed++);

      await tester.tap(find.text('다시 시도'));

      expect(pressed, 1);
    });

    testWidgets('안내 문구는 가운데 정렬로 보여준다', (tester) async {
      await pumpErrorWidget(tester);

      final text = tester.widget<Text>(find.text('불러오지 못했어요.'));
      expect(text.textAlign, TextAlign.center);
    });
  });
}
