import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_error_view.dart';

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
        leading: IconButton(
          onPressed: () => context.pop(),
          tooltip: '닫기',
          icon: const Icon(Icons.close, color: NoticeColors.text),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
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
                errorText: _showMissing && _isTitleMissing
                    ? '공지 제목을 입력해주세요'
                    : null,
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
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: _SubmitButton(
              label: _isEdit ? '수정 완료' : '공지 등록',
              isLoading: isSubmitting,
              onPressed: isSubmitting ? null : _submit,
            ),
          ),
        ),
      ],
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
