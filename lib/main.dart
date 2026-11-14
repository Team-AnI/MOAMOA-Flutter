import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';

Future<void> main() async {
  final overrides = await bootstrap();
  runApp(ProviderScope(overrides: overrides, child: const App()));
}
