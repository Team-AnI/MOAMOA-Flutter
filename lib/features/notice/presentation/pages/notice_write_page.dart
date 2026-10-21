import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_dialogs.dart';
import '../widgets/notice_error_view.dart';

/// 공지 제목 최대 길이. API 계약(3-1, 3-4)에서 확정되었고, 넘으면 서버가 400 VALIDATION_ERROR 로 응답합니다.
const _titleMaxLength = 50;

/// 공지 작성 화면. [noticeId] 가 있으면 수정 화면으로 동작합니다.
///
/// 수정일 때는 기존 공지를 다 불러온 뒤에 입력칸을 만듭니다.
/// 불러오는 동안 입력하면 늦게 도착한 응답이 입력을 덮어쓸 수 있기 때문입니다.
class NoticeWritePage extends ConsumerWidget {
  const NoticeWritePage({super.key, required this.meetingId, this.noticeId});

  final int meetingId;
  final int? noticeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 56,
        leadingWidth: 56,
        centerTitle: true,
        // 수정 화면은 상단 바 가운데에 제목이 있고, 작성 화면은 본문 위에 큰 제목이 있습니다.
        title: noticeId == null
            ? null
            : const Text(
                '공지 수정',
                style: TextStyle(
                  fontSize: 17,
                  height: 1.41,
                  letterSpacing: -0.3,
                  fontWeight: FontWeight.w600,
                  color: NoticeColors.text,
                ),
              ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            // maybePop 은 아래 폼의 PopScope(입력 중 취소 확인)를 거칩니다.
            onPressed: () => Navigator.of(context).maybePop(),
            tooltip: '닫기',
            constraints: const BoxConstraints.tightFor(width: 40, height: 40),
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.close, size: 20, color: NoticeColors.text),
          ),
        ),
      ),
      body: _buildBody(context, ref),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final noticeId = this.noticeId;
    if (noticeId == null) return _NoticeForm(meetingId: meetingId);

    final args = (meetingId: meetingId, noticeId: noticeId);
    return ref
        .watch(noticeDetailProvider(args))
        .when(
          data: (notice) =>
              _NoticeForm(meetingId: meetingId, initialNotice: notice),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => isNoticeNotFound(error)
              ? NoticeErrorView(
                  error: error,
                  message: '삭제되었거나 존재하지 않는 공지입니다.',
                  actionLabel: '목록으로',
                  onAction: () => context.go('/meetings/$meetingId/notices'),
                )
              : NoticeErrorView(
                  error: error,
                  onAction: () => ref.invalidate(noticeDetailProvider(args)),
                ),
        );
  }
}

/// 제목·내용 입력칸과 등록 버튼
///
/// [initialNotice] 가 있으면 수정 모드이며, 처음 만들어질 때 한 번만 기존 내용을 채웁니다.
class _NoticeForm extends ConsumerStatefulWidget {
  const _NoticeForm({required this.meetingId, this.initialNotice});

  final int meetingId;
  final Notice? initialNotice;

  @override
  ConsumerState<_NoticeForm> createState() => _NoticeFormState();
}

class _NoticeFormState extends ConsumerState<_NoticeForm> {
  late final _titleController = TextEditingController(
    text: widget.initialNotice?.title,
  );
  late final _contentController = TextEditingController(
    text: widget.initialNotice?.content,
  );

  /// 등록을 한 번 누른 뒤부터 빠진 항목 안내를 보여줍니다. (예외처리 4-1)
  bool _showMissing = false;

  bool get _isEdit => widget.initialNotice != null;

  /// 처음 열렸을 때와 입력 내용이 다르면 true. (작성은 비어 있는 상태가 기준)
  ///
  /// 서버로 보낼 때 앞뒤 공백을 지우므로, 공백만 다른 경우는 바뀐 것으로 보지 않습니다.
  bool get _hasChanges {
    final initial = widget.initialNotice;
    return _titleController.text.trim() != (initial?.title ?? '').trim() ||
        _contentController.text.trim() != (initial?.content ?? '').trim();
  }

  /// 입력 중에 뒤로 가면 내용이 사라지므로 한 번 확인합니다.
  Future<void> _confirmLeave() async {
    final leave = await showNoticeConfirmDialog(
      context,
      title: _isEdit ? '수정을 취소할까요?' : '작성을 취소할까요?',
      message: '입력한 내용이 사라져요.',
      confirmLabel: '나가기',
      cancelLabel: '계속 작성',
    );
    if (leave == true && mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  bool get _isTitleMissing => _titleController.text.trim().isEmpty;
  bool get _isContentMissing => _contentController.text.trim().isEmpty;

  Future<void> _submit() async {
    // 필수값이 빠지면 빠진 항목을 안내하고 등록하지 않습니다. (예외처리 4-1)
    if (_isTitleMissing || _isContentMissing) {
      setState(() => _showMissing = true);
      return;
    }

    final success = await ref
        .read(noticeWriteProvider(widget.meetingId).notifier)
        .submit(
          noticeId: widget.initialNotice?.id,
          title: _titleController.text,
          content: _contentController.text,
        );
    if (!mounted) return;
    if (success) {
      context.pop();
      return;
    }
    // 작성한 내용은 그대로 두고 다시 시도할 수 있게 안내합니다. (예외처리 4-3)
    final error = ref.read(noticeWriteProvider(widget.meetingId)).error;
    showNoticeSnackBar(
      context,
      noticeErrorMessage(error),
      actionLabel: '다시 시도',
      onAction: _submit,
    );
  }

  /// 입력할 때마다 화면을 다시 그려, 빠진 항목 안내와 닫기 확인 여부(_hasChanges),
  /// 수정 완료 버튼의 활성 여부를 최신 입력값 기준으로 맞춥니다.
  void _onChanged(String _) => setState(() {});

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref
        .watch(noticeWriteProvider(widget.meetingId))
        .isLoading;
    // 수정 화면은 바뀐 내용이 없으면 저장할 것이 없으므로 버튼을 누를 수 없게 합니다.
    final canSubmit = !isSubmitting && (!_isEdit || _hasChanges);

    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmLeave();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _NoticeFormFields(
              isEdit: _isEdit,
              titleController: _titleController,
              contentController: _contentController,
              showTitleMissing: _showMissing && _isTitleMissing,
              showContentMissing: _showMissing && _isContentMissing,
              onChanged: _onChanged,
            ),
          ),
          _SubmitBar(
            label: _isEdit ? '수정 완료' : '공지 등록',
            isLoading: isSubmitting,
            onPressed: canSubmit ? _submit : null,
          ),
        ],
      ),
    );
  }
}

/// 제목·내용 입력칸. 작성 화면은 위에 큰 제목이 있고, 수정 화면은 상단 바에 제목이 있습니다.
class _NoticeFormFields extends StatelessWidget {
  const _NoticeFormFields({
    required this.isEdit,
    required this.titleController,
    required this.contentController,
    required this.showTitleMissing,
    required this.showContentMissing,
    required this.onChanged,
  });

  final bool isEdit;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final bool showTitleMissing;
  final bool showContentMissing;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        if (isEdit)
          const SizedBox(height: 8)
        else ...[
          const SizedBox(height: 4),
          const _WritePageTitle(),
          const SizedBox(height: 24),
        ],
        _InputField(
          label: '제목',
          hintText: '공지 제목을 입력하세요',
          controller: titleController,
          maxLength: _titleMaxLength,
          errorText: showTitleMissing ? '공지 제목을 입력해주세요' : null,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        _InputField(
          label: '내용',
          hintText: '구성원에게 전할 내용을 입력하세요',
          controller: contentController,
          minLines: 5,
          errorText: showContentMissing ? '공지 내용을 입력해주세요' : null,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _WritePageTitle extends StatelessWidget {
  const _WritePageTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '공지 작성',
      style: TextStyle(
        fontSize: 26,
        height: 1.35,
        letterSpacing: -0.7,
        fontWeight: FontWeight.w700,
        color: NoticeColors.text,
      ),
    );
  }
}

/// 화면 아래의 등록 버튼 줄
class _SubmitBar extends StatelessWidget {
  const _SubmitBar({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: _SubmitButton(
          label: label,
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.minLines = 1,
    this.maxLength,
    this.errorText,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int minLines;

  /// 값이 있으면 입력할 수 있는 글자 수를 제한하고 현재 글자 수를 보여줍니다.
  final int? maxLength;

  /// 값이 있으면 입력칸 아래에 빠진 항목 안내를 보여줍니다.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InputLabel(label),
        const SizedBox(height: 8),
        _InputTextField(
          hintText: hintText,
          controller: controller,
          onChanged: onChanged,
          minLines: minLines,
          maxLength: maxLength,
          errorText: errorText,
        ),
      ],
    );
  }
}

class _InputLabel extends StatelessWidget {
  const _InputLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          height: 1.43,
          letterSpacing: -0.1,
          fontWeight: FontWeight.w600,
          color: NoticeColors.bodyText,
        ),
      ),
    );
  }
}

class _InputTextField extends StatelessWidget {
  const _InputTextField({
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.minLines,
    this.maxLength,
    this.errorText,
  });

  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int minLines;
  final int? maxLength;
  final String? errorText;

  static OutlineInputBorder _border(BorderSide side) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: side,
  );

  @override
  Widget build(BuildContext context) {
    final isMultiline = minLines > 1;
    final errorBorder = _border(const BorderSide(color: NoticeColors.error));

    return TextField(
      controller: controller,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: isMultiline ? null : 1,
      maxLength: maxLength,
      style: const TextStyle(
        fontSize: 15,
        height: 1.47,
        letterSpacing: -0.2,
        color: NoticeColors.text,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: NoticeColors.hint),
        errorText: errorText,
        filled: true,
        fillColor: NoticeColors.gray,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: isMultiline ? 20 : 16,
        ),
        border: _border(BorderSide.none),
        enabledBorder: _border(BorderSide.none),
        focusedBorder: _border(
          const BorderSide(color: NoticeColors.text, width: 2),
        ),
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        errorStyle: const TextStyle(fontSize: 12, color: NoticeColors.error),
        counterStyle: const TextStyle(
          fontSize: 12,
          color: NoticeColors.subText,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: NoticeColors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.25,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
