import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/theme/app_theme.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_members_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_create_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/regular_dues_form_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_detail_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_edit_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_list_page.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';

// flutter test scripts/capture_settlement_screenshots.dart --dart-define=SETTLEMENT_SCREENSHOTS=/absolute/output

import '../test/features/settlement/presentation/settlement_review_test_support.dart'
    as support;

const regularDue = RegularDue(
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

void main() {
  const output = String.fromEnvironment('SETTLEMENT_SCREENSHOTS');
  const regularOnly = bool.fromEnvironment('REGULAR_DUES_SCREENSHOTS');
  const manageOnly = bool.fromEnvironment('MANAGE_SETTLEMENT_SCREENSHOTS');
  setUpAll(() async {
    if (output.isEmpty) {
      throw ArgumentError('SETTLEMENT_SCREENSHOTS 출력 경로를 지정해 주세요.');
    }
    await (FontLoader(
      'Pretendard',
    )..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf'))).load();
    await (FontLoader(
      'MaterialIcons',
    )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
  });
  group('정산 실행화면 캡처', () {
    for (final role
        in regularOnly || manageOnly
            ? [MemberRole.admin]
            : [MemberRole.admin, MemberRole.member]) {
      for (final screen
          in manageOnly
              ? ['manage', 'edit', 'refund', 'replaced']
              : regularOnly
              ? ['regular-list', 'regular-create', 'regular-edit']
              : [
                  'list',
                  'detail',
                  if (role == MemberRole.admin) ...['create', 'account'],
                ]) {
        testWidgets('$screen $role 캡처를 저장한다', (tester) async {
          tester.view.physicalSize = const Size(393, 852);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          final key = GlobalKey();
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                regularDuesProvider.overrideWith(
                  (ref, id) async => [regularDue],
                ),
                groupMyRoleProvider.overrideWith((ref, id) async => role),
                groupMembersProvider(7).overrideWith(support.TestMembers.new),
                settlementDetailProvider.overrideWith(
                  (ref, key) async => switch (screen) {
                    'refund' => support.detail.copyWith(
                      status: SettlementStatus.canceled,
                      cancelReason: '금액 정정',
                      summary: support.detail.summary.copyWith(
                        paidCount: 1,
                        unpaidCount: 0,
                        paidAmount: 15000,
                      ),
                      payments: [
                        support.detail.payments.first.copyWith(
                          status: PaymentStatus.paid,
                        ),
                      ],
                    ),
                    'replaced' => support.detail.copyWith(
                      status: SettlementStatus.canceled,
                      cancelReason: '금액 정정',
                      replacedBySettlementId: 99,
                    ),
                    _ => support.detail,
                  },
                ),
                settlementListProvider.overrideWith(
                  (ref, id) async => [
                    Settlement(
                      id: 40,
                      title: '11월 회비',
                      totalAmount: 15000,
                      memberCount: 1,
                      dueAt: DateTime(2026, 12, 1),
                      createdAt: DateTime(2026, 11, 1),
                      status: SettlementStatus.inProgress,
                      myAmount: 15000,
                      myPaymentStatus: PaymentStatus.unpaid,
                    ),
                  ],
                ),
              ],
              child: RepaintBoundary(
                key: key,
                child: MaterialApp(
                  theme: AppTheme.light,
                  debugShowCheckedModeBanner: false,
                  home: switch (screen) {
                    'edit' => const SettlementEditPage(
                      meetingId: 7,
                      settlementId: 40,
                    ),
                    'list' ||
                    'regular-list' => const SettlementListPage(meetingId: 7),
                    'regular-create' => const RegularDuesFormPage(meetingId: 7),
                    'regular-edit' => const RegularDuesFormPage(
                      meetingId: 7,
                      regularDuesId: 7,
                    ),
                    'create' ||
                    'account' => const SettlementCreatePage(meetingId: 7),
                    _ => const SettlementDetailPage(
                      meetingId: 7,
                      settlementId: 40,
                    ),
                  },
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          if (screen == 'account') {
            await tester.scrollUntilVisible(
              find.text('받을 계좌 입력'),
              160,
              scrollable: find.byType(Scrollable).first,
            );
            await tester.tap(find.text('받을 계좌 입력'));
            await tester.pumpAndSettle();
            await tester.tap(find.text('입력 완료'));
            await tester.pumpAndSettle();
          }
          if (screen == 'refund') {
            await tester.scrollUntilVisible(
              find.text('환불 완료 기록'),
              160,
              scrollable: find.byType(Scrollable).first,
            );
            await Scrollable.ensureVisible(
              tester.element(find.text('환불 완료 기록')),
              alignment: 0.7,
            );
            await tester.pumpAndSettle();
          }
          expect(tester.takeException(), isNull);
          await tester.runAsync(() async {
            final image =
                await (key.currentContext!.findRenderObject()!
                        as RenderRepaintBoundary)
                    .toImage();
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            image.dispose();
            await Directory(output).create(recursive: true);
            final name = manageOnly
                ? 'settlement-$screen'
                : regularOnly
                ? 'regular-dues-${screen.replaceFirst('regular-', '')}'
                : screen == 'create'
                ? 'settlement-create'
                : 'settlement-$screen-${role == MemberRole.admin ? 'admin' : 'member'}';
            await File('$output/$name.png')
                .writeAsBytes(bytes!.buffer.asUint8List());
          });
        });
      }
    }
  });
}
