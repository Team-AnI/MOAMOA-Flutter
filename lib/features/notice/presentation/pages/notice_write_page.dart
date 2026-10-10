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
            onPressed: () => context.pop(),
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

/// 제목·내용 입력칸, 중요 공지·고정 설정, 등록 버튼
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

  /// 목록 맨 위에 고정. 수정일 때는 현재 고정 여부로 시작합니다.
  late bool _pinToTop = widget.initialNotice?.isPinned ?? false;

  /// 중요 공지로 표시. 수정일 때는 현재 값으로 시작합니다.
  late bool _isImportant = widget.initialNotice?.isImportant ?? false;

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
          pinToTop: _pinToTop,
          wasPinned: widget.initialNotice?.isPinned ?? false,
          isImportant: _isImportant,
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
              if (_isEdit)
                const SizedBox(height: 8)
              else ...[
                const SizedBox(height: 4),
                const Text(
                  '공지 작성',
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.35,
                    letterSpacing: -0.7,
                    fontWeight: FontWeight.w700,
                    color: NoticeColors.text,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              _InputField(
                label: '제목',
                hintText: '공지 제목을 입력하세요',
                controller: _titleController,
                errorText: _showMissing && _isTitleMissing
                    ? '공지 제목을 입력해주세요'
                    : null,
                onChanged: _onChanged,
              ),
              const SizedBox(height: 16),
              _InputField(
                label: '내용',
                hintText: '구성원에게 전할 내용을 입력하세요',
                controller: _contentController,
                minLines: 5,
                errorText: _showMissing && _isContentMissing
                    ? '공지 내용을 입력해주세요'
                    : null,
                onChanged: _onChanged,
              ),
              const SizedBox(height: 16),
              _ImportantCard(
                value: _isImportant,
                onChanged: (value) => setState(() => _isImportant = value),
              ),
              const SizedBox(height: 16),
              _PinToggle(
                value: _pinToTop,
                onChanged: (value) => setState(() => _pinToTop = value),
              ),
              if (_isEdit) ...[const SizedBox(height: 16), const _EditHint()],
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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

  static OutlineInputBorder _border(BorderSide side) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: side,
  );

  @override
  Widget build(BuildContext context) {
    final isMultiline = minLines > 1;
    final errorBorder = _border(const BorderSide(color: NoticeColors.error));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: isMultiline ? null : 1,
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

/// "중요 공지로 표시" 체크 카드. 체크하면 빨간 테두리가 생깁니다.
class _ImportantCard extends StatelessWidget {
  const _ImportantCard({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: value,
      label: '중요 공지로 표시',
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NoticeColors.gray,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: value ? NoticeColors.alert : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: value ? NoticeColors.alertTint : Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 20,
                  color: NoticeColors.alert,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '중요 공지로 표시',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.47,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        color: NoticeColors.text,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '중요 표시가 붙고, 안 읽은 사람에게 다시 알려요',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.33,
                        color: NoticeColors.bodyText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: value ? NoticeColors.text : Colors.transparent,
                  shape: BoxShape.circle,
                  border: value
                      ? null
                      : Border.all(color: NoticeColors.disabled, width: 1.5),
                ),
                child: value
                    ? const Icon(Icons.check, size: 13, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 목록 맨 위에 고정 토글
class _PinToggle extends StatelessWidget {
  const _PinToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: NoticeColors.gray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '목록 맨 위에 고정',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.47,
                  letterSpacing: -0.2,
                  color: NoticeColors.text,
                ),
              ),
            ),
            _Toggle(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

/// 50x30 알약 모양 토글
class _Toggle extends StatelessWidget {
  const _Toggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 50,
          height: 30,
          padding: const EdgeInsets.all(2),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: value ? NoticeColors.text : NoticeColors.switchOff,
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 수정 화면 안내 문구
class _EditHint extends StatelessWidget {
  const _EditHint();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(
              Icons.info_outline,
              size: 18,
              color: NoticeColors.bodyText,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '저장하면 공지에 수정됨 표시가 붙어요.',
              style: TextStyle(
                fontSize: 14,
                height: 1.43,
                letterSpacing: -0.1,
                color: NoticeColors.bodyText,
              ),
            ),
          ),
        ],
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
