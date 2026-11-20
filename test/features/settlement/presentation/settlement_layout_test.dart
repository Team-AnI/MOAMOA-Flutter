import 'package:flutter/material.dart';
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

import 'settlement_review_test_support.dart' as support;

void main() {
  group('정산 화면 너비와 역할', () {
    setUpAll(() async {
      await (FontLoader('Pretendard')
            ..addFont(rootBundle.load('assets/fonts/PretendardVariable.ttf')))
          .load();
      await (FontLoader(
        'MaterialIcons',
      )..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'))).load();
    });
    for (final width in [393.0, 320.0]) {
      for (final role in [MemberRole.admin, MemberRole.member]) {
        for (final list in [false, true]) {
          testWidgets(
            '${list ? "목록" : "상세"} $role ${width.toInt()}px에서 역할별 화면이 넘치지 않고 표시된다',
            (tester) async {
              tester.view.physicalSize = Size(width, 852);
              tester.view.devicePixelRatio = 1;
              addTearDown(tester.view.resetPhysicalSize);
              addTearDown(tester.view.resetDevicePixelRatio);
              await tester.pumpWidget(
                ProviderScope(
                  overrides: [
                    groupMyRoleProvider.overrideWith((ref, id) async => role),
                    settlementDetailProvider.overrideWith(
                      (ref, key) async => support.detail,
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
                  child: MaterialApp(
                    theme: AppTheme.light,
                    debugShowCheckedModeBanner: false,
                    home: list
                        ? const SettlementListPage(meetingId: 7)
                        : const SettlementDetailPage(
                            meetingId: 7,
                            settlementId: 40,
                          ),
                  ),
                ),
              );
              await tester.pumpAndSettle();
              expect(tester.takeException(), isNull);
              if (list) {
                expect(
                  find.text('새 정산 등록'),
                  role == MemberRole.admin ? findsOneWidget : findsNothing,
                );
              }
            },
          );
        }
      }
    }
    testWidgets('반려 사유는 320x568 키보드 위에서 스크롤할 수 있다', (tester) async {
      await support.pumpReviewPage(
        tester,
        const SettlementDetailPage(meetingId: 7, settlementId: 40),
        value: support.detail.copyWith(
          payments: [
            support.detail.payments.single.copyWith(
              status: PaymentStatus.pending,
            ),
          ],
        ),
      );
      tester.view.physicalSize = const Size(320, 568);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('반려'), 160);
      await tester.tap(find.text('반려'));
      await tester.pumpAndSettle();
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      addTearDown(tester.view.resetViewInsets);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
