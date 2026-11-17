import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/app/router/app_router.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../features/auth/fakes/fake_auth_repository.dart';

void main() {
  group(App, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    /// 앱 시작 때 로그인 상태가 [status] 인 앱을 띄웁니다.
    Future<void> pumpApp(WidgetTester tester, AuthSessionStatus status) async {
      container = ProviderContainer.test(
        overrides: [
          initialAuthStatusProvider.overrideWithValue(status),
          authRepositoryProvider.overrideWithValue(repository),
        ],
        retry: (_, _) => null,
      );
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const App()),
      );
      await tester.pumpAndSettle();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('로그인한 상태로 시작하면 첫 화면이 표시된다', (tester) async {
      await pumpApp(tester, AuthSessionStatus.authenticated);

      expect(find.text('MOAMOA'), findsOneWidget);
    });

    testWidgets('디버깅용 임시 진입 버튼을 표시하지 않는다', (tester) async {
      await pumpApp(tester, AuthSessionStatus.authenticated);

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('로그인하지 않은 상태로 시작하면 로그인 화면이 표시된다', (tester) async {
      await pumpApp(tester, AuthSessionStatus.unauthorized);

      expect(find.text('흩어진 모임 운영을 한 곳에서'), findsOneWidget);
    });

    testWidgets('로그인하면 첫 화면으로 이동한다', (tester) async {
      await pumpApp(tester, AuthSessionStatus.unauthorized);

      await tester.enterText(find.byType(TextField).at(0), 'moa@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'moamoa123');
      await tester.tap(find.text('로그인'));
      await tester.pumpAndSettle();

      expect(find.text('MOAMOA'), findsOneWidget);
    });

    testWidgets('사용하는 중에 재발급까지 실패하면 로그인 화면으로 이동해 만료를 안내한다', (tester) async {
      await pumpApp(tester, AuthSessionStatus.authenticated);

      container.read(authSessionProvider.notifier).expire();
      await tester.pumpAndSettle();

      expect(find.text('로그인이 만료되었어요. 다시 로그인해 주세요.'), findsOneWidget);
    });

    testWidgets('로그인한 기기에서 비밀번호를 바꾼 뒤 로그인하러 가기를 누르면 로그인 화면이 표시된다', (
      tester,
    ) async {
      await pumpApp(tester, AuthSessionStatus.authenticated);
      container.read(appRouterProvider).go('/reset-password?token=abc');
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'moamoa123');
      await tester.enterText(find.byType(TextField).at(1), 'moamoa123');
      await tester.tap(find.text('비밀번호 변경하기'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('로그인하러 가기'));
      await tester.pumpAndSettle();

      expect(find.text('흩어진 모임 운영을 한 곳에서'), findsOneWidget);
    });
  });
}
