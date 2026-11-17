import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../../domain/auth_input_rules.dart';
import '../auth_error.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/forgot_password_state.dart';
import '../viewmodels/forgot_password_status.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/auth_text_field.dart';

/// 비밀번호 찾기 화면 (7-5)
///
/// 가입한 이메일로 재설정 링크를 보냅니다. 가입하지 않은 이메일도 같은 안내를 보여줍니다.
/// 입력값을 담는 컨트롤러가 있어 StatefulWidget 으로 둡니다.
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  /// 보내기를 한 번 누른 뒤부터 이메일 형식 안내를 보여줍니다.
  bool _showEmailError = false;

  String? get _emailError =>
      _showEmailError ? _emailController.text.emailError : null;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged(String _) {
    if (_showEmailError) setState(() {});
  }

  /// 이메일 형식이 맞을 때만 재설정 메일을 요청합니다.
  void _submit() {
    if (_emailController.text.emailError != null) {
      setState(() => _showEmailError = true);
      return;
    }
    ref.read(forgotPasswordProvider.notifier).request(_emailController.text);
  }

  void _onStateChanged(ForgotPasswordState next) {
    switch (next.status) {
      case ForgotPasswordStatus.sent:
        showMoaSnackBar(context, message: '재설정 링크를 보냈어요. 메일함을 확인해 주세요.');
      case ForgotPasswordStatus.failure:
        showMoaSnackBar(context, message: next.error!.authErrorMessage);
      case ForgotPasswordStatus.initial || ForgotPasswordStatus.sending:
        break;
    }
  }

  /// 돌아갈 화면이 있는지. 웹에서 주소로 바로 열면 없습니다.
  bool get _canGoBack => Navigator.canPop(context);

  /// 뒤로 버튼이 없으면 다른 화면과 제목 높이를 맞춥니다. (Top Bar 56 + 4)
  EdgeInsets get _bodyPadding =>
      EdgeInsets.fromLTRB(20, _canGoBack ? 4 : 60, 20, 24);

  @override
  Widget build(BuildContext context) {
    ref.listen(forgotPasswordProvider, (_, next) => _onStateChanged(next));
    final isSending = ref.watch(forgotPasswordProvider).isSending;

    return Scaffold(
      backgroundColor: MoaColors.page,
      // 돌아갈 화면이 없을 때 뒤로 버튼을 누르면 오류가 나므로 두지 않습니다.
      appBar: _canGoBack ? MoaAppBar() : null,
      body: SafeArea(
        child: ListView(
          padding: _bodyPadding,
          children: [
            const AuthPageTitle(
              title: '비밀번호를 잊으셨나요?',
              description: '가입한 이메일로 재설정 링크를 보내 드릴게요.',
            ),
            const SizedBox(height: 24),
            AuthTextField(
              label: '이메일',
              controller: _emailController,
              hintText: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError,
              onChanged: _onEmailChanged,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 20),
            const _MailNoticeCard(),
          ],
        ),
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '재설정 링크 보내기',
        isLoading: isSending,
        onPressed: _submit,
      ),
    );
  }
}

/// 메일 안내 카드. 링크 유효 시간은 명세(10분)를 따릅니다.
class _MailNoticeCard extends StatelessWidget {
  const _MailNoticeCard();

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
            SvgPicture.asset(
              'assets/icons/envelope_simple.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '메일이 오지 않으면 스팸함을 확인해 주세요. 링크는 10분 동안만 쓸 수 있어요.',
                style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
