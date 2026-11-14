import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/presentation/auth_routes.dart';
import 'package:moamoa/features/auth/presentation/pages/reset_password_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ResetPasswordPage, () {
    late FakeAuthRepository repository;

    /// 메일 링크 주소 [location] 으로 화면을 엽니다.
    Future<void> openLink(WidgetTester tester, String location) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repository)],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: location,
              routes: authRoutes,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> enterAndSubmit(
      WidgetTester tester, {
      required String password,
      required String confirm,
    }) async {
      await tester.enterText(find.byType(TextField).at(0), password);
      await tester.enterText(find.byType(TextField).at(1), confirm);
      await tester.tap(find.text('비밀번호 변경하기'));
      await tester.pump();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('링크의 token 과 새 비밀번호로 변경을 요청한다', (tester) async {
      await openLink(tester, '/reset-password?token=abc');

      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa123');
      await tester.pumpAndSettle();

      expect(repository.resets, [(token: 'abc', newPassword: 'moamoa123')]);
    });

    testWidgets('비밀번호를 바꾸면 앱에서 다시 로그인하라고 안내한다', (tester) async {
      await openLink(tester, '/reset-password?token=abc');

      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa123');
      await tester.pumpAndSettle();

      expect(find.text('비밀번호가 변경되었습니다. 앱에서 다시 로그인해 주세요.'), findsOneWidget);
    });

    testWidgets('비밀번호 규칙에 맞지 않으면 규칙을 안내한다', (tester) async {
      await openLink(tester, '/reset-password?token=abc');

      await enterAndSubmit(tester, password: 'moamoa', confirm: 'moamoa');

      expect(find.text('8~72자로 입력해주세요.'), findsOneWidget);
      expect(repository.resets, isEmpty);
    });

    testWidgets('비밀번호 확인이 다르면 일치하지 않는다고 안내한다', (tester) async {
      await openLink(tester, '/reset-password?token=abc');

      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa124');

      expect(find.text('비밀번호가 일치하지 않아요.'), findsOneWidget);
      expect(repository.resets, isEmpty);
    });

    testWidgets('확인을 맞게 고치면 일치 안내가 사라진다', (tester) async {
      await openLink(tester, '/reset-password?token=abc');
      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa124');

      await tester.enterText(find.byType(TextField).at(1), 'moamoa123');
      await tester.pump();

      expect(find.text('비밀번호가 일치하지 않아요.'), findsNothing);
    });

    testWidgets('링크가 만료되면 다시 요청하라고 안내한다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.validation);
      await openLink(tester, '/reset-password?token=old');

      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa123');
      await tester.pumpAndSettle();

      expect(find.text('링크가 만료되었습니다. 다시 요청해 주세요.'), findsOneWidget);
      // 화면으로 안내하므로 스낵바를 겹쳐 띄우지 않습니다.
      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets('링크가 만료된 뒤 비밀번호 찾기를 누르면 비밀번호 찾기 화면으로 간다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.validation);
      await openLink(tester, '/reset-password?token=old');
      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa123');
      await tester.pumpAndSettle();

      await tester.tap(find.text('비밀번호 찾기'));
      await tester.pumpAndSettle();

      expect(find.text('비밀번호를 잊으셨나요?'), findsOneWidget);
    });

    testWidgets('네트워크 오류는 입력한 내용을 두고 스낵바로 안내한다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.network);
      await openLink(tester, '/reset-password?token=abc');

      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa123');
      await tester.pumpAndSettle();

      expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
      expect(find.text('비밀번호 변경하기'), findsOneWidget);
    });

    testWidgets('주소에 token 이 없으면 링크가 올바르지 않다고 안내한다', (tester) async {
      await openLink(tester, '/reset-password');

      expect(find.text('링크가 올바르지 않아요. 비밀번호 찾기를 다시 요청해 주세요.'), findsOneWidget);
    });

    testWidgets('변경하는 중에는 버튼을 비활성화한다', (tester) async {
      repository.gate = Completer<void>();
      await openLink(tester, '/reset-password?token=abc');

      await enterAndSubmit(tester, password: 'moamoa123', confirm: 'moamoa123');

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
      repository.gate!.complete();
      await tester.pumpAndSettle();
    });
  });
}
