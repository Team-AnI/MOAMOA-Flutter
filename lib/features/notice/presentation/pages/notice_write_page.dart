import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_error_view.dart';

/// 공지 작성 화면. [noticeId] 가 있으면 수정 화면으로 동작합니다.
class NoticeWritePage extends ConsumerStatefulWidget {
  const NoticeWritePage({super.key, required this.meetingId, this.noticeId});

  final int meetingId;
  final int? noticeId;

  @override
  ConsumerState<NoticeWritePage> createState() => _NoticeWritePageState();
}

class _NoticeWritePageState extends ConsumerState<NoticeWritePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _prefilled = false;

  /// 등록을 한 번 누른 뒤부터 빠진 항목 안내를 보여줍니다. (예외처리 4-1)
  bool _showMissing = false;

  bool get _isEdit => widget.noticeId != null;

  @override
  void initState() {
    super.initState();
    final noticeId = widget.noticeId;
    if (noticeId == null) return;

    // 수정이면 기존 공지 내용을 채웁니다.
    ref.listenManual(
      noticeDetailProvider((meetingId: widget.meetingId, noticeId: noticeId)),
      (_, next) {
        final notice = next.value;
        if (notice != null) _prefill(notice);
      },
      fireImmediately: true,
    );
  }

  void _prefill(Notice notice) {
    if (_prefilled) return;
    _prefilled = true;
    _titleController.text = notice.title;
    _contentController.text = notice.content ?? '';
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
          noticeId: widget.noticeId,
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(noticeErrorMessage(error)),
        action: SnackBarAction(label: '다시 시도', onPressed: _submit),
      ),
    );
  }

  /// 안내가 보이는 중에는 입력할 때마다 빠진 항목을 다시 확인합니다.
  void _onChanged(String _) {
    if (_showMissing) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref
        .watch(noticeWriteProvider(widget.meetingId))
        .isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          tooltip: '닫기',
          icon: const Icon(Icons.close, color: NoticeColors.text),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          Text(
            _isEdit ? '공지 수정' : '공지 작성',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: NoticeColors.text,
            ),
          ),
          const SizedBox(height: 24),
          _InputField(
            label: '제목',
            hintText: '공지 제목을 입력하세요',
            controller: _titleController,
            errorText: _showMissing && _isTitleMissing ? '공지 제목을 입력해주세요' : null,
            onChanged: _onChanged,
          ),
          const SizedBox(height: 20),
          _InputField(
            label: '내용',
            hintText: '구성원에게 전할 내용을 입력하세요',
            controller: _contentController,
            minLines: 8,
            errorText: _showMissing && _isContentMissing
                ? '공지 내용을 입력해주세요'
                : null,
            onChanged: _onChanged,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: _SubmitButton(
            label: _isEdit ? '수정 완료' : '공지 등록',
            isLoading: isSubmitting,
            onPressed: isSubmitting ? null : _submit,
          ),
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
    this.errorText,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int minLines;

  /// 값이 있으면 입력칸 아래에 빠진 항목 안내를 보여줍니다.
  final String? errorText;

  static final _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: NoticeColors.error),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: NoticeColors.bodyText,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: minLines == 1 ? 1 : null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: NoticeColors.hint),
            errorText: errorText,
            filled: true,
            fillColor: NoticeColors.gray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: _errorBorder,
            focusedErrorBorder: _errorBorder,
            errorStyle: const TextStyle(
              fontSize: 12,
              color: NoticeColors.error,
            ),
          ),
        ),
      ],
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
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: NoticeColors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
