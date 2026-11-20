import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/group_member_profile.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_members_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_state.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_view_model.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedules.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_create_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_list_page.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';
import 'package:moamoa/features/settlement/presentation/settlement_routes.dart';
import 'package:moamoa/features/settlement/presentation/widgets/settlement_schedule_picker.dart';

import 'settlement_review_test_support.dart' as support;

class _Members extends GroupMembersViewModel {
  _Members() : super(groupId: 7);
  @override
  GroupMembersState build() => const GroupMembersState(
    hasLoaded: true,
    members: [
      GroupMemberProfile(memberId: 3, userName: '김모아', role: MemberRole.admin),
    ],
  );
}

class _Schedules extends GetSchedules {
  int calls = 0;
  bool failFirst = false;
  @override
  Future<List<Schedule>> call(GetSchedulesParams params) async {
    calls++;
    if (failFirst && calls == 1) throw Exception('offline');
    return [
      Schedule(id: 12, title: '11월 정기모임', startAt: DateTime(2026, 11, 20, 19)),
    ];
  }
}

class _Repository extends support.TestSettlementRepository {
  CreateSettlementInput? input;
  final created = Completer<int>();
  @override
  Future<int> create(CreateSettlementInput value) {
    input = value;
    return created.future;
  }

  @override
  Future<SettlementDetail> detail(int meetingId, int settlementId) async =>
      support.detail;

  @override
  Future<List<Settlement>> list(int meetingId) async => [];
}

Future<void> _open(
  WidgetTester tester,
  _Repository repo,
  _Schedules schedules, {
  double width = 393,
  GlobalKey? boundary,
}) async {
  tester.view.physicalSize = Size(width, 852);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final router = GoRouter(
    initialLocation: '/meetings/7/settlements/new',
    routes: settlementRoutes,
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        groupMyRoleProvider.overrideWith((ref, id) async => MemberRole.admin),
        groupMembersProvider(7).overrideWith(_Members.new),
        settlementRepositoryProvider.overrideWithValue(repo),
        getSchedulesProvider.overrideWithValue(schedules),
      ],
      child: RepaintBoundary(
        key: boundary,
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group(SettlementCreatePage, () {
    testWidgets('생성 주소로 직접 진입한 뒤 닫으면 정산 목록으로 돌아간다', (tester) async {
      await _open(tester, _Repository(), _Schedules());
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.byType(SettlementListPage), findsOneWidget);
      expect(find.text('정산 정보 등록'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('계좌 입력 시트를 연 뒤 원래 화면이 닫혀도 안전하다', (tester) async {
      final visible = ValueNotifier(true);
      addTearDown(visible.dispose);
      await support.pumpReviewPage(
        tester,
        const SettlementCreatePage(meetingId: 7),
        visible: visible,
      );
      await tapVisible(tester, find.text('받을 계좌 입력'));
      final fields = find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(TextFormField),
      );
      await tester.enterText(fields.at(0), '국민은행');
      await tester.enterText(fields.at(1), '1234');
      await tester.enterText(fields.at(2), '김모아');
      visible.value = false;
      await tester.pump();
      await tester.tap(find.text('입력 완료'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
    testWidgets('빈 계좌로 입력 완료를 누르면 시트에 필드별 오류를 표시한다', (tester) async {
      final repo = _Repository();
      await _open(tester, repo, _Schedules());
      await tapVisible(tester, find.text('받을 계좌 입력'));
      await tester.tap(find.text('입력 완료'));
      await tester.pumpAndSettle();
      expect(find.byType(BottomSheet), findsOneWidget);
      expect(find.text('은행을 입력해 주세요.'), findsOneWidget);
      expect(find.text('계좌번호를 입력해 주세요.'), findsOneWidget);
      expect(find.text('예금주를 입력해 주세요.'), findsOneWidget);
      expect(repo.input, isNull);
    });
    setUpAll(() async {
      await (FontLoader('Pretendard')
            ..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf')))
          .load();
      await (FontLoader(
        'MaterialIcons',
      )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    });
    for (final width in [393.0, 320.0]) {
      testWidgets('등록 ${width.toInt()}px: 일정·대상·계좌·기한을 선택해 올바른 생성 요청을 보낸다', (
        tester,
      ) async {
        final repo = _Repository();
        final schedules = _Schedules();
        final boundary = GlobalKey();
        await _open(tester, repo, schedules, width: width, boundary: boundary);
        expect(find.text('1인당 예상 금액'), findsNothing);
        await tester.tap(find.text('연결할 일정 선택 (선택)'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('11월 정기모임'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField).at(1), '30,001');
        await tapVisible(tester, find.text('0명 선택'));
        await tester.tap(find.text('김모아'));
        await tester.tap(find.text('선택 완료'));
        await tester.pumpAndSettle();
        await tapVisible(tester, find.text('받을 계좌 입력'));
        final sheet = find.byType(BottomSheet);
        final fields = find.descendant(
          of: sheet,
          matching: find.byType(TextFormField),
        );
        await tester.enterText(fields.at(0), '국민은행');
        await tester.enterText(fields.at(1), '1234');
        await tester.enterText(fields.at(2), '김모아');
        await tester.tap(find.text('입력 완료'));
        await tester.pumpAndSettle();
        await tapVisible(tester, find.text('날짜 선택'));
        final navigator = Navigator.of(
          tester.element(find.byType(DatePickerDialog)),
        );
        navigator.pop(DateTime(2026, 12, 1));
        await tester.pumpAndSettle();
        await tester.tap(find.text('정산 요청 보내기'));
        await tester.pumpAndSettle();
        expect(repo.input!.scheduleId, 12);
        expect(repo.input!.memberIds, [3]);
        expect(repo.input!.totalAmount, 30001);
        expect(repo.input!.title, '11월 정기모임 정산');
        expect(repo.input!.accountNumber, '1234');
        repo.created.complete(40);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
      testWidgets('등록 ${width.toInt()}px: 선택 없이 닫으면 일정 연결을 유지하지 않는다', (
        tester,
      ) async {
        await _open(tester, _Repository(), _Schedules(), width: width);
        await tester.tap(find.text('연결할 일정 선택 (선택)'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('일정 선택 없이 돌아가기'));
        await tester.pumpAndSettle();
        expect(find.byType(SettlementSchedulePicker), findsNothing);
        expect(find.text('연결할 일정 선택 (선택)'), findsOneWidget);
      });
      testWidgets('등록 ${width.toInt()}px: 일정 조회 실패 후 재시도하면 선택 가능한 일정을 표시한다', (
        tester,
      ) async {
        final boundary = GlobalKey();
        final schedules = _Schedules()..failFirst = true;
        await _open(
          tester,
          _Repository(),
          schedules,
          width: width,
          boundary: boundary,
        );
        await tester.tap(find.text('연결할 일정 선택 (선택)'));
        await tester.pumpAndSettle();
        expect(find.text('일정 목록을 불러오지 못했어요.'), findsOneWidget);
        await tester.tap(find.text('다시 시도'));
        await tester.pumpAndSettle();
        expect(find.text('11월 정기모임'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  });
}
