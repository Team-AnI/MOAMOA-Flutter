import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_dialogs.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/core/widgets/moa_error_widget.dart';
import 'package:moamoa/core/widgets/moa_profile_avatar.dart';

import '../../domain/entities/my_account.dart';
import '../auth_error.dart';
import '../auth_terms.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/my_account_status.dart';
import '../widgets/account_menu_group.dart';
import '../widgets/account_menu_item.dart';
import '../widgets/auth_terms_sheet.dart';

/// 내 계정 화면 (7-7)
///
/// 모임 화면 아래 탭의 "내 계정"에서 쌓아서 엽니다. 하단 탭을 화면 사이에서 공유하는 구조가 생기기 전까지는
/// 뒤로 버튼으로 돌아갑니다.
class MyAccountPage extends ConsumerWidget {
  const MyAccountPage({super.key});

  void _goToEdit(BuildContext context, MyAccount account) =>
      context.push('/me/edit', extra: account);

  void _showTerms(BuildContext context, AuthTerms terms) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: MoaColors.page,
      builder: (_) => AuthTermsSheet(terms: terms),
    );
  }

  /// 확인을 누르면 로그아웃합니다. 로그아웃하면 앱 라우터가 로그인 화면으로 보냅니다.
  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showMoaConfirmDialog(
      context,
      title: '로그아웃할까요?',
      message: '이 기기에서 로그아웃돼요.',
      confirmLabel: '로그아웃',
    );
    if (confirmed ?? false) {
      await ref.read(myAccountProvider.notifier).logout();
    }
  }

  List<AccountMenuItem> _termsItems(BuildContext context) => [
    for (final (terms, icon) in [
      (AuthTerms.service, 'file_text'),
      (AuthTerms.privacy, 'shield_check'),
    ])
      AccountMenuItem(
        icon: icon,
        label: terms.title,
        onTap: () => _showTerms(context, terms),
      ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myAccountProvider);

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(),
      body: switch (state.status) {
        MyAccountStatus.loading => const Center(
          child: CircularProgressIndicator(),
        ),
        MyAccountStatus.failure => MoaErrorWidget(
          message: state.error!.authErrorMessage,
          onAction: ref.read(myAccountProvider.notifier).load,
        ),
        MyAccountStatus.loaded => ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Text('내 계정', style: MoaText.titleXl),
            const SizedBox(height: 16),
            _ProfileCard(
              account: state.account!,
              onEdit: () => _goToEdit(context, state.account!),
            ),
            const SizedBox(height: 12),
            AccountMenuGroup(items: _termsItems(context)),
            const SizedBox(height: 12),
            AccountMenuGroup(
              items: [
                AccountMenuItem(
                  icon: 'sign_out',
                  label: '로그아웃',
                  showArrow: false,
                  onTap: () => _confirmLogout(context, ref),
                ),
              ],
            ),
          ],
        ),
      },
    );
  }
}

/// 프로필 동그라미·이름·이메일과 편집 버튼
class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.account, required this.onEdit});

  final MyAccount account;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          MoaProfileAvatar(
            userName: account.name,
            color: account.profileColor,
            size: 56,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(account.name, style: MoaText.titleM),
                const SizedBox(height: 2),
                Text(
                  account.email,
                  style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            style: TextButton.styleFrom(
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: Text('편집', style: MoaText.bodyStrong),
          ),
        ],
      ),
    );
  }
}
