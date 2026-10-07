import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/app.dart';

void main() {
  testWidgets('앱이 시작되면 첫 화면이 표시된다', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.text('MOAMOA'), findsOneWidget);
  });
}
