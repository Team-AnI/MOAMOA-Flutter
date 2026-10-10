import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/group_join_flow.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/group_repository.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_field.dart';
import '../widgets/group_info_step.dart';
import '../widgets/group_join_summary.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_page_title.dart';
import '../widgets/group_photo_sheet.dart';
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
  bool _previewing = false;
  bool _approval = false;
  bool _previewApproval = false;
  Group? _preview;
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
    if (_previewing ||
        _pickingPhoto ||
        ref.read(groupProvider).isSubmitting ||
        ref.read(groupProvider).isLoading) {
      return;
    }
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
    final repository = ref.read(groupRepositoryProvider);
    final joinFlow = repository is GroupJoinFlow
        ? repository as GroupJoinFlow
        : null;
    if (widget.isJoining &&
        _step == 1 &&
        ref.read(groupUseMockProvider) &&
        joinFlow != null) {
      FocusScope.of(context).unfocus();
      setState(() => _previewing = true);
      try {
        final group = await joinFlow.previewInviteCode(_nameOrCode.text);
        if (mounted) {
          setState(() {
            _preview = group;
            _previewApproval = joinFlow.requiresApproval(group.id);
            _step = 2;
          });
        }
      } on GroupFailure catch (failure) {
        if (mounted) {
          setState(() {
            _alreadyJoined = failure.reason == GroupFailureReason.alreadyJoined;
            _error = _alreadyJoined ? '이미 가입한 모임입니다.' : '초대 코드를 확인해주세요.';
          });
        }
      } finally {
        if (mounted) setState(() => _previewing = false);
      }
      return;
    }
    if (widget.isJoining &&
        _previewApproval &&
        joinFlow != null &&
        ref.read(groupUseMockProvider)) {
      setState(() => _previewing = true);
      try {
        await joinFlow.requestJoin(_nameOrCode.text);
        if (!mounted) return;
        ref
            .read(groupMockPendingProvider.notifier)
            .update(joinFlow.pendingRequests);
        context.go('/groups/requested');
      } on GroupFailure {
        if (mounted) setState(() => _error = '가입 요청을 보내지 못했습니다.');
      } finally {
        if (mounted) setState(() => _previewing = false);
      }
      return;
    }
    final viewModel = ref.read(groupProvider.notifier);
    final result = widget.isJoining
        ? await viewModel.join(_nameOrCode.text)
        : await viewModel.create(
            name: _nameOrCode.text,
            description: _description.text,
          );
    if (!mounted) return;
    if (result != null) {
      if (!widget.isJoining &&
          _approval &&
          ref.read(groupUseMockProvider) &&
          joinFlow != null) {
        joinFlow.setApprovalRequired(result.group.id);
      }
      if (!widget.isJoining &&
          _photo != null &&
          ref.read(groupUseMockProvider)) {
        ref
            .read(groupMockPhotosProvider.notifier)
            .save(result.group.id, _photo!);
      }
      context.go(widget.isJoining ? '/groups/joined' : '/groups/created');
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
    final busy =
        submitting ||
        _previewing ||
        ref.watch(groupProvider.select((state) => state.isLoading));
    return PopScope(
      canPop: _step == 1 && !busy,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !busy && _step == 2) setState(() => _step = 1);
      },
      child: GroupPageLayout(
        title: widget.isJoining ? null : '모임 만들기',
        isBack: widget.isJoining,
        onClose: busy
            ? null
            : () {
                if (widget.isJoining && _step == 2) {
                  setState(() {
                    _step = 1;
                    _error = null;
                  });
                } else {
                  context.go('/groups');
                }
              },
        step: widget.isJoining ? null : _step,
        bottom: GroupPrimaryButton(
          label: busy
              ? '처리 중…'
              : widget.isJoining
              ? (_step == 1 && ref.watch(groupUseMockProvider)
                    ? '다음'
                    : (_previewApproval ? '가입 요청 보내기' : '가입하기'))
              : _step == 1
              ? '다음'
              : '모임 만들기',
          onPressed: busy || _pickingPhoto ? null : _submit,
        ),
        child: _GroupFormContent(
          formKey: _formKey,
          joining: widget.isJoining,
          step: _step,
          preview: _preview,
          previewApproval: _previewApproval,
          nameOrCode: _nameOrCode,
          description: _description,
          photo: _photo,
          pickingPhoto: _pickingPhoto,
          busy: busy,
          approval: _approval,
          error: _error,
          alreadyJoined: _alreadyJoined,
          onPhotoAction: _pickPhoto,
          onChanged: (_) => setState(() {}),
          onApprovalChanged: ref.watch(groupUseMockProvider)
              ? (value) => setState(() => _approval = value)
              : null,
          onEdit: busy ? null : () => setState(() => _step = 1),
        ),
      ),
    );
  }
}

/// 입력 단계와 결과 안내를 렌더링합니다. 제출·사진 선택 상태는 페이지가 소유합니다.
class _GroupFormContent extends ConsumerWidget {
  const _GroupFormContent({
    required this.formKey,
    required this.joining,
    required this.step,
    this.preview,
    required this.previewApproval,
    required this.nameOrCode,
    required this.description,
    this.photo,
    required this.pickingPhoto,
    required this.busy,
    required this.approval,
    this.error,
    required this.alreadyJoined,
    required this.onPhotoAction,
    required this.onChanged,
    this.onApprovalChanged,
    this.onEdit,
  });
  final GlobalKey<FormState> formKey;
  final bool joining,
      previewApproval,
      pickingPhoto,
      busy,
      approval,
      alreadyJoined;
  final int step;
  final Group? preview;
  final TextEditingController nameOrCode, description;
  final Uint8List? photo;
  final String? error;
  final ValueChanged<GroupPhotoAction> onPhotoAction;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool>? onApprovalChanged;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (joining && step == 2 && preview != null)
          GroupJoinSummary(group: preview!, approval: previewApproval)
        else if (joining) ...[
          const GroupPageTitle(
            title: '초대 코드를 입력해 주세요',
            subtitle: '모임 관리자에게 받은 코드로 가입할 수 있어요.',
          ),
          GroupField(
            controller: nameOrCode,
            label: '초대 코드',
            hint: '초대 코드를 입력해주세요',
            requiredValue: true,
            enabled: !busy,
          ),
        ] else if (step == 1)
          GroupProfileStep(
            name: nameOrCode,
            photo: photo,
            pickingPhoto: pickingPhoto,
            onPhotoAction: onPhotoAction,
            onChanged: onChanged,
          )
        else
          GroupInfoStep(
            name: nameOrCode.text.trim(),
            description: description,
            photo: photo,
            approval: approval,
            onApprovalChanged: onApprovalChanged,
            adminName: ref.watch(groupCurrentUserNameProvider),
            enabled: !busy,
            onEdit: onEdit,
          ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              error!,
              style: GroupDesign.body.copyWith(color: const Color(0xffe30000)),
            ),
          ),
        if (alreadyJoined)
          TextButton(
            onPressed: () => context.go('/groups'),
            child: const Text('기존 모임 목록으로 이동'),
          ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
