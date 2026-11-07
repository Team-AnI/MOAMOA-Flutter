import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_dialogs.dart';

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

  group('showMoaConfirmDialog', () {
    late Future<bool?> result;

    Future<void> openDialog(WidgetTester tester) async {
      await pumpHost(tester, (context) {
        result = showMoaConfirmDialog(
          context,
          title: '삭제할까요?',
          message: '되돌릴 수 없어요.',
          confirmLabel: '삭제',
        );
      });
      await tester.tap(find.text('열기'));
      await tester.pumpAndSettle();
    }

    testWidgets('제목과 메시지를 보여준다', (tester) async {
      await openDialog(tester);

      expect(find.text('삭제할까요?'), findsOneWidget);
      expect(find.text('되돌릴 수 없어요.'), findsOneWidget);
    });

    testWidgets('취소 버튼 문구를 따로 정하지 않으면 취소를 보여준다', (tester) async {
      await openDialog(tester);

      expect(find.text('취소'), findsOneWidget);
    });

    testWidgets('지정한 취소 버튼 문구를 보여준다', (tester) async {
      await pumpHost(tester, (context) {
        showMoaConfirmDialog(
          context,
          title: '나갈까요?',
          message: '입력한 내용이 사라져요.',
          confirmLabel: '나가기',
          cancelLabel: '계속 작성',
        );
      });
      await tester.tap(find.text('열기'));
      await tester.pumpAndSettle();

      expect(find.text('계속 작성'), findsOneWidget);
      expect(find.text('나가기'), findsOneWidget);
    });

    testWidgets('확인을 누르면 true 를 돌려준다', (tester) async {
      await openDialog(tester);

      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();

      expect(await result, isTrue);
    });

    testWidgets('확인을 누르면 팝업이 닫힌다', (tester) async {
      await openDialog(tester);

      await tester.tap(find.text('삭제'));
      await tester.pumpAndSettle();

      expect(find.text('삭제할까요?'), findsNothing);
    });

    testWidgets('취소를 누르면 false 를 돌려준다', (tester) async {
      await openDialog(tester);

      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();

      expect(await result, isFalse);
    });

    testWidgets('취소를 누르면 팝업이 닫힌다', (tester) async {
      await openDialog(tester);

      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();

      expect(find.text('삭제할까요?'), findsNothing);
    });

    testWidgets('팝업 바깥을 눌러 닫으면 null 을 돌려준다', (tester) async {
      await openDialog(tester);

      await tester.tapAt(const Offset(2, 2));
      await tester.pumpAndSettle();

      expect(await result, isNull);
    });

    testWidgets('확인 버튼은 어두운 배경 위에 밝은 글자로 보인다', (tester) async {
      await openDialog(tester);

      final text = tester.widget<Text>(find.text('삭제'));
      final button = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, '삭제'),
      );

      expect(text.style?.color, MoaColors.textInverse);
      expect(button.style?.backgroundColor?.resolve({}), MoaColors.accent);
    });

    testWidgets('취소 버튼은 연한 배경 위에 진한 글자로 보인다', (tester) async {
      await openDialog(tester);

      final text = tester.widget<Text>(find.text('취소'));
      final button = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, '취소'),
      );

      expect(text.style?.color, MoaColors.textPrimary);
      expect(button.style?.backgroundColor?.resolve({}), MoaColors.fill);
    });
  });
}
