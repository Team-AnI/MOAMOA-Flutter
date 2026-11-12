import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/presentation/widgets/group_design.dart';
import 'package:moamoa/features/group/presentation/widgets/group_mark.dart';

void main() {
  for (final size in [52.0, 100.0]) {
    testWidgets('${size.toInt()} 크기의 모임 마크에 기본 반경과 글자 스타일을 적용한다', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: GroupMark(name: ' 모아', size: size),
        ),
      );
      final text = tester.widget<Text>(find.text('모'));
      final mark = tester.widget<Container>(
        find.descendant(
          of: find.byType(GroupMark),
          matching: find.byType(Container),
        ),
      );
      final decoration = mark.decoration! as BoxDecoration;
      expect(decoration.borderRadius, BorderRadius.circular(size * .32));
      expect(decoration.color, GroupDesign.ink);
      expect(
        text.style,
        GroupDesign.heading.copyWith(
          color: Colors.white,
          fontSize: size > 80 ? 30 : 18,
        ),
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('빈 이름에는 기본 글자를 표시하고 홈에서 지정한 반경과 스타일을 적용한다', (tester) async {
    final style = GroupDesign.body.copyWith(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: GroupMark(
          name: '   ',
          size: 36,
          backgroundColor: GroupDesign.darkRaised,
          cornerRadius: 12,
          textStyle: style,
        ),
      ),
    );
    final mark = tester.widget<Container>(
      find.descendant(
        of: find.byType(GroupMark),
        matching: find.byType(Container),
      ),
    );
    final decoration = mark.decoration! as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(12));
    expect(decoration.color, GroupDesign.darkRaised);
    expect(tester.widget<Text>(find.text('모')).style, style);
    expect(tester.takeException(), isNull);
  });
}
