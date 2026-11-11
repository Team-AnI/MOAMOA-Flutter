import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_error_widget.dart';

import '../../domain/auth_input_rules.dart';
import '../auth_error.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/reset_password_state.dart';
import '../viewmodels/reset_password_status.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/auth_text_field.dart';

/// 비밀번호 재설정 화면 (7-6)
///
/// 재설정 메일의 링크(`/reset-password?token=…`)로 웹에서 열립니다. 돌아갈 화면이 없어 뒤로 버튼을 두지 않습니다.
/// 입력값을 담는 컨트롤러가 있어 StatefulWidget 으로 둡니다.
class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key, required this.token});

  /// 메일 링크의 token. 주소에 없으면 빈 문자열입니다.
  final String token;

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  /// 변경하기를 한 번 누른 뒤부터 입력 안내를 보여줍니다.
  bool _showErrors = false;

  String? get _passwordError =>
      _showErrors ? _passwordController.text.passwordError : null;

  bool get _isConfirmMatched =>
      _confirmController.text == _passwordController.text;

  String? get _confirmError =>
      _showErrors && !_isConfirmMatched ? '비밀번호가 일치하지 않아요.' : null;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onChanged(String _) {
    if (_showErrors) setState(() {});
  }

  /// 비밀번호 규칙에 맞고 확인이 일치할 때만 요청합니다.
  void _submit() {
    if (_passwordController.text.passwordError != null || !_isConfirmMatched) {
      setState(() => _showErrors = true);
      return;
    }
    ref
        .read(passwordResetProvider.notifier)
        .submit(token: widget.token, newPassword: _passwordController.text);
  }

  void _goToForgotPassword() => context.go('/forgot-password');

  /// 링크 만료는 화면으로 안내하고, 그 밖의 실패는 스낵바로 안내합니다.
  void _onStateChanged(ResetPasswordState next) {
    if (next.status == ResetPasswordStatus.failure && !next.isLinkExpired) {
      showMoaSnackBar(context, message: next.error!.authErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(passwordResetProvider, (_, next) => _onStateChanged(next));
    final state = ref.watch(passwordResetProvider);

    if (widget.token.isEmpty) {
      return Scaffold(
        backgroundColor: MoaColors.page,
        body: MoaErrorWidget(
          message: '링크가 올바르지 않아요. 비밀번호 찾기를 다시 요청해 주세요.',
          actionLabel: '비밀번호 찾기',
          onAction: _goToForgotPassword,
        ),
      );
    }
    if (state.status == ResetPasswordStatus.success) {
      return const _ResetDoneView();
    }
    if (state.isLinkExpired) {
      return Scaffold(
        backgroundColor: MoaColors.page,
        body: MoaErrorWidget(
          message: '링크가 만료되었습니다. 다시 요청해 주세요.',
          actionLabel: '비밀번호 찾기',
          onAction: _goToForgotPassword,
        ),
      );
    }

    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: ListView(
          // 뒤로 버튼이 없어도 다른 화면과 제목 높이를 맞춥니다. (Top Bar 56 + 4)
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
          children: [
            // 제목과 안내
            Text('새 비밀번호를 정해요', style: MoaText.titleXl),
            const SizedBox(height: 6),
            Text(
              '비밀번호를 바꾸면 모든 기기에서 로그아웃돼요.',
              style: MoaText.body.copyWith(color: MoaColors.textSecondary),
            ),
            const SizedBox(height: 24),
            AuthTextField(
              label: '새 비밀번호',
              controller: _passwordController,
              obscureText: true,
              hintText: '영문과 숫자를 포함해 8~72자',
              errorText: _passwordError,
              onChanged: _onChanged,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              label: '비밀번호 확인',
              controller: _confirmController,
              obscureText: true,
              hintText: '비밀번호를 한 번 더 입력하세요',
              errorText: _confirmError,
              onChanged: _onChanged,
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '비밀번호 변경하기',
        isLoading: state.isSubmitting,
        onPressed: _submit,
      ),
    );
  }
}

/// 비밀번호를 바꾼 뒤 보여주는 안내
class _ResetDoneView extends StatelessWidget {
  const _ResetDoneView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('비밀번호를 바꿨어요', style: MoaText.titleXl),
              const SizedBox(height: 6),
              Text(
                '비밀번호가 변경되었습니다. 앱에서 다시 로그인해 주세요.',
                style: MoaText.body.copyWith(color: MoaColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
