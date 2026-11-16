import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/auth_routes.dart';
import 'package:moamoa/features/auth/presentation/pages/profile_edit_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ProfileEditPage, () {
    late FakeAuthRepository repository;

    /// 내 계정 화면에서 편집을 눌러 엽니다.
    Future<void> openEdit(WidgetTester tester) async {
      tester.view.physicalSize = const Size(393, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(repository),
            initialAuthStatusProvider.overrideWithValue(
              AuthSessionStatus.authenticated,
            ),
          ],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(initialLocation: '/me', routes: authRoutes),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('편집'));
      await tester.pumpAndSettle();
    }

    Finder field(int index) => find.byType(TextField).at(index);

    Future<void> save(WidgetTester tester) async {
      await tester.tap(find.text('저장'));
      await tester.pumpAndSettle();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('지금 이름·휴대폰·이메일을 채워서 보여준다', (tester) async {
      await openEdit(tester);

      String textOf(int index) =>
          tester.widget<TextField>(field(index)).controller!.text;
      expect(textOf(0), '이서연');
      expect(textOf(1), '010-1234-5678');
      expect(textOf(2), 'moa@example.com');
    });

    testWidgets('이름과 색을 바꿔 저장하면 바뀐 값으로 요청한다', (tester) async {
      await openEdit(tester);
      await tester.enterText(field(0), '김서연');
      await tester.tap(find.bySemanticsLabel('검정'));
      await tester.pump();

      await save(tester);

      expect(repository.profileUpdates, [
        (name: '김서연', phone: '010-1234-5678', color: ProfileColor.dark),
      ]);
    });

    testWidgets('저장하면 내 계정 화면으로 돌아가 바뀐 이름을 보여준다', (tester) async {
      await openEdit(tester);
      await tester.enterText(field(0), '김서연');

      await save(tester);

      expect(find.text('프로필 편집'), findsNothing);
      expect(find.text('김서연'), findsOneWidget);
    });

    testWidgets('휴대폰을 지우고 저장하면 휴대폰 번호를 지우도록 요청한다', (tester) async {
      await openEdit(tester);
      await tester.enterText(field(1), '');

      await save(tester);

      expect(repository.profileUpdates.single.phone, isNull);
    });

    testWidgets('바꾼 것 없이 저장하면 요청 없이 내 계정 화면으로 돌아간다', (tester) async {
      await openEdit(tester);

      await save(tester);

      expect(repository.profileUpdates, isEmpty);
      expect(find.text('프로필 편집'), findsNothing);
    });

    testWidgets('이름을 비우고 저장하면 이름을 입력하라고 안내한다', (tester) async {
      await openEdit(tester);
      await tester.enterText(field(0), '');

      await save(tester);

      expect(find.text('이름을 입력해주세요.'), findsOneWidget);
      expect(repository.profileUpdates, isEmpty);
    });

    testWidgets('저장에 실패하면 편집 화면에서 서버 문구로 안내한다', (tester) async {
      await openEdit(tester);
      repository.error = const ApiException(
        code: ApiErrorCode.validation,
        message: '이름을 확인해 주세요.',
      );
      await tester.enterText(field(0), '김서연');

      await save(tester);

      expect(find.text('이름을 확인해 주세요.'), findsOneWidget);
      expect(find.text('프로필 편집'), findsOneWidget);
    });

    testWidgets('이메일 칸은 바꿀 수 없다고 안내한다', (tester) async {
      await openEdit(tester);

      expect(find.text('가입한 이메일은 바꿀 수 없어요.'), findsOneWidget);
      expect(tester.widget<TextField>(field(2)).readOnly, isTrue);
    });

    testWidgets('내 정보 없이 주소로 열면 내 계정 화면으로 보낸다', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(repository),
            initialAuthStatusProvider.overrideWithValue(
              AuthSessionStatus.authenticated,
            ),
          ],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: '/me/edit',
              routes: authRoutes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('편집'), findsOneWidget);
      expect(find.text('프로필 편집'), findsNothing);
    });
  });
}
