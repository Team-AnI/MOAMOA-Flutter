import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_profile_avatar.dart';

import '../auth_error.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/profile_setup_state.dart';
import '../viewmodels/profile_setup_status.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_step_bar.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/profile_color_card.dart';

/// 가입 직후 프로필 설정 화면 (7-8 프로필 색)
///
/// 이미 가입한 뒤라 회원가입 화면으로 돌아가지 않도록 뒤로 버튼을 두지 않고, 대신 "나중에 할게요" 를 둡니다.
/// 프로필 사진은 차기 버전이라 색만 고릅니다.
class ProfileSetupPage extends ConsumerWidget {
  const ProfileSetupPage({super.key, required this.userName});

  /// 가입할 때 입력한 이름. 프로필 동그라미에 첫 글자를 보여줍니다.
  final String? userName;

  void _goHome(BuildContext context) => context.go('/');

  void _onStateChanged(BuildContext context, ProfileSetupState next) {
    switch (next.status) {
      case ProfileSetupStatus.success:
        _goHome(context);
      case ProfileSetupStatus.failure:
        showMoaSnackBar(context, message: next.error!.authErrorMessage);
      case ProfileSetupStatus.initial || ProfileSetupStatus.submitting:
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      profileSetupProvider,
      (_, next) => _onStateChanged(context, next),
    );
    final state = ref.watch(profileSetupProvider);
    final viewModel = ref.read(profileSetupProvider.notifier);

    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: ListView(
          // 뒤로 버튼이 없어도 회원가입 화면과 단계 막대 높이를 맞춥니다. (Top Bar 56)
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
          children: [
            const AuthStepBar(step: 2),
            const SizedBox(height: 8),
            const AuthPageTitle(
              title: '프로필을 정해요',
              description: '모임원에게 보이는 모습이에요. 나중에 바꿀 수 있어요.',
            ),
            const SizedBox(height: 24),
            Center(
              child: MoaProfileAvatar(
                userName: userName,
                color: state.color,
                size: 112,
              ),
            ),
            const SizedBox(height: 24),
            ProfileColorCard(
              userName: userName,
              selected: state.color,
              onSelected: viewModel.select,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '시작하기',
        isLoading: state.isSubmitting,
        onPressed: viewModel.save,
        // 저장을 보낸 뒤에는 저장하지 않고 넘어갈 수 없으므로 끝날 때까지 막습니다.
        footer: _SkipButton(
          onPressed: state.isSubmitting ? null : () => _goHome(context),
        ),
      ),
    );
  }
}

/// 프로필 색을 고르지 않고 첫 화면으로 가는 버튼. 서버 기본값(LIGHT_BLUE)이 그대로 쓰입니다.
///
/// [onPressed] 가 null 이면(저장 중) 누를 수 없습니다.
class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: MoaColors.textSecondary,
        minimumSize: const Size(0, 32),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text('나중에 할게요', style: MoaText.sub),
    );
  }
}
