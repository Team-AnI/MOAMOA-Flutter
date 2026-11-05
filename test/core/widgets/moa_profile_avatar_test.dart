import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_profile_avatar.dart';

void main() {
  Future<void> pumpAvatar(WidgetTester tester, Widget avatar) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Center(child: avatar)),
      ),
    );
  }

  group(MoaProfileAvatar, () {
    testWidgets('이름 첫 글자를 보여준다', (tester) async {
      await pumpAvatar(
        tester,
        const MoaProfileAvatar(userName: '김모아', color: ProfileColor.lightBlue),
      );

      expect(find.text('김'), findsOneWidget);
    });

    testWidgets('이름이 없으면 물음표를 보여준다', (tester) async {
      await pumpAvatar(
        tester,
        const MoaProfileAvatar(userName: null, color: ProfileColor.lightBlue),
      );

      expect(find.text('?'), findsOneWidget);
    });

    testWidgets('크기를 정하지 않으면 지름 44 로 그린다', (tester) async {
      await pumpAvatar(
        tester,
        const MoaProfileAvatar(userName: '김모아', color: ProfileColor.lightBlue),
      );

      expect(tester.getSize(find.byType(CircleAvatar)), const Size(44, 44));
    });

    testWidgets('지정한 크기를 지름으로 그린다', (tester) async {
      await pumpAvatar(
        tester,
        const MoaProfileAvatar(
          userName: '김모아',
          color: ProfileColor.lightBlue,
          size: 32,
        ),
      );

      expect(tester.getSize(find.byType(CircleAvatar)), const Size(32, 32));
    });

    testWidgets('크기를 정하지 않으면 글자 크기 17 로 그린다', (tester) async {
      await pumpAvatar(
        tester,
        const MoaProfileAvatar(userName: '김모아', color: ProfileColor.lightBlue),
      );

      expect(
        tester.widget<Text>(find.text('김')).style?.fontSize,
        closeTo(17, 0.001),
      );
    });

    testWidgets('지름이 작아지면 같은 비율로 글자 크기를 줄인다', (tester) async {
      await pumpAvatar(
        tester,
        const MoaProfileAvatar(
          userName: '김모아',
          color: ProfileColor.lightBlue,
          size: 22,
        ),
      );

      expect(
        tester.widget<Text>(find.text('김')).style?.fontSize,
        closeTo(8.5, 0.001),
      );
    });

    for (final (color, background, foreground) in [
      (ProfileColor.lightBlue, MoaColors.accentTint, MoaColors.accentText),
      (ProfileColor.gray, MoaColors.profileGray, MoaColors.textPrimary),
      (ProfileColor.blue, MoaColors.profileBlue, MoaColors.textPrimary),
      (ProfileColor.dark, MoaColors.accent, MoaColors.textInverse),
    ]) {
      testWidgets('${color.name} 프로필 색에 맞는 배경과 글자색으로 그린다', (tester) async {
        await pumpAvatar(
          tester,
          MoaProfileAvatar(userName: '김모아', color: color),
        );

        final avatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
        final initial = tester.widget<Text>(find.text('김'));
        expect(avatar.backgroundColor, background);
        expect(initial.style?.color, foreground);
      });
    }
  });
}
