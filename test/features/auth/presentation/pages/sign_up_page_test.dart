import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/presentation/auth_routes.dart';
import 'package:moamoa/features/auth/presentation/pages/sign_up_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(SignUpPage, () {
    late FakeAuthRepository repository;

    Future<void> openSignUp(WidgetTester tester) async {
      // 입력칸이 많아 아래 버튼·링크까지 한 화면에 보이도록 높이를 넉넉히 둡니다.
      tester.view.physicalSize = const Size(393, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repository)],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: '/signup',
              routes: authRoutes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> fill(
      WidgetTester tester, {
      String name = '이서연',
      String email = 'moa@example.com',
      String phone = '',
      String password = 'moamoa123',
      String? confirm,
    }) async {
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), name);
      await tester.enterText(fields.at(1), email);
      await tester.enterText(fields.at(2), phone);
      await tester.enterText(fields.at(3), password);
      await tester.enterText(fields.at(4), confirm ?? password);
    }

    Future<void> agree(WidgetTester tester) async {
      await tester.tap(find.text('이용약관과 개인정보 처리방침에 동의해요'));
      await tester.pump();
    }

    Future<void> submit(WidgetTester tester) async {
      await tester.tap(find.text('다음'));
      await tester.pump();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('약관에 동의한 뒤 다음을 누르면 입력한 값으로 가입을 요청한다', (tester) async {
      await openSignUp(tester);
      await fill(tester, phone: '010-1234-5678');
      await agree(tester);

      await submit(tester);
      await tester.pumpAndSettle();

      expect(repository.signUps, [
        (
          name: '이서연',
          email: 'moa@example.com',
          password: 'moamoa123',
          phone: '010-1234-5678',
          agreedToTerms: true,
        ),
      ]);
    });

    testWidgets('가입하면 프로필 설정 화면으로 이동해 입력한 이름 첫 글자를 보여준다', (tester) async {
      await openSignUp(tester);
      await fill(tester);
      await agree(tester);

      await submit(tester);
      await tester.pumpAndSettle();

      expect(find.text('프로필을 정해요'), findsOneWidget);
      expect(find.text('이'), findsWidgets);
    });

    testWidgets('약관에 동의하지 않은 채 다음을 누르면 동의하라고 안내한다', (tester) async {
      await openSignUp(tester);
      await fill(tester);

      await submit(tester);

      expect(find.text('이용약관과 개인정보 처리방침에 동의해 주세요.'), findsOneWidget);
      expect(repository.signUps, isEmpty);
    });

    testWidgets('비밀번호 확인이 다르면 일치하지 않는다고 안내한다', (tester) async {
      await openSignUp(tester);
      await fill(tester, confirm: 'moamoa124');
      await agree(tester);

      await submit(tester);

      expect(find.text('비밀번호가 일치하지 않아요.'), findsOneWidget);
      expect(repository.signUps, isEmpty);
    });

    testWidgets('이름을 비운 채 누르면 이름을 입력하라고 안내한다', (tester) async {
      await openSignUp(tester);
      await fill(tester, name: '');
      await agree(tester);

      await submit(tester);

      expect(find.text('이름을 입력해주세요.'), findsOneWidget);
    });

    testWidgets('입력 안내가 없을 때는 비밀번호 규칙을 안내한다', (tester) async {
      await openSignUp(tester);

      expect(find.text('영문과 숫자를 포함해 8~72자로 만들어 주세요.'), findsOneWidget);
    });

    testWidgets('서버 문구 없이 409 면 이미 쓰인 이메일이라고 안내한다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.conflict);
      await openSignUp(tester);
      await fill(tester);
      await agree(tester);

      await submit(tester);
      await tester.pumpAndSettle();

      expect(find.text('이미 가입했거나 탈퇴 후 7일이 지나지 않은 이메일이에요.'), findsOneWidget);
    });

    testWidgets('이용약관 보기를 누르면 이용약관 전문을 보여준다', (tester) async {
      await openSignUp(tester);

      await tester.tap(find.text('이용약관 보기'));
      await tester.pumpAndSettle();

      expect(find.textContaining('제1조 (목적)'), findsOneWidget);
    });

    testWidgets('개인정보 처리방침 보기를 누르면 수집 항목을 보여준다', (tester) async {
      await openSignUp(tester);

      await tester.tap(find.text('개인정보 처리방침 보기'));
      await tester.pumpAndSettle();

      expect(find.textContaining('필수: 이름, 이메일, 비밀번호'), findsOneWidget);
    });
  });
}
