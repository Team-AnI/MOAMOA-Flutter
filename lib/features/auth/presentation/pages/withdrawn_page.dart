import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

import '../widgets/auth_page_title.dart';
import '../widgets/auth_submit_bar.dart';

/// 회원 탈퇴 완료 화면
///
/// 탈퇴하면 로그인하지 않은 상태가 되므로, 로그인 없이 볼 수 있는 화면으로 둡니다.
/// 돌아갈 화면이 없어 뒤로 버튼을 두지 않습니다.
class WithdrawnPage extends StatelessWidget {
  const WithdrawnPage({super.key});

  void _goToStart(BuildContext context) => context.go('/login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 24),
          children: [
            // 완료 아이콘
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MoaColors.accentTint,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  'assets/icons/check_circle.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const AuthPageTitle(
              title: '탈퇴가 완료됐어요',
              description: '그동안 모아모아를 써 주셔서 고마워요.',
            ),
            const SizedBox(height: 16),
            const _RejoinNotice(),
          ],
        ),
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '처음으로',
        onPressed: () => _goToStart(context),
      ),
    );
  }
}

/// 탈퇴 후 7일 동안 같은 이메일로 다시 가입할 수 없다는 안내
class _RejoinNotice extends StatelessWidget {
  const _RejoinNotice();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/info.svg', width: 20, height: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '탈퇴 후 7일 동안은 같은 이메일로 다시 가입할 수 없어요. 이전 모임 기록은 복구되지 않아요.',
                style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
