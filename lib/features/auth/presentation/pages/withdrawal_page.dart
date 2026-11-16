import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../../domain/auth_input_rules.dart';
import '../auth_error.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/withdrawal_state.dart';
import '../viewmodels/withdrawal_status.dart';
import '../widgets/auth_check_row.dart';
import '../widgets/auth_page_title.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/auth_text_field.dart';

/// 회원 탈퇴 안내 화면 (7-9)
///
/// 탈퇴하면 바뀌는 점을 보여주고, 안내를 확인했다고 체크한 뒤 비밀번호 확인 팝업에서 탈퇴합니다.
/// 탈퇴하면 완료 화면으로 이동합니다.
class WithdrawalPage extends ConsumerStatefulWidget {
  const WithdrawalPage({super.key});

  @override
  ConsumerState<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends ConsumerState<WithdrawalPage> {
  /// 안내 내용을 모두 확인했는지
  bool _confirmed = false;

  /// 회원 탈퇴를 한 번 누른 뒤부터 확인 안내를 보여줍니다.
  bool _showErrors = false;

  String? get _confirmError =>
      _showErrors && !_confirmed ? '안내 내용을 확인했다고 체크해 주세요.' : null;

  void _toggleConfirmed() => setState(() => _confirmed = !_confirmed);

  /// 안내를 확인했으면 비밀번호 확인 팝업을 엽니다.
  void _openConfirmDialog() {
    if (!_confirmed) {
      setState(() => _showErrors = true);
      return;
    }
    showDialog<void>(
      context: context,
      builder: (_) => const _WithdrawalConfirmDialog(),
    );
  }

  /// 탈퇴하면 완료 화면으로, 비밀번호 오류가 아닌 실패는 스낵바로 안내합니다.
  /// (비밀번호 오류는 팝업의 입력칸 아래에 안내합니다)
  void _onStateChanged(WithdrawalState next) {
    switch (next.status) {
      case WithdrawalStatus.success:
        context.go('/withdrawn');
      case WithdrawalStatus.failure when !next.isWrongPassword:
        showMoaSnackBar(context, message: next.error!.withdrawalErrorMessage);
      case _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(withdrawalProvider, (_, next) => _onStateChanged(next));
    ref.watch(withdrawalProvider);

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(title: '회원 탈퇴'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          const AuthPageTitle(
            title: '정말 떠나시나요?',
            description: '탈퇴하면 이렇게 바뀌어요.',
          ),
          const SizedBox(height: 24),
          const _ChangesCard(),
          const SizedBox(height: 20),
          AuthCheckRow(
            checked: _confirmed,
            label: '안내 내용을 모두 확인했어요',
            onToggle: _toggleConfirmed,
          ),
          if (_confirmError != null)
            Padding(
              padding: const EdgeInsets.only(left: 38),
              child: Text(
                _confirmError!,
                style: MoaText.caption.copyWith(color: MoaColors.error),
              ),
            ),
        ],
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '회원 탈퇴',
        isDanger: true,
        onPressed: _openConfirmDialog,
      ),
    );
  }
}

/// 탈퇴하면 바뀌는 점 세 가지 (PRD 8.6.7)
class _ChangesCard extends StatelessWidget {
  const _ChangesCard();

  static const _changes = [
    (
      icon: 'user_minus',
      title: '계정이 바로 삭제돼요',
      description: '이름, 이메일, 휴대폰 번호는 되돌릴 수 없고, 7일 동안 같은 이메일로 다시 가입할 수 없어요.',
    ),
    (icon: 'users_three', title: '모든 모임에서 나가요', description: '구성원 목록에서 빠져요'),
    (
      icon: 'receipt',
      title: '기록은 모임에 남아요',
      description: '출석, 정산 내역은 탈퇴한 사용자로 보여요',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          for (final (index, change) in _changes.indexed) ...[
            // 구분선
            if (index > 0)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(height: 1, color: MoaColors.page),
              ),
            // 바뀌는 점 한 줄
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MoaColors.page,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/${change.icon}.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(change.title, style: MoaText.bodyStrong),
                        const SizedBox(height: 2),
                        Text(
                          change.description,
                          style: MoaText.sub.copyWith(
                            color: MoaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// 비밀번호를 다시 입력해 탈퇴하는 확인 팝업
///
/// 비밀번호가 틀리면 입력칸 아래에 안내하고 팝업을 닫지 않습니다.
/// 탈퇴했거나 그 밖의 이유로 실패하면 팝업을 닫습니다. (안내는 탈퇴 화면이 합니다)
/// 입력값을 담는 컨트롤러가 있어 StatefulWidget 으로 둡니다.
class _WithdrawalConfirmDialog extends ConsumerStatefulWidget {
  const _WithdrawalConfirmDialog();

  @override
  ConsumerState<_WithdrawalConfirmDialog> createState() =>
      _WithdrawalConfirmDialogState();
}

class _WithdrawalConfirmDialogState
    extends ConsumerState<_WithdrawalConfirmDialog> {
  final _passwordController = TextEditingController();

  /// 비밀번호를 비운 채 누르면 보여줄 안내
  String? _emptyError;

  String? _passwordError(WithdrawalState state) =>
      _emptyError ??
      (state.isWrongPassword ? state.error!.withdrawalErrorMessage : null);

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _close() => Navigator.of(context).pop();

  void _submit() {
    final error = _passwordController.text.loginPasswordError;
    setState(() => _emptyError = error);
    if (error != null) return;
    ref
        .read(withdrawalProvider.notifier)
        .withdraw(password: _passwordController.text);
  }

  void _onStateChanged(WithdrawalState next) {
    switch (next.status) {
      case WithdrawalStatus.success:
        _close();
      case WithdrawalStatus.failure when !next.isWrongPassword:
        _close();
      case _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(withdrawalProvider, (_, next) => _onStateChanged(next));
    final state = ref.watch(withdrawalProvider);

    return Dialog(
      backgroundColor: MoaColors.raised,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목과 안내 문구
            Text('정말 탈퇴할까요?', style: MoaText.titleM),
            const SizedBox(height: 8),
            Text(
              '계정과 프로필이 삭제되고 되돌릴 수 없어요.',
              style: MoaText.body.copyWith(color: MoaColors.textSecondary),
            ),
            const SizedBox(height: 20),
            // 비밀번호
            AuthTextField(
              label: '비밀번호',
              controller: _passwordController,
              obscureText: true,
              hintText: '비밀번호를 입력하세요',
              helperText: '본인 확인을 위해 비밀번호를 입력해 주세요.',
              errorText: _passwordError(state),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 20),
            // 취소·탈퇴하기
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: state.isSubmitting ? null : _close,
                    style: FilledButton.styleFrom(
                      backgroundColor: MoaColors.fill,
                      minimumSize: const Size(0, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      '취소',
                      style: MoaText.button.copyWith(
                        color: MoaColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: state.isSubmitting ? null : _submit,
                    style: FilledButton.styleFrom(
                      backgroundColor: MoaColors.dangerTint,
                      disabledBackgroundColor: MoaColors.dangerTint,
                      minimumSize: const Size(0, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      '탈퇴하기',
                      style: MoaText.button.copyWith(color: MoaColors.danger),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
