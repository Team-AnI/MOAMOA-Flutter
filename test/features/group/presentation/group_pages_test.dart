import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../fake_group_repository.dart';
import 'package:moamoa/features/group/presentation/widgets/group_list_section.dart';

Future<void> openGroups(
  WidgetTester tester,
  FakeGroupRepository repository, {
  String? userName,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        groupRepositoryProvider.overrideWithValue(repository),
        groupCurrentUserNameProvider.overrideWithValue(userName),
      ],
      child: const App(),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('내 모임'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('생성 안내와 계정 이름을 표시하고 미지원 가입 방식은 선택할 수 없다', (tester) async {
    await openGroups(tester, FakeGroupRepository(), userName: '조성은');
    await tester.tap(find.text('모임 만들기'));
    await tester.pumpAndSettle();
    expect(find.text('앨범에서 선택'), findsNothing);
    await tester.tap(find.byTooltip('모임 사진 선택'));
    await tester.pumpAndSettle();
    expect(find.text('모임 사진'), findsOneWidget);
    expect(find.text('앨범에서 선택'), findsOneWidget);
    expect(find.text('사진 찍기'), findsOneWidget);
    await tester.tap(find.text('기본 이미지로 바꾸기'));
    await tester.pumpAndSettle();
    expect(find.text('모임 사진'), findsNothing);
    expect(find.text('나중에 모임 설정에서 바꿀 수 있어요.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), '스터디 모아');
    await tester.pump();
    expect(find.text('6/20'), findsOneWidget);
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(find.text('관리자 · 조성은'), findsOneWidget);
    await tester.tap(find.text('승인 후 가입'));
    await tester.pumpAndSettle();
    expect(find.text('초대 코드를 입력하면 바로 들어올 수 있어요.'), findsOneWidget);
    expect(find.text('가입 요청을 관리자가 확인한 뒤에 들어올 수 있어요.'), findsNothing);
  });

  testWidgets('모임이 없으면 생성과 가입 진입 버튼을 표시한다', (tester) async {
    await openGroups(tester, FakeGroupRepository());
    expect(find.textContaining('아직 참여한 모임이 없어요'), findsOneWidget);
    expect(find.text('모임 만들기'), findsOneWidget);
    expect(find.text('초대 코드로 가입'), findsOneWidget);
  });

  testWidgets('입력 검증, 중복 탭 방지, 생성 성공 후 관리자 홈으로 이동', (tester) async {
    final repository = FakeGroupRepository();
    await openGroups(tester, repository);
    await tester.tap(find.text('모임 만들기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(repository.createCalls, 0);
    await tester.enterText(find.byType(TextFormField), '모임');
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '소개');
    await tester.tap(find.widgetWithText(FilledButton, '모임 만들기'));
    await tester.pump();
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, '처리 중…'),
    );
    expect(button.onPressed, isNull);
    expect(repository.createCalls, 1);
    repository.pendingCreate.complete(makeGroup(MemberRole.admin));
    await tester.pumpAndSettle();
    expect(find.text('모임이 만들어졌어요'), findsOneWidget);
    expect(find.text('링크 공유'), findsOneWidget);
    expect(find.text('첫 공지 쓰기'), findsOneWidget);
    expect(find.text('첫 일정 만들기'), findsOneWidget);
    expect(find.text('CODE'), findsOneWidget);
    String? copiedText;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copiedText = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await tester.tap(find.text('코드 복사'));
    await tester.pumpAndSettle();
    expect(copiedText, 'CODE');
    await tester.tap(find.text('모임 홈으로'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('모임 설정'));
    await tester.pumpAndSettle();
    expect(find.text('초대 코드 확인'), findsOneWidget);
    await tester.tap(find.text('초대 코드 확인'));
    await tester.pumpAndSettle();
    expect(find.text('CODE'), findsOneWidget);
  });

  testWidgets('이미 참여 중인 모임이면 기존 모임 목록 이동을 제공한다', (tester) async {
    final repository = FakeGroupRepository()
      ..joinFailure = const GroupFailure(GroupFailureReason.alreadyJoined)
      ..groups = [makeGroup(MemberRole.member)];
    await openGroups(tester, repository);
    if (repository.groups.isNotEmpty) {
      await tester.tap(find.byTooltip('모임 추가'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('초대 코드로 가입'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'CODE');
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();
    expect(find.text('이미 참여 중인 모임입니다.'), findsOneWidget);
    await tester.tap(find.text('기존 모임 목록으로 이동'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(GroupListSection),
        matching: find.text('모임'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byTooltip('내 모임 목록'), findsOneWidget);
    expect(find.text('초대 코드 확인'), findsNothing);
  });

  testWidgets('유효하지 않은 코드 오류를 표시하고 성공 시 가입 완료 화면으로 이동', (tester) async {
    final repository = FakeGroupRepository()
      ..joinFailure = const GroupFailure(GroupFailureReason.invalidCode);
    await openGroups(tester, repository);
    if (repository.groups.isNotEmpty) {
      await tester.tap(find.byTooltip('모임 추가'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('초대 코드로 가입'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'CODE');
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();
    expect(find.text('유효하지 않은 초대 코드입니다.'), findsOneWidget);
    repository.joinFailure = null;
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();
    expect(find.text('모임에 가입했어요'), findsOneWidget);
    expect(find.text('초대 코드 확인'), findsNothing);
  });
}
