import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/app/router/app_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/pages/withdrawal_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(WithdrawalPage, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    /// 로그인 여부에 따라 화면을 옮기는 실제 앱 라우터로 탈퇴 안내를 엽니다.
    Future<void> openWithdrawal(WidgetTester tester) async {
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
        UncontrolledProviderScope(container: container, child: const App()),
      );
      container.read(appRouterProvider).go('/me/withdrawal');
      await tester.pumpAndSettle();
    }

    Future<void> checkAndOpenDialog(WidgetTester tester) async {
      await tester.tap(find.text('안내 내용을 모두 확인했어요'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, '회원 탈퇴'));
      await tester.pumpAndSettle();
    }

    Future<void> submitPassword(WidgetTester tester, String password) async {
      await tester.enterText(find.byType(TextField), password);
      await tester.tap(find.text('탈퇴하기'));
      await tester.pumpAndSettle();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('안내를 확인하지 않은 채 회원 탈퇴를 누르면 확인하라고 안내한다', (tester) async {
      await openWithdrawal(tester);

      await tester.tap(find.widgetWithText(FilledButton, '회원 탈퇴'));
      await tester.pumpAndSettle();

      expect(find.text('안내 내용을 확인했다고 체크해 주세요.'), findsOneWidget);
      expect(find.text('정말 탈퇴할까요?'), findsNothing);
    });

    testWidgets('안내를 확인한 뒤 회원 탈퇴를 누르면 비밀번호를 묻는다', (tester) async {
      await openWithdrawal(tester);

      await checkAndOpenDialog(tester);

      expect(find.text('정말 탈퇴할까요?'), findsOneWidget);
      expect(find.text('본인 확인을 위해 비밀번호를 입력해 주세요.'), findsOneWidget);
    });

    testWidgets('비밀번호를 비운 채 탈퇴하기를 누르면 입력하라고 안내한다', (tester) async {
      await openWithdrawal(tester);
      await checkAndOpenDialog(tester);

      await submitPassword(tester, '');

      expect(find.text('비밀번호를 입력해주세요.'), findsOneWidget);
      expect(repository.withdrawals, isEmpty);
    });

    testWidgets('비밀번호가 틀리면 팝업에서 비밀번호를 확인하라고 안내한다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.validation);
      await openWithdrawal(tester);
      await checkAndOpenDialog(tester);

      await submitPassword(tester, 'wrong123');

      expect(find.text('정말 탈퇴할까요?'), findsOneWidget);
      expect(find.text('비밀번호를 확인해 주세요.'), findsOneWidget);
    });

    testWidgets('비밀번호가 틀린 뒤 팝업을 닫았다 다시 열면 안내 없이 연다', (tester) async {
      repository.error = const ApiException(code: ApiErrorCode.validation);
      await openWithdrawal(tester);
      await checkAndOpenDialog(tester);
      await submitPassword(tester, 'wrong123');

      await tester.tap(find.text('취소'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, '회원 탈퇴'));
      await tester.pumpAndSettle();

      expect(find.text('정말 탈퇴할까요?'), findsOneWidget);
      expect(find.text('비밀번호를 확인해 주세요.'), findsNothing);
    });

    testWidgets('탈퇴할 수 없으면 팝업을 닫고 이유를 안내한다', (tester) async {
      repository.error = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
      );
      await openWithdrawal(tester);
      await checkAndOpenDialog(tester);

      await submitPassword(tester, 'moamoa123');

      expect(find.text('정말 탈퇴할까요?'), findsNothing);
      expect(
        find.text('혼자 관리자인 모임이나 납부하지 않은 정산이 있으면 탈퇴할 수 없어요.'),
        findsOneWidget,
      );
    });

    testWidgets('탈퇴하면 완료 화면으로 이동한다', (tester) async {
      await openWithdrawal(tester);
      await checkAndOpenDialog(tester);

      await submitPassword(tester, 'moamoa123');

      expect(repository.withdrawals, ['moamoa123']);
      expect(find.text('탈퇴가 완료됐어요'), findsOneWidget);
      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    testWidgets('완료 화면에서 처음으로를 누르면 로그인 화면으로 간다', (tester) async {
      await openWithdrawal(tester);
      await checkAndOpenDialog(tester);
      await submitPassword(tester, 'moamoa123');

      await tester.tap(find.text('처음으로'));
      await tester.pumpAndSettle();

      expect(find.text('흩어진 모임 운영을 한 곳에서'), findsOneWidget);
    });
  });
}
