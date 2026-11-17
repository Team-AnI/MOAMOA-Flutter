import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_profile_avatar.dart';

import '../../domain/entities/notice_detail_request.dart';
import '../../domain/entities/notice_reads.dart';
import '../notice_format.dart';
import '../providers/notice_providers.dart';

/// 공지 상세의 "읽은 구성원" (3-7)
///
/// 읽은 구성원의 프로필 동그라미와 아직 안 읽은 구성원을 보여줍니다. 모임 구성원 누구나 봅니다.
/// 불러오지 못하면 이 영역에서만 안내하고, 공지 내용은 그대로 보여줍니다.
class NoticeReadsView extends ConsumerWidget {
  const NoticeReadsView({super.key, required this.request});

  final NoticeDetailRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reads = ref.watch(noticeReadsProvider(request));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 제목과 읽은 수 (예: 6/8)
        Row(
          children: [
            Expanded(child: Text('읽은 구성원', style: MoaText.titleM)),
            if (reads.value case final value?)
              Text(
                value.countLabel,
                style: MoaText.subStrong.copyWith(color: MoaColors.accentText),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: MoaColors.fill,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: reads.when(
                data: (reads) => _ReadMembers(reads: reads),
                loading: () => const Center(
                  child: SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                // 불러오지 못했다는 안내와 다시 시도 버튼
                error: (_, _) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        '읽음 현황을 불러오지 못했어요.',
                        style: MoaText.sub.copyWith(
                          color: MoaColors.textSecondary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          ref.invalidate(noticeReadsProvider(request)),
                      child: Text(
                        '다시 시도',
                        style: MoaText.subStrong.copyWith(
                          color: MoaColors.accentText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 읽은 구성원 프로필 동그라미와 안 읽은 구성원 안내
class _ReadMembers extends StatelessWidget {
  const _ReadMembers({required this.reads});

  final NoticeReads reads;

  static const _avatarSize = 32.0;

  /// 동그라미끼리 겹치는 너비
  static const _overlap = 8.0;

  /// 동그라미 사이를 구분하는 카드 색 테두리
  static final _ring = BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: MoaColors.fill, width: 2),
  );

  /// [index] 번째 동그라미의 왼쪽 위치
  static double _leftOf(int index) => index * (_avatarSize - _overlap);

  @override
  Widget build(BuildContext context) {
    final hiddenReaderLabel = reads.hiddenReaderLabel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 읽은 순서대로 최대 6명. 더 있으면 마지막에 "+N" 을 붙입니다.
        if (reads.stackMembers.isNotEmpty) ...[
          SizedBox(
            height: _avatarSize,
            child: Stack(
              children: [
                for (final (index, member) in reads.stackMembers.indexed)
                  Positioned(
                    left: _leftOf(index),
                    child: Container(
                      foregroundDecoration: _ring,
                      child: MoaProfileAvatar(
                        userName: member.userName,
                        color: member.profileColor,
                        size: _avatarSize,
                      ),
                    ),
                  ),
                if (hiddenReaderLabel != null)
                  Positioned(
                    left: _leftOf(reads.stackMembers.length),
                    child: Container(
                      width: _avatarSize,
                      height: _avatarSize,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: MoaColors.profileGray,
                      ),
                      foregroundDecoration: _ring,
                      child: Text(
                        hiddenReaderLabel,
                        style: MoaText.captionStrong.copyWith(
                          color: MoaColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          reads.unreadLabel,
          style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
        ),
      ],
    );
  }
}
