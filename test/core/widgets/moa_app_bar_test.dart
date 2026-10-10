import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

void main() {
  testWidgets('MoaAppBar 는 AppBar 를 상속한다', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(appBar: MoaAppBar())));

    expect(tester.widget(find.byType(MoaAppBar)), isA<AppBar>());
  });

  testWidgets('뒤로가기 버튼을 누르면 이전 화면으로 돌아간다', (tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => context.push('/detail'),
                child: const Text('이동'),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/detail',
          builder: (_, _) =>
              Scaffold(appBar: MoaAppBar(), body: const Text('상세')),
        ),
      ],
    );
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.tap(find.text('이동'));
    await tester.pumpAndSettle();
    expect(find.text('상세'), findsOneWidget);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text('상세'), findsNothing);
    expect(find.text('이동'), findsOneWidget);
  });
}
