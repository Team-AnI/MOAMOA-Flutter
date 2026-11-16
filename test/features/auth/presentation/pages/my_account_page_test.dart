import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/auth_routes.dart';
import 'package:moamoa/features/auth/presentation/pages/my_account_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(MyAccountPage, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    Future<void> openMyAccount(WidgetTester tester) async {
      tester.view.physicalSize = const Size(393, 852);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      container = ProviderContainer.test(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          initialAuthStatusProvider.overrideWithValue(
            AuthSessionStatus.authenticated,
          ),
        ],
        retry: (_, _) => null,
      );
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(
            routerConfig: GoRouter(initialLocation: '/me', routes: authRoutes),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    Future<void> tapLogout(WidgetTester tester) async {
      await tester.tap(find.text('로그아웃'));
      await tester.pumpAndSettle();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('내 이름과 이메일을 보여준다', (tester) async {
      await openMyAccount(tester);

      expect(find.text('이서연'), findsOneWidget);
      expect(find.text('moa@example.com'), findsOneWidget);
    });

    testWidgets('불러오지 못하면 다시 시도를 누를 수 있게 안내한다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.network);
      await openMyAccount(tester);

      expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
      expect(find.text('다시 시도'), findsOneWidget);
    });

    testWidgets('다시 시도를 누르면 내 정보를 다시 불러온다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.network);
      await openMyAccount(tester);
      repository.error = null;

      await tester.tap(find.text('다시 시도'));
      await tester.pumpAndSettle();

      expect(find.text('이서연'), findsOneWidget);
    });

    testWidgets('이용약관을 누르면 이용약관 전문을 보여준다', (tester) async {
      await openMyAccount(tester);

      await tester.tap(find.text('이용약관'));
      await tester.pumpAndSettle();

      expect(find.textContaining('제1조 (목적)'), findsOneWidget);
    });

    testWidgets('편집을 누르면 프로필 편집 화면으로 간다', (tester) async {
      await openMyAccount(tester);

      await tester.tap(find.text('편집'));
      await tester.pumpAndSettle();

      expect(find.text('프로필 편집'), findsOneWidget);
    });

    testWidgets('로그아웃을 누르면 로그아웃할지 묻는다', (tester) async {
      await openMyAccount(tester);

      await tapLogout(tester);

      expect(find.text('로그아웃할까요?'), findsOneWidget);
    });

    testWidgets('로그아웃을 확인하면 로그인하지 않은 상태가 된다', (tester) async {
      await openMyAccount(tester);
      await tapLogout(tester);

      await tester.tap(find.text('로그아웃').last);
      await tester.pumpAndSettle();

      expect(repository.logouts, 1);
      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    testWidgets('로그아웃을 취소하면 로그아웃하지 않는다', (tester) async {
      await openMyAccount(tester);
      await tapLogout(tester);

      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();

      expect(repository.logouts, 0);
    });
  });
}
