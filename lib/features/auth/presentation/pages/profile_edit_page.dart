import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/core/widgets/moa_profile_avatar.dart';

import '../../domain/auth_input_rules.dart';
import '../../domain/entities/my_account.dart';
import '../auth_error.dart';
import '../providers/auth_providers.dart';
import '../viewmodels/profile_edit_state.dart';
import '../viewmodels/profile_edit_status.dart';
import '../widgets/auth_submit_bar.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/profile_color_card.dart';

/// 프로필 편집 화면 (7-8)
///
/// 내 계정 화면에서 지금 내 정보([account])를 받아 엽니다. 바뀐 것이 없으면 저장하지 않고 돌아갑니다.
/// 프로필 사진은 차기 버전이라 색만 고릅니다.
/// 입력값을 담는 컨트롤러가 있어 StatefulWidget 으로 둡니다.
class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key, required this.account});

  final MyAccount account;

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late final _nameController = TextEditingController(text: widget.account.name);
  late final _phoneController = TextEditingController(
    text: widget.account.phone ?? '',
  );
  late final _emailController = TextEditingController(
    text: widget.account.email,
  );

  /// 저장을 한 번 누른 뒤부터 입력 안내를 보여줍니다.
  bool _showErrors = false;

  String? get _nameError => _showErrors ? _nameController.text.nameError : null;

  String? get _phoneError =>
      _showErrors ? _phoneController.text.phoneError : null;

  /// 이름·휴대폰·프로필 색 중 하나라도 바뀌었는지 (변경 여부는 화면에서 판단합니다)
  bool get _hasChanges =>
      _nameController.text.trim() != widget.account.name ||
      _phoneController.text.trim() != (widget.account.phone ?? '') ||
      ref.read(profileEditProvider(widget.account)).color !=
          widget.account.profileColor;

  bool get _hasInputError =>
      _nameController.text.nameError != null ||
      _phoneController.text.phoneError != null;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// 프로필 동그라미의 이름 첫 글자가 입력을 따라가도록 다시 그립니다.
  void _onChanged(String _) => setState(() {});

  void _save() {
    if (!_hasChanges) {
      context.pop();
      return;
    }
    if (_hasInputError) {
      setState(() => _showErrors = true);
      return;
    }
    ref
        .read(profileEditProvider(widget.account).notifier)
        .save(name: _nameController.text, phone: _phoneController.text);
  }

  void _onStateChanged(ProfileEditState next) {
    switch (next.status) {
      case ProfileEditStatus.success:
        context.pop();
      case ProfileEditStatus.failure:
        showMoaSnackBar(context, message: next.error!.authErrorMessage);
      case ProfileEditStatus.initial || ProfileEditStatus.submitting:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = profileEditProvider(widget.account);
    ref.listen(provider, (_, next) => _onStateChanged(next));
    final state = ref.watch(provider);

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(title: '프로필 편집'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Center(
            child: MoaProfileAvatar(
              userName: _nameController.text,
              color: state.color,
              size: 112,
            ),
          ),
          const SizedBox(height: 24),
          ProfileColorCard(
            userName: _nameController.text,
            selected: state.color,
            onSelected: ref.read(provider.notifier).select,
          ),
          const SizedBox(height: 24),
          _ProfileFields(
            nameController: _nameController,
            phoneController: _phoneController,
            emailController: _emailController,
            nameError: _nameError,
            phoneError: _phoneError,
            onChanged: _onChanged,
          ),
        ],
      ),
      bottomNavigationBar: AuthSubmitBar(
        label: '저장',
        isLoading: state.isSubmitting,
        onPressed: _save,
      ),
    );
  }
}

/// 이름·휴대폰·이메일(보기만) 입력칸
class _ProfileFields extends StatelessWidget {
  const _ProfileFields({
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.nameError,
    required this.phoneError,
    required this.onChanged,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String? nameError;
  final String? phoneError;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          label: '이름',
          controller: nameController,
          hintText: '이름을 입력하세요',
          helperText: '모임원에게 이 이름으로 보여요.',
          maxLength: 20,
          errorText: nameError,
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
          label: '이메일',
          controller: emailController,
          helperText: '가입한 이메일은 바꿀 수 없어요.',
          readOnly: true,
        ),
      ],
    );
  }
}
