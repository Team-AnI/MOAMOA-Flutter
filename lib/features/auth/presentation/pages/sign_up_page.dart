import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../../domain/auth_input_rules.dart';
import '../auth_error.dart';
import '../auth_terms.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/sign_up_state.dart';
import '../viewmodels/sign_up_status.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_step_bar.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/auth_terms_sheet.dart';
import '../widgets/auth_text_field.dart';

/// 회원가입 화면 (7-1)
///
/// 가입하면 로그인한 상태가 되고 프로필 설정 화면으로 이동합니다.
/// 입력값을 담는 컨트롤러가 있어 StatefulWidget 으로 둡니다.
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  /// 이용약관과 개인정보 처리방침에 동의했는지
  bool _agreed = false;

  /// 다음을 한 번 누른 뒤부터 입력 안내를 보여줍니다.
  bool _showErrors = false;

  String? _shown(String? error) => _showErrors ? error : null;

  String? get _nameError => _shown(_nameController.text.nameError);

  String? get _emailError => _shown(_emailController.text.emailError);

  String? get _phoneError => _shown(_phoneController.text.phoneError);

  String? get _passwordError => _shown(_passwordController.text.passwordError);

  bool get _isConfirmMatched =>
      _confirmController.text == _passwordController.text;

  String? get _confirmError =>
      _shown(_isConfirmMatched ? null : '비밀번호가 일치하지 않아요.');

  String? get _termsError =>
      _shown(_agreed ? null : '이용약관과 개인정보 처리방침에 동의해 주세요.');

  bool get _hasInputError =>
      _nameController.text.nameError != null ||
      _emailController.text.emailError != null ||
      _phoneController.text.phoneError != null ||
      _passwordController.text.passwordError != null ||
      !_isConfirmMatched ||
      !_agreed;

  /// 돌아갈 화면이 있는지. 웹에서 주소로 바로 열면 없습니다.
  bool get _canGoBack => Navigator.canPop(context);

  /// 뒤로 버튼이 없으면 Top Bar 높이(56)만큼 띄워 다른 화면과 맞춥니다.
  EdgeInsets get _bodyPadding =>
      EdgeInsets.fromLTRB(20, _canGoBack ? 0 : 56, 20, 24);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onChanged(String _) {
    if (_showErrors) setState(() {});
  }

  void _toggleAgreed() => setState(() => _agreed = !_agreed);

  void _showTerms(AuthTerms terms) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: MoaColors.page,
      builder: (_) => AuthTermsSheet(terms: terms),
    );
  }

  /// 모든 입력이 규칙에 맞고 약관에 동의했을 때만 가입을 요청합니다.
  void _submit() {
    if (_hasInputError) {
      setState(() => _showErrors = true);
      return;
    }
    ref
        .read(signUpProvider.notifier)
        .signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
          agreedToTerms: _agreed,
        );
  }

  /// 가입 직후 프로필 설정으로 갑니다. 이미 가입했으므로 회원가입 화면으로는 돌아가지 않습니다.
  void _goToProfileSetup() =>
      context.go('/profile-setup', extra: _nameController.text.trim());

  void _onStateChanged(SignUpState next) {
    switch (next.status) {
      case SignUpStatus.success:
        _goToProfileSetup();
      case SignUpStatus.failure:
        showMoaSnackBar(context, message: next.error!.signUpErrorMessage);
      case SignUpStatus.initial || SignUpStatus.submitting:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signUpProvider, (_, next) => _onStateChanged(next));
    final isSubmitting = ref.watch(signUpProvider).isSubmitting;

    return Scaffold(
      backgroundColor: MoaColors.page,
      // 돌아갈 화면이 없을 때 뒤로 버튼을 누르면 오류가 나므로 두지 않습니다.
      appBar: _canGoBack ? MoaAppBar() : null,
      body: SafeArea(
        child: ListView(
          padding: _bodyPadding,
          children: [
            const AuthStepBar(step: 1),
            const SizedBox(height: 8),
            const AuthPageTitle(
              title: '회원가입',
              description: '이름과 이메일만 있으면 시작할 수 있어요.',
            ),
            const SizedBox(height: 24),
            _SignUpFields(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              passwordController: _passwordController,
              confirmController: _confirmController,
              nameError: _nameError,
              emailError: _emailError,
              phoneError: _phoneError,
              passwordError: _passwordError,
              confirmError: _confirmError,
              onChanged: _onChanged,
            ),
            const SizedBox(height: 20),
            _TermsAgreement(
              agreed: _agreed,
              errorText: _termsError,
              onToggle: _toggleAgreed,
              onShowTerms: _showTerms,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '다음',
        isLoading: isSubmitting,
        onPressed: _submit,
      ),
    );
  }
}

/// 이름·이메일·휴대폰·비밀번호·비밀번호 확인 입력칸
class _SignUpFields extends StatelessWidget {
  const _SignUpFields({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmController,
    required this.nameError,
    required this.emailError,
    required this.phoneError,
    required this.passwordError,
    required this.confirmError,
    required this.onChanged,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final String? nameError;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final String? confirmError;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          label: '이름',
          controller: nameController,
          hintText: '이름을 입력하세요',
          errorText: nameError,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: '이메일',
          controller: emailController,
          hintText: 'you@example.com',
          keyboardType: TextInputType.emailAddress,
          errorText: emailError,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: '휴대폰 번호 (선택)',
          controller: phoneController,
          hintText: '010-1234-5678',
          keyboardType: TextInputType.phone,
          errorText: phoneError,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: '비밀번호',
          controller: passwordController,
          obscureText: true,
          hintText: '비밀번호를 입력하세요',
          helperText: '영문과 숫자를 포함해 8~72자로 만들어 주세요.',
          errorText: passwordError,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: '비밀번호 확인',
          controller: confirmController,
          obscureText: true,
          hintText: '비밀번호를 한 번 더 입력하세요',
          errorText: confirmError,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

/// 약관 동의 체크와 전문 보기 링크
class _TermsAgreement extends StatelessWidget {
  const _TermsAgreement({
    required this.agreed,
    required this.errorText,
    required this.onToggle,
    required this.onShowTerms,
  });

  final bool agreed;

  /// 값이 있으면 동의 아래에 안내를 보여줍니다.
  final String? errorText;
  final VoidCallback onToggle;
  final ValueChanged<AuthTerms> onShowTerms;

  /// 동의하면 진하게, 아니면 연한 회색으로 체크 동그라미를 칠합니다.
  Color get _checkColor => agreed ? MoaColors.accent : MoaColors.placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 동의 체크
        Semantics(
          checked: agreed,
          child: InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _checkColor,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/check_bold.svg',
                      width: 13,
                      height: 13,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('이용약관과 개인정보 처리방침에 동의해요', style: MoaText.sub),
                  ),
                ],
              ),
            ),
          ),
        ),
        // 전문 보기 링크
        Padding(
          padding: const EdgeInsets.only(left: 34),
          child: Row(
            children: [
              for (final terms in AuthTerms.values)
                TextButton(
                  onPressed: () => onShowTerms(terms),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    minimumSize: const Size(0, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '${terms.title} 보기',
                    style: MoaText.caption.copyWith(
                      fontSize: 13,
                      color: MoaColors.textSecondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
        // 동의 안내
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Text(
              errorText!,
              style: MoaText.caption.copyWith(color: MoaColors.error),
            ),
          ),
      ],
    );
  }
}
