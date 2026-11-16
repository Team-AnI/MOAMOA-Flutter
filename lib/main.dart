import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';

Future<void> main() async {
  // 웹 주소에서 # 를 뺍니다. (/#/reset-password → /reset-password) 웹이 아니면 아무 일도 하지 않습니다.
  usePathUrlStrategy();
  final overrides = await bootstrap();
  runApp(ProviderScope(overrides: overrides, child: const App()));
}
