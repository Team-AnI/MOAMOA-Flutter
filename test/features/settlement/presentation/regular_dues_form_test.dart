import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/settlement/presentation/pages/regular_dues_form_page.dart';

void main() {
  group(RegularDuesFormPage, () {
    setUpAll(() async {
      await (FontLoader('Pretendard')
            ..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf')))
          .load();
      await (FontLoader(
        'MaterialIcons',
      )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    });

    for (final width in [393.0, 320.0]) {
      testWidgets('정기 회비 등록 화면은 ${width.toInt()}px에서 넘치지 않는다', (tester) async {
        tester.view.physicalSize = Size(width, 852);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final boundary = GlobalKey();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              groupMyRoleProvider.overrideWith(
                (ref, id) async => MemberRole.admin,
              ),
            ],
            child: RepaintBoundary(
              key: boundary,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                home: const RegularDuesFormPage(meetingId: 7),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('정기 회비 시작하기'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
