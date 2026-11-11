import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ForgotPasswordPage, () {
    late FakeAuthRepository repository;

    Future<void> pumpPage(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repository)],
          retry: (_, _) => null,
          child: const MaterialApp(home: ForgotPasswordPage()),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> enterEmailAndSend(WidgetTester tester, String email) async {
      await tester.enterText(find.byType(TextField), email);
      await tester.tap(find.text('재설정 링크 보내기'));
      await tester.pump();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('링크 유효 시간을 명세대로 10분으로 안내한다', (tester) async {
      await pumpPage(tester);

      expect(find.textContaining('링크는 10분 동안만 쓸 수 있어요.'), findsOneWidget);
    });

    testWidgets('이메일을 비운 채 보내면 이메일을 입력하라고 안내한다', (tester) async {
      await pumpPage(tester);

      await enterEmailAndSend(tester, '');

      expect(find.text('이메일을 입력해주세요.'), findsOneWidget);
      expect(repository.requestedEmails, isEmpty);
    });

    testWidgets('이메일 형식이 다르면 형식이 다르다고 안내한다', (tester) async {
      await pumpPage(tester);

      await enterEmailAndSend(tester, 'moa');

      expect(find.text('올바른 이메일 형식이 아니에요.'), findsOneWidget);
      expect(repository.requestedEmails, isEmpty);
    });

    testWidgets('형식 안내 뒤 이메일을 고치면 안내가 사라진다', (tester) async {
      await pumpPage(tester);
      await enterEmailAndSend(tester, 'moa');

      await tester.enterText(find.byType(TextField), 'moa@example.com');
      await tester.pump();

      expect(find.text('올바른 이메일 형식이 아니에요.'), findsNothing);
    });

    testWidgets('이메일을 보내면 재설정 링크를 보냈다고 안내한다', (tester) async {
      await pumpPage(tester);

      await enterEmailAndSend(tester, 'moa@example.com');
      await tester.pumpAndSettle();

      expect(repository.requestedEmails, ['moa@example.com']);
      expect(find.text('재설정 링크를 보냈어요. 메일함을 확인해 주세요.'), findsOneWidget);
    });

    testWidgets('요청에 실패하면 서버 문구로 안내한다', (tester) async {
      repository.error = const ApiException(
        code: ApiErrorCode.validation,
        message: '잠시 후 다시 시도해주세요.',
      );
      await pumpPage(tester);

      await enterEmailAndSend(tester, 'moa@example.com');
      await tester.pumpAndSettle();

      expect(find.text('잠시 후 다시 시도해주세요.'), findsOneWidget);
    });

    testWidgets('보내는 중에는 버튼을 누를 수 없다', (tester) async {
      repository.gate = Completer<void>();
      await pumpPage(tester);

      await enterEmailAndSend(tester, 'moa@example.com');

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
      repository.gate!.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('보내는 중에 다시 눌러도 한 번만 요청한다', (tester) async {
      repository.gate = Completer<void>();
      await pumpPage(tester);

      await enterEmailAndSend(tester, 'moa@example.com');
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(repository.requestedEmails, hasLength(1));
      repository.gate!.complete();
      await tester.pumpAndSettle();
    });
  });
}
