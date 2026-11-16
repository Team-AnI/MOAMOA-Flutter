import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';

import '../../domain/auth_input_rules.dart';
import '../auth_error.dart';
import '../auth_redirect.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/login_state.dart';
import '../viewmodels/login_status.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/auth_text_field.dart';

/// 로그인 화면 (7-2)
///
/// 로그인하면 앱 라우터가 로그인 상태를 보고 첫 화면으로 보냅니다.
/// 입력값을 담는 컨트롤러가 있어 StatefulWidget 으로 둡니다.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// 로그인을 한 번 누른 뒤부터 입력 안내를 보여줍니다.
  bool _showErrors = false;

  String? get _emailError =>
      _showErrors ? _emailController.text.emailError : null;

  String? get _passwordError =>
      _showErrors ? _passwordController.text.loginPasswordError : null;

  bool get _hasInputError =>
      _emailController.text.emailError != null ||
      _passwordController.text.loginPasswordError != null;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onChanged(String _) {
    if (_showErrors) setState(() {});
  }

  /// 이메일 형식이 맞고 비밀번호를 입력했을 때만 로그인을 요청합니다.
  void _submit() {
    if (_hasInputError) {
      setState(() => _showErrors = true);
      return;
    }
    ref
        .read(loginProvider.notifier)
        .login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  /// 비밀번호 찾기에서 뒤로 가면 로그인 화면으로 돌아오도록 쌓아서 엽니다.
  void _goToForgotPassword() => context.push('/forgot-password');

  void _onStateChanged(LoginState next) {
    if (next.status == LoginStatus.failure) {
      showMoaSnackBar(context, message: next.error!.loginErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider, (_, next) => _onStateChanged(next));
    final isSubmitting = ref.watch(loginProvider).isSubmitting;
    final needsReLogin = ref.watch(authSessionProvider).needsReLogin;

    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 88, 20, 24),
          children: [
            // 앱 아이콘
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MoaColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SvgPicture.asset(
                  'assets/icons/users_three_fill.svg',
                  width: 34,
                  height: 34,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const AuthPageTitle(
              title: '흩어진 모임 운영을 한 곳에서',
              description: '일정, 공지, 회비를 모임원과 함께 관리해요.',
            ),
            // 재발급까지 실패해 다시 로그인해야 할 때의 안내
            if (needsReLogin) ...[
              const SizedBox(height: 20),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: MoaColors.fill,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '로그인이 만료되었어요. 다시 로그인해 주세요.',
                    style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 36),
            AuthTextField(
              label: '이메일',
              controller: _emailController,
              hintText: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError,
              onChanged: _onChanged,
            ),
            const SizedBox(height: 14),
            AuthTextField(
              label: '비밀번호',
              controller: _passwordController,
              obscureText: true,
              hintText: '비밀번호를 입력하세요',
              errorText: _passwordError,
              onChanged: _onChanged,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 14),
            // 비밀번호 찾기 링크 (오른쪽 정렬)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _goToForgotPassword,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '비밀번호를 잊으셨나요?',
                  style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '로그인',
        isLoading: isSubmitting,
        onPressed: _submit,
      ),
    );
  }
}
