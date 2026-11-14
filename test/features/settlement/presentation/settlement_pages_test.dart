import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_detail_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_list_page.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';

void main() {
  setUpAll(() async {
    await (FontLoader(
      'Pretendard',
    )..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });

  final now = DateTime.parse('2026-11-17T10:00:00+09:00');
  final settlement = Settlement(
    id: 40,
    title: '11월 모임 회비',
    totalAmount: 45000,
    memberCount: 3,
    dueAt: now,
    createdAt: now,
    status: SettlementStatus.inProgress,
    myAmount: 15000,
    myPaymentStatus: PaymentStatus.unpaid,
  );
  final due = const RegularDue(
    id: 7,
    title: '월 회비',
    amount: 10000,
    cycle: DuesCycle.monthly,
    cycleDay: '10',
    sendTime: '09:00',
    dueDays: 7,
    bankName: '국민은행',
    accountNumber: '1234',
    accountHolder: '김모아',
    isActive: true,
    postNotice: false,
  );
  final detail = SettlementDetail(
    id: 40,
    title: '11월 모임 회비',
    totalAmount: 45000,
    bankName: '국민은행',
    accountNumber: '1234',
    accountHolder: '김모아',
    dueAt: now,
    status: SettlementStatus.inProgress,
    myPayment: const SettlementPayment(
      id: 81,
      amount: 15000,
      status: PaymentStatus.unpaid,
    ),
    summary: const SettlementSummary(
      totalCount: 3,
      unpaidCount: 2,
      pendingCount: 1,
      paidCount: 0,
      refundedCount: 0,
      paidAmount: 0,
    ),
    payments: const [
      SettlementPayment(
        id: 81,
        memberId: 3,
        userName: '김모아',
        amount: 15000,
        status: PaymentStatus.unpaid,
      ),
      SettlementPayment(
        id: 82,
        memberId: 5,
        userName: '이모아',
        amount: 15000,
        status: PaymentStatus.pending,
      ),
    ],
  );

  Future<void> open(
    WidgetTester tester,
    Widget page, {
    required MemberRole role,
    required GlobalKey boundary,
    SettlementDetail? detailOverride,
  }) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          groupMyRoleProvider.overrideWith((ref, id) async => role),
          settlementListProvider.overrideWith((ref, id) async => [settlement]),
          regularDuesProvider.overrideWith((ref, id) async => [due]),
          settlementDetailProvider.overrideWith(
            (ref, key) async => detailOverride ?? detail,
          ),
        ],
        child: RepaintBoundary(
          key: boundary,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            home: page,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('관리자에게 정산·정기 회비 관리가 보이고 화면이 좁아도 넘치지 않는다', (tester) async {
    final boundary = GlobalKey();
    await open(
      tester,
      const SettlementListPage(meetingId: 7),
      role: MemberRole.admin,
      boundary: boundary,
    );
    expect(find.text('새 정산 등록'), findsOneWidget);
    expect(find.text('월 회비'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await _capture(tester, boundary, 'settlement-list-admin');
  });

  testWidgets('구성원은 정산 현황을 보되 관리자 등록 동작을 볼 수 없다', (tester) async {
    final boundary = GlobalKey();
    await open(
      tester,
      const SettlementListPage(meetingId: 7),
      role: MemberRole.member,
      boundary: boundary,
    );
    expect(find.text('내가 낼 회비'), findsOneWidget);
    expect(find.text('새 정산 등록'), findsNothing);
    expect(tester.takeException(), isNull);
    await _capture(tester, boundary, 'settlement-list-member');
  });

  testWidgets('정산 상세는 구성원에게 납부 제출을, 관리자에게 승인·반려를 보여준다', (tester) async {
    final memberBoundary = GlobalKey();
    await open(
      tester,
      const SettlementDetailPage(meetingId: 7, settlementId: 40),
      role: MemberRole.member,
      boundary: memberBoundary,
    );
    expect(find.text('납부했어요'), findsOneWidget);
    expect(find.text('입금 확인'), findsNothing);
    await _capture(tester, memberBoundary, 'settlement-detail-member');

    final adminBoundary = GlobalKey();
    await open(
      tester,
      const SettlementDetailPage(meetingId: 7, settlementId: 40),
      role: MemberRole.admin,
      boundary: adminBoundary,
    );
    await tester.scrollUntilVisible(find.text('입금 확인'), 180);
    expect(find.text('입금 확인'), findsOneWidget);
    expect(find.text('반려'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await _capture(tester, adminBoundary, 'settlement-detail-admin');
  });

  testWidgets('확인 대기 납부가 있으면 정산 취소를 막는다', (tester) async {
    await open(
      tester,
      const SettlementDetailPage(meetingId: 7, settlementId: 40),
      role: MemberRole.admin,
      boundary: GlobalKey(),
    );
    final cancel = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, '정산 취소'),
    );
    expect(cancel.onPressed, isNull);
    expect(find.text('확인 대기 중인 납부를 먼저 승인하거나 반려해 주세요.'), findsOneWidget);
  });

  testWidgets('취소된 정산에서 완납한 구성원에게만 환불 완료 기록을 보여준다', (tester) async {
    final canceled = detail.copyWith(
      status: SettlementStatus.canceled,
      summary: detail.summary.copyWith(pendingCount: 0, paidCount: 1),
      payments: const [
        SettlementPayment(
          id: 82,
          memberId: 5,
          userName: '이모아',
          amount: 15000,
          status: PaymentStatus.paid,
        ),
      ],
    );
    await open(
      tester,
      const SettlementDetailPage(meetingId: 7, settlementId: 40),
      role: MemberRole.admin,
      boundary: GlobalKey(),
      detailOverride: canceled,
    );
    await tester.scrollUntilVisible(find.text('환불 완료 기록'), 180);
    expect(find.text('환불 완료 기록'), findsOneWidget);
    expect(find.text('정산 취소'), findsNothing);
  });
}

Future<void> _capture(
  WidgetTester tester,
  GlobalKey boundary,
  String name,
) async {
  const directoryPath = String.fromEnvironment('SETTLEMENT_SCREENSHOTS');
  if (directoryPath.isEmpty) return;
  await tester.runAsync(() async {
    final boundaryObject =
        boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundaryObject.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final directory = Directory(directoryPath);
    await directory.create(recursive: true);
    await File('${directory.path}/$name.png')
        .writeAsBytes(bytes!.buffer.asUint8List());
  });
}
