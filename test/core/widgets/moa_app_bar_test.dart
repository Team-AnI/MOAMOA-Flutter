import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

void main() {
  testWidgets('MoaAppBar 는 AppBar 를 상속한다', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(appBar: MoaAppBar())));

    expect(tester.widget(find.byType(MoaAppBar)), isA<AppBar>());
  });

  group('MoaAppBar 제목과 닫기 버튼', () {
    testWidgets('제목을 주면 가운데에 보여준다', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(appBar: MoaAppBar(title: '일정 수정')),
        ),
      );

      expect(find.text('일정 수정'), findsOneWidget);
      final center = tester.getCenter(find.text('일정 수정')).dx;
      expect(
        center,
        closeTo(
          tester.view.physicalSize.width / 2 / tester.view.devicePixelRatio,
          1,
        ),
      );
    });

    testWidgets('제목을 주지 않으면 제목 글자가 없다', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(appBar: MoaAppBar())));

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('닫기 모드에서도 왼쪽 버튼을 누르면 이전 화면으로 돌아간다', (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => context.push('/edit'),
                  child: const Text('이동'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/edit',
            builder: (_, _) => Scaffold(
              appBar: MoaAppBar(title: '일정 수정', showClose: true),
              body: const Text('수정'),
            ),
          ),
        ],
      );
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.tap(find.text('이동'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text('수정'), findsNothing);
      expect(find.text('이동'), findsOneWidget);
    });
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
