import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/group_photo_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/repositories/group_repository.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_field.dart';
import '../widgets/group_info_step.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';
import '../widgets/group_primary_button.dart';
import '../widgets/group_profile_step.dart';

class GroupFormPage extends ConsumerStatefulWidget {
  const GroupFormPage({super.key, required this.isJoining});
  final bool isJoining;
  @override
  ConsumerState<GroupFormPage> createState() => _GroupFormPageState();
}

class _GroupFormPageState extends ConsumerState<GroupFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameOrCode = TextEditingController();
  final _description = TextEditingController();
  Uint8List? _photo;
  bool _pickingPhoto = false;
  int _step = 1;
  String? _error;
  bool _alreadyJoined = false;
  @override
  void dispose() {
    _nameOrCode.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(GroupPhotoAction action) async {
    if (!mounted || _pickingPhoto) return;
    if (action == GroupPhotoAction.reset) {
      setState(() => _photo = null);
      return;
    }
    setState(() => _pickingPhoto = true);
    try {
      final file = await ref
          .read(groupImagePickerProvider)
          .pickImage(
            source: action == GroupPhotoAction.gallery
                ? ImageSource.gallery
                : ImageSource.camera,
            maxWidth: 1200,
            maxHeight: 1200,
            imageQuality: 85,
            requestFullMetadata: false,
          );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (mounted) setState(() => _photo = bytes);
    } on PlatformException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.code.contains('denied') || error.code.contains('restricted')
                  ? '사진 또는 카메라 권한을 설정에서 허용해주세요.'
                  : '사진을 가져오지 못했습니다. 카메라는 실제 기기에서 확인해주세요.',
            ),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사진을 가져오지 못했습니다. 다시 시도해주세요.')),
        );
      }
    } finally {
      if (mounted) setState(() => _pickingPhoto = false);
    }
  }

  Future<void> _submit() async {
    if (_pickingPhoto || ref.read(groupProvider).isSubmitting) return;
    if (!_formKey.currentState!.validate()) return;
    if (!widget.isJoining && _step == 1) {
      FocusScope.of(context).unfocus();
      setState(() => _step = 2);
      return;
    }
    setState(() {
      _error = null;
      _alreadyJoined = false;
    });
    final viewModel = ref.read(groupProvider.notifier);
    final result = widget.isJoining
        ? await viewModel.join(_nameOrCode.text)
        : await viewModel.create(
            name: _nameOrCode.text,
            description: _description.text,
          );
    if (!mounted) return;
    if (result != null) {
      context.go(widget.isJoining ? '/groups/home' : '/groups/created');
    } else {
      setState(() {
        final state = ref.read(groupProvider);
        _error = state.errorMessage;
        _alreadyJoined =
            state.failureReason == GroupFailureReason.alreadyJoined;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitting = ref.watch(
      groupProvider.select((state) => state.isSubmitting),
    );
    return PopScope(
      canPop: _step == 1 && !submitting,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !submitting && _step == 2) setState(() => _step = 1);
      },
      child: GroupPageLayout(
        title: widget.isJoining ? null : '모임 만들기',
        isBack: widget.isJoining,
        onClose: submitting ? null : () => context.go('/groups'),
        step: widget.isJoining ? null : _step,
        bottom: GroupPrimaryButton(
          label: submitting
              ? '처리 중…'
              : widget.isJoining
              ? '가입하기'
              : _step == 1
              ? '다음'
              : '모임 만들기',
          onPressed: submitting || _pickingPhoto ? null : _submit,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.isJoining) ...[
                const GroupPageTitle(
                  title: '초대 코드를 입력해 주세요',
                  subtitle: '모임 관리자에게 받은 코드로 가입할 수 있어요.',
                ),
                GroupField(
                  controller: _nameOrCode,
                  label: '초대 코드',
                  hint: '초대 코드를 입력해주세요',
                  requiredValue: true,
                  enabled: !submitting,
                ),
              ] else if (_step == 1)
                GroupProfileStep(
                  name: _nameOrCode,
                  photo: _photo,
                  pickingPhoto: _pickingPhoto,
                  onPhotoAction: _pickPhoto,
                  onChanged: (_) => setState(() {}),
                )
              else
                GroupInfoStep(
                  name: _nameOrCode.text.trim(),
                  description: _description,
                  photo: _photo,
                  adminName: ref.watch(groupCurrentUserNameProvider),
                  enabled: !submitting,
                  onEdit: submitting ? null : () => setState(() => _step = 1),
                ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _error!,
                    style: GroupDesign.body.copyWith(
                      color: const Color(0xffe30000),
                    ),
                  ),
                ),
              if (_alreadyJoined)
                TextButton(
                  onPressed: () => context.go('/groups'),
                  child: const Text('기존 모임 목록으로 이동'),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
