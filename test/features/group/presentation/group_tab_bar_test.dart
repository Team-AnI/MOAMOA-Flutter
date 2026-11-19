import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/group/presentation/widgets/group_tab_bar.dart';

void main() {
  group(GroupTabBar, () {
    Future<void> openTabBar(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) =>
                    const Scaffold(bottomNavigationBar: GroupTabBar()),
              ),
              GoRoute(
                path: '/me',
                builder: (context, state) => const Text('내 계정 화면'),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('내 계정 탭을 누르면 내 계정 화면을 연다', (tester) async {
      await openTabBar(tester);

      await tester.tap(find.text('내 계정'));
      await tester.pumpAndSettle();

      expect(find.text('내 계정 화면'), findsOneWidget);
    });

    testWidgets('캘린더 탭은 아직 연결된 화면이 없어 눌러도 그대로다', (tester) async {
      await openTabBar(tester);

      await tester.tap(find.text('캘린더'));
      await tester.pumpAndSettle();

      expect(find.text('내 계정 화면'), findsNothing);
    });
  });
}
