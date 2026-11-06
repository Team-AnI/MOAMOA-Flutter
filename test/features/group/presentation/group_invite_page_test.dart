import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/app/router/app_router.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/group_routes.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../fake_group_repository.dart';

void main() {
  group('GroupInvitePage', () {
    for (final entry in {
      '스터디 모아': '스터디 모아가 만들어졌어요',
      '독서 모임': '독서 모임이 만들어졌어요',
    }.entries) {
      testWidgets('생성한 모임 이름이 ${entry.key}이면 ${entry.value}를 표시한다', (
        tester,
      ) async {
        final original = makeGroup(MemberRole.admin);
        final current = original.copyWith(
          group: original.group.copyWith(name: entry.key),
        );
        final repository = FakeGroupRepository()..groups = [current];
        final router = GoRouter(
          initialLocation: '/groups/created',
          routes: groupRoutes,
        );
        addTearDown(router.dispose);
        final container = ProviderContainer(
          overrides: [
            groupRepositoryProvider.overrideWithValue(repository),
            appRouterProvider.overrideWithValue(router),
          ],
        );
        addTearDown(container.dispose);
        await container
            .read(groupProvider.notifier)
            .selectGroup(current.group.id);
        await tester.pumpWidget(
          UncontrolledProviderScope(container: container, child: const App()),
        );
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
        expect(find.text('CODE'), findsOneWidget);
      });
    }
  });
}
