import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../notice_format.dart';
import '../providers/notice_providers.dart';
import '../viewmodels/notice_detail_view_model.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_dialogs.dart';
import '../widgets/notice_error_view.dart';
import '../widgets/notice_role_retry_button.dart';

/// 공지 상세 화면
class NoticeDetailPage extends ConsumerStatefulWidget {
  const NoticeDetailPage({
    super.key,
    required this.meetingId,
    required this.noticeId,
  });

  final int meetingId;
  final int noticeId;

  @override
  ConsumerState<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends ConsumerState<NoticeDetailPage> {
  /// 삭제 요청이 진행 중인 동안 버튼을 다시 누르지 못하게 합니다.
  bool _isDeleting = false;

  NoticeDetailArgs get _args =>
      (meetingId: widget.meetingId, noticeId: widget.noticeId);

  /// 이 모임의 공지 목록 경로
  String get _listPath => '/meetings/${widget.meetingId}/notices';

  Future<void> _delete() async {
    if (_isDeleting) return;

    final confirmed = await showNoticeConfirmDialog(
      context,
      title: '공지를 삭제할까요?',
      message: '삭제한 공지는 되돌릴 수 없어요.',
      confirmLabel: '삭제',
    );
    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);
    try {
      await ref.read(noticeDetailProvider(_args).notifier).delete();
      if (!mounted) return;
      // 스낵바는 화면이 닫힌 뒤에도 이어서 보이므로 목록에서 삭제 결과를 알 수 있습니다.
      showNoticeSnackBar(context, '공지를 삭제했어요.');
      // 목록 없이 단독으로 열린 상세라 닫을 화면이 없으면 목록으로 이동합니다.
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(_listPath);
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _isDeleting = false);
      showNoticeSnackBar(context, noticeErrorMessage(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final notice = ref.watch(noticeDetailProvider(_args));
    final role = ref.watch(noticeMyRoleProvider(widget.meetingId));
    final isAdmin = role.value?.isAdmin ?? false;

    // 삭제 요청 중에는 화면을 닫지 않습니다. 닫으면 삭제 결과 안내와 목록 새로고침이 빠집니다.
    return PopScope(
      canPop: !_isDeleting,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _DetailAppBar(
          onBack: _isDeleting ? null : () => context.pop(),
          onRetryRole: role.hasError && notice.hasValue
              ? () => ref.invalidate(noticeMyRoleProvider(widget.meetingId))
              : null,
          // 수정 화면은 작성 화면을 재사용하며, 기존 제목·내용이 채워진 채로 열립니다.
          onEdit: isAdmin && notice.hasValue
              ? () => context.push(
                  '/meetings/${widget.meetingId}/notices/${widget.noticeId}/edit',
                )
              : null,
          onDelete: isAdmin && notice.hasValue ? _delete : null,
          isDeleting: _isDeleting,
        ),
        body: notice.when(
          data: (notice) => _NoticeContent(notice: notice),
          loading: () => const Center(child: CircularProgressIndicator()),
          // 삭제되었거나 없는 공지는 안내하고 목록으로 보냅니다. (예외처리 4-6)
          error: (error, _) => isNoticeNotFound(error)
              ? NoticeErrorView(
                  error: error,
                  message: '삭제되었거나 존재하지 않는 공지입니다.',
                  actionLabel: '목록으로',
                  onAction: () => context.go(_listPath),
                )
              : NoticeErrorView(
                  error: error,
                  onAction: () => ref.invalidate(noticeDetailProvider(_args)),
                ),
        ),
      ),
    );
  }
}

/// 뒤로 가기 + (관리자만) 수정 · 삭제 버튼 / (역할 조회 실패 시) 다시 시도 버튼
class _DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DetailAppBar({
    required this.onBack,
    this.onRetryRole,
    this.onEdit,
    this.onDelete,
    this.isDeleting = false,
  });

  /// null 이면 뒤로 갈 수 없습니다. (삭제 요청 중)
  final VoidCallback? onBack;
  final VoidCallback? onRetryRole;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  /// true 이면 수정 · 삭제를 누를 수 없고, 삭제 버튼에 진행 표시를 보여줍니다.
  final bool isDeleting;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final onRetryRole = this.onRetryRole;
    final onEdit = this.onEdit;
    final onDelete = this.onDelete;

    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 56,
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          onPressed: onBack,
          tooltip: '뒤로',
          constraints: const BoxConstraints.tightFor(width: 40, height: 40),
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.chevron_left,
            size: 24,
            color: NoticeColors.text,
          ),
        ),
      ),
      actions: [
        if (onRetryRole != null) NoticeRoleRetryButton(onPressed: onRetryRole),
        if (onEdit != null && onDelete != null) ...[
          _CircleIconButton(
            icon: Icons.edit_outlined,
            tooltip: '공지 수정',
            onPressed: isDeleting ? null : onEdit,
          ),
          const SizedBox(width: 8),
          _CircleIconButton(
            icon: Icons.delete_outline,
            tooltip: '공지 삭제',
            onPressed: isDeleting ? null : onDelete,
            isLoading: isDeleting,
          ),
          const SizedBox(width: 16),
        ],
      ],
    );
  }
}

/// 상단 오른쪽의 회색 원 아이콘 버튼 (수정 / 삭제)
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isLoading = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      tooltip: tooltip,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        backgroundColor: NoticeColors.gray,
        disabledBackgroundColor: NoticeColors.gray,
      ),
      icon: isLoading
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: NoticeColors.text,
              ),
            )
          : Icon(icon, size: 20, color: NoticeColors.text),
    );
  }
}

/// 제목 · 작성일 · 본문
class _NoticeContent extends StatelessWidget {
  const _NoticeContent({required this.notice});

  final Notice notice;

  static const _bodyStyle = TextStyle(
    fontSize: 15,
    height: 1.47,
    letterSpacing: -0.2,
    color: NoticeColors.text,
  );

  @override
  Widget build(BuildContext context) {
    // 줄바꿈으로 나뉜 문단 사이를 14 만큼 띄웁니다.
    final paragraphs = (notice.content ?? '')
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notice.title,
            style: const TextStyle(
              fontSize: 26,
              height: 1.35,
              letterSpacing: -0.7,
              fontWeight: FontWeight.w700,
              color: NoticeColors.text,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            formatNoticeDate(notice.createdAt),
            style: const TextStyle(
              fontSize: 14,
              height: 1.43,
              letterSpacing: -0.1,
              color: NoticeColors.bodyText,
            ),
          ),
          const SizedBox(height: 24),
          for (final paragraph in paragraphs) ...[
            Text(paragraph, style: _bodyStyle),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
