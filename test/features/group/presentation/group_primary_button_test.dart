import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/presentation/widgets/group_design.dart';
import 'package:moamoa/features/group/presentation/widgets/group_primary_button.dart';

void main() {
  group(GroupPrimaryButton, () {
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
  });
}
