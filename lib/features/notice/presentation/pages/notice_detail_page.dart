import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../../domain/entities/notice_account.dart';
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
      _showError(context, error);
    }
  }

  Future<void> _togglePin(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(noticeDetailProvider(_args).notifier).togglePin();
    } catch (error) {
      if (!context.mounted) return;
      _showError(context, error);
    }
  }

  void _showError(BuildContext context, Object error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(noticeErrorMessage(error))));
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
            const SizedBox(width: 12),
          ],
        ],
      ),
      body: notice.when(
        data: (notice) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _NoticeContent(notice: notice)),
            if (isAdmin)
              _PinButton(
                isPinned: notice.isPinned,
                onPressed: () => _togglePin(context, ref),
              ),
          ],
        ),
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

/// 고정 뱃지 · 제목 · 작성자 · 본문 · 계좌
class _NoticeContent extends StatelessWidget {
  const _NoticeContent({required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final account = notice.account;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (notice.isPinned) ...[
            const _PinnedChip(),
            const SizedBox(height: 12),
          ],
          Text(
            notice.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: NoticeColors.text,
            ),
          ),
          const SizedBox(height: 12),
          _AuthorRow(
            authorName: notice.authorName,
            createdAt: notice.createdAt,
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
          if (account != null) ...[
            const SizedBox(height: 16),
            _AccountCard(account: account),
          ],
        ],
      ),
    );
  }
}

class _PinnedChip extends StatelessWidget {
  const _PinnedChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: NoticeColors.lightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        '고정된 공지',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: NoticeColors.blue,
        ),
      ),
    );
  }
}

/// (도) 김도윤 · 9월 12일. 작성자가 없으면 날짜만 보여줍니다.
class _AuthorRow extends StatelessWidget {
  const _AuthorRow({required this.authorName, required this.createdAt});

  final String? authorName;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    final name = authorName;
    final date = '${createdAt.month}월 ${createdAt.day}일';

    return Row(
      children: [
        if (name != null && name.isNotEmpty) ...[
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: NoticeColors.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Text(
              name.characters.first,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: NoticeColors.blue,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          name == null ? date : '$name · $date',
          style: const TextStyle(fontSize: 13, color: NoticeColors.subText),
        ),
      ],
    );
  }
}

/// 관리자 계좌 + 복사 버튼
class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.account});

  final NoticeAccount account;

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: account.accountNumber));
    messenger.showSnackBar(const SnackBar(content: Text('계좌번호를 복사했어요')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NoticeColors.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.account_balance_outlined,
              size: 22,
              color: NoticeColors.text,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${account.bankName} ${account.accountNumber}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: NoticeColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '예금주 ${account.holderName}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: NoticeColors.subText,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () => _copy(context),
            style: FilledButton.styleFrom(
              backgroundColor: NoticeColors.lightBlue,
              foregroundColor: NoticeColors.blue,
              minimumSize: const Size(56, 36),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Text(
              '복사',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// 관리자 하단 버튼: 고정 해제 / 고정하기
class _PinButton extends StatelessWidget {
  const _PinButton({required this.isPinned, required this.onPressed});

  final bool isPinned;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
        child: SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: NoticeColors.gray,
              foregroundColor: NoticeColors.text,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              isPinned ? '고정 해제' : '고정하기',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
