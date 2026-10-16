import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';
import '../viewmodels/schedule_delete_state.dart';
import '../viewmodels/schedule_delete_status.dart';

// Figma 의 alert/text, alert/tint 색입니다. 공통 테마(MoaColors)에 아직 없어서 이 화면에서만 씁니다.
const _alertText = Color(0xFFE30000);
const _alertTint = Color(0xFFFDECEC);

/// 일정 상세 화면입니다. 목록이나 캘린더에서 일정을 누르면 열립니다.
///
/// 위에서부터 뒤로가기 바, 제목(관리자는 수정 버튼), 일시·장소·메모 카드, 일정 취소하기 순서로 보여줍니다.
/// - [meetingId], [scheduleId]: 조회할 모임과 일정. 라우트(`…/schedules/:scheduleId`)에서 전달됩니다.
/// - 불러오는 중에는 로딩 표시, 실패하면 안내 문구를 보여줍니다.
/// - 관리자에게만 수정(연필) 버튼과 "일정 취소하기"가 보입니다. 구성원은 보기만 합니다.
/// - 일정을 취소하면 화면을 닫고, 실패하면 하단 안내(SnackBar)로 알립니다.
class ScheduleDetailPage extends ConsumerWidget {
  const ScheduleDetailPage({
    super.key,
    required this.meetingId,
    required this.scheduleId,
  });

  final int meetingId;
  final int scheduleId;

  /// 취소 요청 상태가 바뀌면: 성공이면 화면을 닫고, 실패하면 안내합니다.
  void _onDeleteChanged(
    BuildContext context,
    ScheduleDeleteState? previous,
    ScheduleDeleteState next,
  ) {
    if (previous?.status == next.status) return;
    if (next.status == ScheduleDeleteStatus.success) {
      context.pop();
    } else if (next.status == ScheduleDeleteStatus.failure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('일정을 취소하지 못했어요')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ScheduleDetailRequest(
      meetingId: meetingId,
      scheduleId: scheduleId,
    );
    final schedule = ref.watch(scheduleDetailProvider(request));
    ref.listen(scheduleDeleteProvider(request), (previous, next) {
      _onDeleteChanged(context, previous, next);
    });

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: schedule.when(
                data: (s) => _Body(schedule: s, request: request),
                error: (_, _) => Center(
                  child: Text(
                    '일정을 불러오지 못했어요',
                    style: MoaText.body.copyWith(color: MoaColors.textTertiary),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 불러온 일정의 내용입니다. 길어질 수 있어서 스크롤됩니다.
///
/// - 제목 줄: 제목과, 관리자에게만 보이는 수정 버튼
/// - 카드: 날짜 배지, 요일과 시작 시각, 진행 시간(종료 일시가 있을 때만), 장소, 메모
/// - 장소, 메모: 비어 있으면 그 줄을 그리지 않습니다.
/// - 관리자에게는 카드 아래에 "일정 취소하기"가 붙습니다. ([request] 는 수정·취소할 일정)
class _Body extends StatelessWidget {
  const _Body({required this.schedule, required this.request});

  final Schedule schedule;
  final ScheduleDetailRequest request;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18,
        children: [
          Row(
            children: [
              Expanded(child: Text(schedule.title, style: MoaText.titleXl)),
              _EditButton(request: request),
            ],
          ),
          _InfoCard(schedule: schedule),
          _CancelButton(request: request),
        ],
      ),
    );
  }
}

/// 관리자에게만 보이는 수정(연필) 버튼입니다. 누르면 [request] 일정의 수정 화면으로 이동합니다.
class _EditButton extends ConsumerWidget {
  const _EditButton({required this.request});

  final ScheduleDetailRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(scheduleAdminProvider)) return const SizedBox.shrink();

    return IconButton(
      key: const Key('schedule-edit-button'),
      onPressed: () => context.push(
        '/meetings/${request.meetingId}/schedules/${request.scheduleId}/edit',
      ),
      icon: const Icon(Icons.edit_outlined),
    );
  }
}

/// 일정 정보 카드입니다.
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.schedule});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    final start = schedule.startAt.toLocal();
    final end = schedule.endAt?.toLocal();
    final description = schedule.description;
    final location = schedule.location;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          Row(
            spacing: 14,
            children: [
              _DateBadge(date: start),
              _TimeLabel(start: start, end: end),
            ],
          ),
          if (location.isNotEmpty)
            _InfoRow(
              icon: SvgPicture.asset('assets/icons/map_pin_field.svg'),
              text: location,
            ),
          if (description.isNotEmpty)
            _InfoRow(
              icon: const Icon(Icons.sticky_note_2_outlined, size: 20),
              label: '메모',
              text: description,
            ),
        ],
      ),
    );
  }
}

/// 카드 왼쪽의 날짜 배지입니다. 위에 월(`10월`), 아래에 일(`11`)을 보여줍니다.
class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: MoaColors.accentText);
    return Container(
      width: 60,
      height: 64,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: MoaColors.accentTint,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${date.month}월', style: MoaText.captionStrong.merge(style)),
          Text('${date.day}', style: MoaText.titleL.merge(style)),
        ],
      ),
    );
  }
}

/// 요일과 시작 시각(`수요일 오후 7:00`), 종료 일시([end])가 있으면 진행 시간(`약 2시간 진행`)입니다.
class _TimeLabel extends StatelessWidget {
  const _TimeLabel({required this.start, required this.end});

  final DateTime start;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    final hour = start.hour % 12 == 0 ? 12 : start.hour % 12;
    final minute = start.minute.toString().padLeft(2, '0');
    final meridiem = start.hour < 12 ? '오전' : '오후';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${start.weekdayKo}요일 $meridiem $hour:$minute',
          style: MoaText.titleS,
        ),
        if (end != null)
          Text(
            '약 ${durationLabel(end!.difference(start))} 진행',
            style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
          ),
      ],
    );
  }
}

/// 아이콘과 글자 한 줄입니다. [label] 이 있으면 글자 위에 작게 붙입니다.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text, this.label});

  final Widget icon;
  final String text;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        icon,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: MoaText.caption.copyWith(
                    color: MoaColors.textTertiary,
                  ),
                ),
              Text(text, style: MoaText.body),
            ],
          ),
        ),
      ],
    );
  }
}

/// 관리자에게만 보이는 "일정 취소하기" 글자 버튼입니다.
/// 누르면 확인 팝업을 띄우고, 확인하면 [request] 일정을 취소합니다.
class _CancelButton extends ConsumerWidget {
  const _CancelButton({required this.request});

  final ScheduleDetailRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(scheduleAdminProvider)) return const SizedBox.shrink();

    return Center(
      child: TextButton(
        key: const Key('schedule-cancel-button'),
        onPressed: () async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (_) => const _CancelConfirmDialog(),
          );
          if (confirmed != true) return;
          ref.read(scheduleDeleteProvider(request).notifier).cancel();
        },
        child: Text(
          '이 일정 취소하기',
          style: MoaText.subStrong.copyWith(color: _alertText),
        ),
      ),
    );
  }
}

/// 일정 취소 확인 팝업입니다. "일정 취소" 를 누르면 true, "닫기" 를 누르면 false 로 닫힙니다.
///
/// Figma 의 Dialog 를 따라 흰 바탕에 둥근 모서리, 제목·안내 문구, 같은 폭의 버튼 두 개로 구성합니다.
class _CancelConfirmDialog extends StatelessWidget {
  const _CancelConfirmDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MoaColors.page,
      surfaceTintColor: MoaColors.page,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text('이 일정을 취소할까요?', style: MoaText.titleM),
                Text(
                  '취소한 일정은 되돌릴 수 없어요.',
                  style: MoaText.body.copyWith(color: MoaColors.textSecondary),
                ),
              ],
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: _DialogButton(
                    label: '닫기',
                    background: MoaColors.fill,
                    foreground: MoaColors.textPrimary,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                Expanded(
                  child: _DialogButton(
                    label: '일정 취소',
                    background: _alertTint,
                    foreground: _alertText,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 팝업 아래의 둥근 채움 버튼입니다. 높이 56, 가로는 부모([Expanded])가 정합니다.
class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          textStyle: MoaText.button,
        ),
        child: Text(label),
      ),
    );
  }
}
