import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../notice_format.dart';
import '../providers/notice_providers.dart';
import '../viewmodels/notice_list_state.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_dialogs.dart';
import '../widgets/notice_error_view.dart';
import '../widgets/notice_role_retry_button.dart';

/// 공지 목록 화면
class NoticeListPage extends ConsumerStatefulWidget {
  const NoticeListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends ConsumerState<NoticeListPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 목록 끝에 가까워지면 다음 페이지를 불러옵니다.
  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels < position.maxScrollExtent - 200) return;
    ref
        .read(noticeListProvider(widget.meetingId).notifier)
        .loadMore()
        .catchError((Object error) => _showError(error));
  }

  void _showError(Object error) {
    if (!mounted) return;
    showNoticeSnackBar(context, noticeErrorMessage(error));
  }

  void _goWrite() => context.push('/meetings/${widget.meetingId}/notices/new');

  void _goDetail(Notice notice) =>
      context.push('/meetings/${widget.meetingId}/notices/${notice.id}');

  @override
  Widget build(BuildContext context) {
    final notices = ref.watch(noticeListProvider(widget.meetingId));
    final role = ref.watch(noticeMyRoleProvider(widget.meetingId));
    final isAdmin = role.value?.isAdmin ?? false;
    // 역할 조회에 실패하면 일반 구성원처럼 숨기지 않고 다시 시도할 수 있게 합니다.
    final VoidCallback? retryRole = role.hasError
        ? () => ref.invalidate(noticeMyRoleProvider(widget.meetingId))
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(onWrite: isAdmin ? _goWrite : null, onRetryRole: retryRole),
            Expanded(
              child: notices.when(
                data: (state) => state.isEmpty
                    ? _EmptyView(
                        onWrite: isAdmin ? _goWrite : null,
                        onRetryRole: retryRole,
                        onRefresh: () => ref
                            .read(noticeListProvider(widget.meetingId).notifier)
                            .refresh(),
                      )
                    : _NoticeListBody(
                        state: state,
                        controller: _scrollController,
                        onRefresh: () => ref
                            .read(noticeListProvider(widget.meetingId).notifier)
                            .refresh(),
                        onTapNotice: _goDetail,
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => NoticeErrorView(
                  error: error,
                  onAction: () =>
                      ref.invalidate(noticeListProvider(widget.meetingId)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "공지" 제목 + (관리자만) 작성 버튼 / (역할 조회 실패 시) 다시 시도 버튼
class _Header extends StatelessWidget {
  const _Header({this.onWrite, this.onRetryRole});

  final VoidCallback? onWrite;
  final VoidCallback? onRetryRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '공지',
                style: TextStyle(
                  fontSize: 26,
                  height: 1.35,
                  letterSpacing: -0.7,
                  fontWeight: FontWeight.w700,
                  color: NoticeColors.text,
                ),
              ),
            ),
            if (onRetryRole != null)
              NoticeRoleRetryButton(onPressed: onRetryRole!),
            if (onWrite != null)
              IconButton.filled(
                onPressed: onWrite,
                tooltip: '공지 작성',
                constraints: const BoxConstraints.tightFor(
                  width: 40,
                  height: 40,
                ),
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(backgroundColor: NoticeColors.text),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 공지 목록. 회색 박스 안에 최신순으로 보여줍니다.
class _NoticeListBody extends StatelessWidget {
  const _NoticeListBody({
    required this.state,
    required this.controller,
    required this.onRefresh,
    required this.onTapNotice,
  });

  final NoticeListState state;
  final ScrollController controller;
  final Future<void> Function() onRefresh;
  final ValueChanged<Notice> onTapNotice;

  @override
  Widget build(BuildContext context) {
    final notices = state.notices;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          for (var i = 0; i < notices.length; i++)
            _NoticeTile(
              notice: notices[i],
              isFirst: i == 0,
              isLast: i == notices.length - 1,
              onTap: () => onTapNotice(notices[i]),
            ),
          if (state.isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

/// 회색 박스의 한 칸. 첫 칸은 위쪽, 마지막 칸은 아래쪽 모서리만 둥글게 하고,
/// 박스 위아래에는 6 만큼 여백을 둡니다.
class _NoticeTile extends StatelessWidget {
  const _NoticeTile({
    required this.notice,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  final Notice notice;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.vertical(
      top: isFirst ? const Radius.circular(24) : Radius.zero,
      bottom: isLast ? const Radius.circular(24) : Radius.zero,
    );

    return Material(
      color: NoticeColors.gray,
      borderRadius: radius,
      child: Padding(
        padding: EdgeInsets.only(top: isFirst ? 6 : 0, bottom: isLast ? 6 : 0),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: isFirst
                    ? null
                    : const Border(top: BorderSide(color: Colors.white)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.47,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: NoticeColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _MetaText(notice: notice),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "1일 전"
class _MetaText extends StatelessWidget {
  const _MetaText({required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatNoticeRelative(notice.createdAt),
      style: const TextStyle(
        fontSize: 14,
        height: 1.43,
        letterSpacing: -0.1,
        color: NoticeColors.bodyText,
      ),
    );
  }
}

/// 공지가 없을 때. 관리자에게는 작성 버튼을, 구성원에게는 안내 문구를 보여줍니다.
///
/// 비어 있어도 당겨서 새로고침할 수 있습니다.
class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.onRefresh, this.onWrite, this.onRetryRole});

  final Future<void> Function() onRefresh;
  final VoidCallback? onWrite;
  final VoidCallback? onRetryRole;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              // 화면 정중앙보다 조금 위에 둡니다.
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
              child: _EmptyContent(onWrite: onWrite, onRetryRole: onRetryRole),
            ),
          ),
        ),
      ),
    );
  }
}

/// 빈 화면의 아이콘, 안내 문구, 버튼
class _EmptyContent extends StatelessWidget {
  const _EmptyContent({this.onWrite, this.onRetryRole});

  final VoidCallback? onWrite;
  final VoidCallback? onRetryRole;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _EmptyIcon(),
        const SizedBox(height: 20),
        const _EmptyTitle(),
        // 관리자에게만 안내 문구를 보여줍니다.
        if (onWrite != null) ...[
          const SizedBox(height: 6),
          const _EmptyDescription('첫 공지를 작성해 보세요'),
        ],
        if (onRetryRole != null) ...[
          const SizedBox(height: 20),
          _EmptyActionButton(
            label: '권한 다시 확인',
            onPressed: onRetryRole,
            backgroundColor: NoticeColors.gray,
            foregroundColor: NoticeColors.text,
          ),
        ],
        if (onWrite != null) ...[
          const SizedBox(height: 20),
          _EmptyActionButton(
            label: '공지 작성하기',
            onPressed: onWrite,
            backgroundColor: NoticeColors.text,
            foregroundColor: Colors.white,
          ),
        ],
      ],
    );
  }
}

class _EmptyIcon extends StatelessWidget {
  const _EmptyIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: NoticeColors.gray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.campaign_outlined,
        size: 28,
        color: NoticeColors.subText,
      ),
    );
  }
}

class _EmptyTitle extends StatelessWidget {
  const _EmptyTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '아직 등록된 공지가 없어요',
      style: TextStyle(
        fontSize: 17,
        height: 1.41,
        letterSpacing: -0.3,
        fontWeight: FontWeight.w600,
        color: NoticeColors.text,
      ),
    );
  }
}

class _EmptyDescription extends StatelessWidget {
  const _EmptyDescription(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        height: 1.43,
        letterSpacing: -0.1,
        color: NoticeColors.bodyText,
      ),
    );
  }
}

class _EmptyActionButton extends StatelessWidget {
  const _EmptyActionButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          height: 1.25,
          letterSpacing: -0.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
