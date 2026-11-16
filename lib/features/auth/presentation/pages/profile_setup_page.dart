import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/constants/profile_color.dart';
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
            _ColorCard(
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
        footer: _SkipButton(onPressed: () => _goHome(context)),
      ),
    );
  }
}

/// 화면에 보여줄 프로필 색 이름 (화면 읽기 프로그램이 읽어 줍니다)
extension ProfileColorLabelX on ProfileColor {
  String get label => switch (this) {
    ProfileColor.lightBlue => '연파랑',
    ProfileColor.gray => '회색',
    ProfileColor.blue => '진한 파랑',
    ProfileColor.dark => '검정',
  };
}

/// 기본 프로필 색 4개 중 하나를 고르는 카드
class _ColorCard extends StatelessWidget {
  const _ColorCard({
    required this.userName,
    required this.selected,
    required this.onSelected,
  });

  final String? userName;
  final ProfileColor selected;
  final ValueChanged<ProfileColor> onSelected;

  bool _isSelected(ProfileColor color) => color == selected;

  /// 고른 색에만 진한 테두리를 둘러 줍니다.
  BoxBorder? _border(ProfileColor color) =>
      _isSelected(color) ? Border.all(color: MoaColors.accent, width: 2) : null;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '기본 프로필 색',
                style: MoaText.subStrong.copyWith(
                  color: MoaColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 색 고르기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final color in ProfileColor.values)
                    // 동그라미 안 이름 첫 글자 대신 색 이름만 읽어 줍니다.
                    Semantics(
                      button: true,
                      selected: _isSelected(color),
                      label: color.label,
                      excludeSemantics: true,
                      onTap: () => onSelected(color),
                      child: GestureDetector(
                        onTap: () => onSelected(color),
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: _border(color),
                          ),
                          child: MoaProfileAvatar(
                            userName: userName,
                            color: color,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 프로필 색을 고르지 않고 첫 화면으로 가는 버튼. 서버 기본값(LIGHT_BLUE)이 그대로 쓰입니다.
class _SkipButton extends StatelessWidget {
  const _SkipButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 32),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        '나중에 할게요',
        style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
      ),
    );
  }
}
