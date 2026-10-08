import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/app/router/app_router.dart';
import 'package:moamoa/features/group/domain/entities/group_role.dart';
import 'package:moamoa/features/group/presentation/group_routes.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import '../fake_group_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final loader = FontLoader('Pretendard')
      ..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'));
    await loader.load();
    for (final name in [
      'close',
      'back',
      'users',
      'groups',
      'bell',
      'user',
      'plus',
      'header_plus',
      'chevron',
      'ticket',
      'check',
    ]) {
      await SvgAssetLoader('assets/group/$name.svg').loadBytes(null);
    }
  });
  for (final size in [const Size(393, 852), const Size(320, 568)]) {
    testWidgets('생성·가입·목록·초대 화면이 ${size.width} 폭에서 잘리지 않는다', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repository = FakeGroupRepository();
      final router = GoRouter(initialLocation: '/groups', routes: groupRoutes);
      final container = ProviderContainer(
        overrides: [
          groupRepositoryProvider.overrideWithValue(repository),
          appRouterProvider.overrideWithValue(router),
        ],
      );
      addTearDown(container.dispose);
      addTearDown(router.dispose);
      final boundary = GlobalKey();
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: RepaintBoundary(key: boundary, child: const App()),
        ),
      );
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'empty', size);
      router.go('/groups/create');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), '스터디 모아');
      await _capture(tester, boundary, 'create-profile', size);
      await tester.tap(find.text('다음'));
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'create-info', size);
      await tester.tap(find.text('수정'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<TextFormField>(find.byType(TextFormField))
            .controller!
            .text,
        '스터디 모아',
      );
      router.go('/groups/join');
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'join', size);
      repository.groups = [makeGroup(GroupRole.admin)];
      await container.read(groupProvider.notifier).selectGroup('g1');
      router.go('/groups/created');
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'created', size);
      router.go('/groups/invite');
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'invite', size);
      router.go('/groups');
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'list', size);
      await tester.tap(find.byTooltip('모임 추가'));
      await tester.pumpAndSettle();
      await _capture(tester, boundary, 'add-sheet', size);
    });
  }
}

Future<void> _capture(
  WidgetTester tester,
  GlobalKey key,
  String name,
  Size size,
) async {
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull, reason: '$name layout');
  const directory = String.fromEnvironment('GROUP_SCREENSHOTS');
  if (directory.isEmpty) return;
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    await Directory(directory).create(recursive: true);
    await File(
      '$directory/$name-${size.width.toInt()}.png',
    ).writeAsBytes(bytes!.buffer.asUint8List());
    image.dispose();
  });
}
