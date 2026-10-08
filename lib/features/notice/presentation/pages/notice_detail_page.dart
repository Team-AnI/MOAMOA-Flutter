import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../viewmodels/notice_detail_view_model.dart';
import '../widgets/notice_colors.dart';
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('공지를 삭제할까요?'),
        content: const Text('삭제한 공지는 되돌릴 수 없어요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    try {
      await ref.read(noticeDetailProvider(_args).notifier).delete();
      if (context.mounted) context.pop();
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(noticeErrorMessage(error))));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notice = ref.watch(noticeDetailProvider(_args));
    final isAdmin =
        ref.watch(noticeMyRoleProvider(meetingId)).value?.isAdmin ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          tooltip: '뒤로',
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: NoticeColors.text,
          ),
        ),
        actions: [
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
            const SizedBox(width: 12),
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
      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(backgroundColor: NoticeColors.gray),
      icon: Icon(icon, size: 20, color: NoticeColors.icon),
    );
  }
}

class _NoticeContent extends StatelessWidget {
  const _NoticeContent({required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final createdAt = notice.createdAt;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notice.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: NoticeColors.text,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${createdAt.month}월 ${createdAt.day}일',
            style: const TextStyle(fontSize: 13, color: NoticeColors.subText),
          ),
          const SizedBox(height: 20),
          Text(
            notice.content ?? '',
            style: const TextStyle(
              fontSize: 15,
              height: 1.7,
              color: NoticeColors.bodyText,
            ),
          ),
        ],
      ),
    );
  }
}
