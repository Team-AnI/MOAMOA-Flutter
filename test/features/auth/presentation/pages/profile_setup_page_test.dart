import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/presentation/pages/profile_setup_page.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ProfileSetupPage, () {
    late FakeAuthRepository repository;

    Future<void> openProfileSetup(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [authRepositoryProvider.overrideWithValue(repository)],
          retry: (_, _) => null,
          child: MaterialApp.router(
            routerConfig: GoRouter(
              initialLocation: '/profile',
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const Text('첫 화면'),
                ),
                GoRoute(
                  path: '/profile',
                  builder: (context, state) =>
                      const ProfileSetupPage(userName: '이서연'),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    setUp(() => repository = FakeAuthRepository());

    testWidgets('색을 고르고 시작하기를 누르면 그 색으로 저장을 요청한다', (tester) async {
      await openProfileSetup(tester);

      await tester.tap(find.bySemanticsLabel('검정'));
      await tester.pump();
      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle();

      expect(repository.profileColors, [ProfileColor.dark]);
    });

    testWidgets('저장하면 첫 화면으로 이동한다', (tester) async {
      await openProfileSetup(tester);

      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('첫 화면'), findsOneWidget);
    });

    testWidgets('나중에 할게요를 누르면 저장 없이 첫 화면으로 이동한다', (tester) async {
      await openProfileSetup(tester);

      await tester.tap(find.text('나중에 할게요'));
      await tester.pumpAndSettle();

      expect(find.text('첫 화면'), findsOneWidget);
      expect(repository.profileColors, isEmpty);
    });

    testWidgets('저장에 실패하면 프로필 설정 화면에서 서버 문구로 안내한다', (tester) async {
      repository.error = const ApiException(
        code: ApiErrorCode.unknown,
        message: '잠시 후 다시 시도해 주세요.',
      );
      await openProfileSetup(tester);

      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle();

      expect(find.text('잠시 후 다시 시도해 주세요.'), findsOneWidget);
      expect(find.text('프로필을 정해요'), findsOneWidget);
    });

    testWidgets('저장하는 중에는 시작하기 버튼을 비활성화한다', (tester) async {
      repository.gate = Completer<void>();
      await openProfileSetup(tester);

      await tester.tap(find.text('시작하기'));
      await tester.pump();

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
      repository.gate!.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('저장하는 중에는 나중에 할게요를 눌러도 첫 화면으로 넘어가지 않는다', (tester) async {
      repository.gate = Completer<void>();
      await openProfileSetup(tester);
      await tester.tap(find.text('시작하기'));
      await tester.pump();

      await tester.tap(find.text('나중에 할게요'));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('첫 화면'), findsNothing);
      repository.gate!.complete();
      await tester.pumpAndSettle();
    });

    testWidgets('폭이 320 인 화면에서도 색 고르기가 넘치지 않는다', (tester) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await openProfileSetup(tester);

      expect(tester.takeException(), isNull);
      expect(find.bySemanticsLabel('검정'), findsOneWidget);
    });

    testWidgets('고른 색을 선택된 상태로 알린다', (tester) async {
      await openProfileSetup(tester);

      await tester.tap(find.bySemanticsLabel('회색'));
      await tester.pump();

      expect(
        tester.getSemantics(find.bySemanticsLabel('회색')),
        matchesSemantics(
          label: '회색',
          isButton: true,
          hasSelectedState: true,
          isSelected: true,
          hasTapAction: true,
        ),
      );
    });
  });
}
