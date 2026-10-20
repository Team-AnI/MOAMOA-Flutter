import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';

import '../providers/schedule_providers.dart';
import '../viewmodels/schedule_edit_state.dart';
import '../viewmodels/schedule_edit_status.dart';
import '../widgets/schedule_failure_snack_bar.dart';
import '../widgets/schedule_form.dart';

/// 일정 수정 화면 (관리자). 기존 값을 채운 입력 폼을 보여주고 제출하면 바뀐 내용만 저장합니다.
///
/// - [meetingId], [scheduleId]: 수정할 모임과 일정. 라우트(`…/schedules/:scheduleId/edit`)에서 전달됩니다.
/// - 불러오는 중에는 로딩 표시, 실패하면 안내 문구를 보여줍니다.
/// - 성공하면 화면을 닫고(상세와 목록은 ViewModel 이 새로 불러옵니다), 실패하면 하단 안내(SnackBar)로 알립니다.
class ScheduleEditPage extends ConsumerWidget {
  const ScheduleEditPage({
    super.key,
    required this.meetingId,
    required this.scheduleId,
  });

  final int meetingId;
  final int scheduleId;

  /// 제출 상태가 바뀌면: 성공이면 화면을 닫고, 실패하면 안내합니다.
  void _onStateChanged(
    BuildContext context,
    ScheduleEditState? previous,
    ScheduleEditState next,
  ) {
    if (previous?.status == next.status) return;
    if (next.status == ScheduleEditStatus.success) {
      context.pop();
    } else if (next.status == ScheduleEditStatus.failure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(ScheduleFailureSnackBar(message: '일정을 수정하지 못했어요'));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final request = ScheduleDetailRequest(
      meetingId: meetingId,
      scheduleId: scheduleId,
    );
    final editProvider = scheduleEditProvider(request);
    ref.listen(editProvider, (previous, next) {
      _onStateChanged(context, previous, next);
    });
    final state = ref.watch(editProvider);
    final schedule = ref.watch(scheduleDetailProvider(request));

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(title: '일정 수정', showClose: true),
      body: SafeArea(
        child: schedule.when(
          data: (s) => ScheduleForm(
            submitLabel: '수정 완료',
            isSubmitting: state.status == ScheduleEditStatus.submitting,
            initial: s,
            onSubmit:
                ({
                  required title,
                  required description,
                  required startAt,
                  endAt,
                  required location,
                }) {
                  ref
                      .read(editProvider.notifier)
                      .submit(
                        title: title,
                        description: description,
                        startAt: startAt,
                        endAt: endAt,
                        location: location,
                      );
                },
          ),
          error: (_, _) => Center(
            child: Text(
              '일정을 불러오지 못했어요',
              style: MoaText.body.copyWith(color: MoaColors.textTertiary),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
