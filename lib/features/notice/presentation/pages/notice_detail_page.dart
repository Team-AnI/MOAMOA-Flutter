import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../viewmodels/notice_detail_view_model.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_dialogs.dart';
import '../widgets/notice_error_view.dart';

/// 공지 상세 화면
class NoticeDetailPage extends ConsumerWidget {
  const NoticeDetailPage({
    super.key,
    required this.meetingId,
    required this.noticeId,
  });

  final int meetingId;
  final int noticeId;

  NoticeDetailArgs get _args => (meetingId: meetingId, noticeId: noticeId);

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showNoticeConfirmDialog(
      context,
      title: '공지를 삭제할까요?',
      message: '삭제한 공지는 되돌릴 수 없어요.',
      confirmLabel: '삭제',
    );
    if (confirmed != true || !context.mounted) return;

    try {
      await ref.read(noticeDetailProvider(_args).notifier).delete();
      if (context.mounted) context.pop();
    } catch (error) {
      if (!context.mounted) return;
      _showError(context, error);
    }
  }

  void _showError(BuildContext context, Object error) {
    showNoticeSnackBar(context, noticeErrorMessage(error));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notice = ref.watch(noticeDetailProvider(_args));
    final role = ref.watch(noticeMyRoleProvider(meetingId));
    final isAdmin = role.value?.isAdmin ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 56,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () => context.pop(),
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
          if (role.hasError && notice.hasValue)
            NoticeRoleRetryButton(
              onPressed: () => ref.invalidate(noticeMyRoleProvider(meetingId)),
            ),
          if (isAdmin && notice.hasValue) ...[
            // 수정 화면은 작성 화면을 재사용하며, 기존 제목·내용이 채워진 채로 열립니다.
            _CircleIconButton(
              icon: Icons.edit_outlined,
              tooltip: '공지 수정',
              onPressed: () =>
                  context.push('/meetings/$meetingId/notices/$noticeId/edit'),
            ),
            const SizedBox(width: 8),
            _CircleIconButton(
              icon: Icons.delete_outline,
              tooltip: '공지 삭제',
              onPressed: () => _delete(context, ref),
            ),
            const SizedBox(width: 16),
          ],
        ],
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
                onAction: () => context.go('/meetings/$meetingId/notices'),
              )
            : NoticeErrorView(
                error: error,
                onAction: () => ref.invalidate(noticeDetailProvider(_args)),
              ),
      ),
    );
  }
}

/// 상단 오른쪽의 회색 원 아이콘 버튼 (수정 / 삭제)
class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      tooltip: tooltip,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(backgroundColor: NoticeColors.gray),
      icon: Icon(icon, size: 20, color: NoticeColors.text),
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
            '${notice.createdAt.month}월 ${notice.createdAt.day}일',
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
