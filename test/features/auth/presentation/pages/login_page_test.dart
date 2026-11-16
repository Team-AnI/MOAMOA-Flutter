import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/auth_routes.dart';
import 'package:moamoa/features/auth/presentation/pages/login_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(LoginPage, () {
    late FakeAuthRepository repository;

    Future<void> openLogin(
      WidgetTester tester, {
      AuthSessionStatus initialStatus = AuthSessionStatus.unauthorized,
    }) async {
      // 아래 버튼 바에 회원가입 링크가 있어 폰 크기(393x852)로 띄웁니다.
      tester.view.physicalSize = const Size(393, 852);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authRepositoryProvider.overrideWithValue(repository),
            initialAuthStatusProvider.overrideWithValue(initialStatus),
          ],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: '/login',
              routes: authRoutes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> enterAndSubmit(
      WidgetTester tester, {
      required String email,
      required String password,
    }) async {
      await tester.enterText(find.byType(TextField).at(0), email);
      await tester.enterText(find.byType(TextField).at(1), password);
      await tester.tap(find.text('로그인'));
      await tester.pump();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('이메일과 비밀번호로 로그인을 요청한다', (tester) async {
      await openLogin(tester);

      await enterAndSubmit(
        tester,
        email: 'moa@example.com',
        password: 'moamoa123',
      );
      await tester.pumpAndSettle();

      expect(repository.logins, [
        (email: 'moa@example.com', password: 'moamoa123'),
      ]);
    });

    testWidgets('비밀번호 칸에서 키보드의 완료를 누르면 로그인을 요청한다', (tester) async {
      await openLogin(tester);
      await tester.enterText(find.byType(TextField).at(0), 'moa@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'moamoa123');

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(repository.logins, [
        (email: 'moa@example.com', password: 'moamoa123'),
      ]);
    });

    testWidgets('이메일 형식이 다르면 형식이 다르다고 안내한다', (tester) async {
      await openLogin(tester);

      await enterAndSubmit(tester, email: 'moa', password: 'moamoa123');

      expect(find.text('올바른 이메일 형식이 아니에요.'), findsOneWidget);
      expect(repository.logins, isEmpty);
    });

    testWidgets('비밀번호를 비운 채 누르면 비밀번호를 입력하라고 안내한다', (tester) async {
      await openLogin(tester);

      await enterAndSubmit(tester, email: 'moa@example.com', password: '');

      expect(find.text('비밀번호를 입력해주세요.'), findsOneWidget);
      expect(repository.logins, isEmpty);
    });

    testWidgets('서버 문구 없이 401 이면 이메일 또는 비밀번호를 확인하라고 안내한다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.unauthorized);
      await openLogin(tester);

      await enterAndSubmit(
        tester,
        email: 'moa@example.com',
        password: 'wrong123',
      );
      await tester.pumpAndSettle();

      expect(find.text('이메일 또는 비밀번호를 확인해 주세요.'), findsOneWidget);
    });

    testWidgets('서버 문구가 있으면 그 문구로 안내한다', (tester) async {
      repository.error = const ApiException(
        code: ApiErrorCode.unauthorized,
        message: '이메일 또는 비밀번호가 올바르지 않습니다.',
      );
      await openLogin(tester);

      await enterAndSubmit(
        tester,
        email: 'moa@example.com',
        password: 'wrong123',
      );
      await tester.pumpAndSettle();

      expect(find.text('이메일 또는 비밀번호가 올바르지 않습니다.'), findsOneWidget);
    });

    testWidgets('로그인하는 중에는 버튼을 비활성화한다', (tester) async {
      repository.gate = Completer<void>();
      await openLogin(tester);

      await enterAndSubmit(
        tester,
        email: 'moa@example.com',
        password: 'moamoa123',
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
      repository.gate!.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('다시 로그인해야 할 때는 로그인이 만료되었다고 안내한다', (tester) async {
      await openLogin(tester, initialStatus: AuthSessionStatus.expired);

      expect(find.text('로그인이 만료되었어요. 다시 로그인해 주세요.'), findsOneWidget);
    });

    testWidgets('처음 로그인할 때는 만료 안내를 보여주지 않는다', (tester) async {
      await openLogin(tester);

      expect(find.text('로그인이 만료되었어요. 다시 로그인해 주세요.'), findsNothing);
    });

    testWidgets('비밀번호를 잊으셨나요를 누르면 비밀번호 찾기 화면으로 간다', (tester) async {
      await openLogin(tester);

      await tester.tap(find.text('비밀번호를 잊으셨나요?'));
      await tester.pumpAndSettle();

      expect(find.text('비밀번호를 잊으셨나요?'), findsOneWidget);
      expect(find.text('재설정 링크 보내기'), findsOneWidget);
    });

    testWidgets('회원가입을 누르면 회원가입 화면으로 간다', (tester) async {
      await openLogin(tester);

      await tester.tap(find.text('회원가입'));
      await tester.pumpAndSettle();

      expect(find.text('이름과 이메일만 있으면 시작할 수 있어요.'), findsOneWidget);
    });

    testWidgets('비밀번호 찾기에서 뒤로 가면 로그인 화면으로 돌아온다', (tester) async {
      await openLogin(tester);
      await tester.tap(find.text('비밀번호를 잊으셨나요?'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text('흩어진 모임 운영을 한 곳에서'), findsOneWidget);
    });
  });
}
