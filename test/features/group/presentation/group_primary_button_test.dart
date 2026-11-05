import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/presentation/widgets/group_design.dart';
import 'package:moamoa/features/group/presentation/widgets/group_primary_button.dart';

void main() {
  group(GroupPrimaryButton, () {
    test('보조·삭제 옵션을 동시에 지정할 수 없다', () {
      expect(
        () => GroupPrimaryButton(
          label: '잘못된 조합',
          secondary: true,
          destructive: true,
        ),
        throwsAssertionError,
      );
    });
    for (final (label, secondary, destructive, background, foreground) in [
      ('기본', false, false, GroupDesign.ink, Colors.white),
      ('보조', true, false, GroupDesign.fill, GroupDesign.ink),
      ('삭제', false, true, GroupDesign.dangerTint, GroupDesign.danger),
    ]) {
      testWidgets('$label 버튼은 해당 색상과 동작을 유지한다', (tester) async {
        var tapped = 0;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GroupPrimaryButton(
                label: label,
                secondary: secondary,
                destructive: destructive,
                onPressed: () => tapped++,
              ),
            ),
          ),
        );
        final button = tester.widget<FilledButton>(find.byType(FilledButton));
        expect(button.style!.backgroundColor!.resolve({}), background);
        expect(button.style!.foregroundColor!.resolve({}), foreground);
        await tester.tap(find.text(label));
        expect(tapped, 1);
      });
    }
    for (final (label, secondary, destructive) in [
      ('기본', false, false),
      ('보조', true, false),
      ('삭제', false, true),
    ]) {
      testWidgets('$label 버튼은 비활성 상태에서 실행할 수 없다', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GroupPrimaryButton(
                label: '비활성',
                secondary: secondary,
                destructive: destructive,
              ),
            ),
          ),
        );
        final button = tester.widget<FilledButton>(find.byType(FilledButton));
        expect(button.onPressed, isNull);
        expect(
          button.style!.backgroundColor!.resolve({WidgetState.disabled}),
          GroupDesign.fill,
        );
        expect(
          button.style!.foregroundColor!.resolve({WidgetState.disabled}),
          GroupDesign.muted,
        );
      });
    }
  });
}
