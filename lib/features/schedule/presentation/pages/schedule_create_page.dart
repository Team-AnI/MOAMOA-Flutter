import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../providers/schedule_providers.dart';
import '../viewmodels/schedule_create_state.dart';
import '../viewmodels/schedule_create_status.dart';
import '../widgets/schedule_form.dart';

/// 일정 만들기 화면 (관리자). 입력 → 제출 → 결과 순서로 동작합니다.
///
/// - 입력: 이름, 시작 일시(필수), 종료 일시(선택), 장소(선택), 설명(선택)
/// - 제출: 아래 버튼. 제출 중에는 버튼이 비활성화되어 중복 제출이 막힙니다.
/// - 결과: 성공하면 화면을 닫고(목록은 ViewModel 이 새로 불러옵니다), 입력이 잘못됐으면 해당 입력 아래에
///   문구를 보여주며, 그 밖의 실패는 하단 안내(SnackBar)로 알립니다.
///
/// [meetingId] 는 일정을 만들 모임입니다. 제출 상태는 [scheduleCreateProvider] 가 관리합니다.
class ScheduleCreatePage extends ConsumerWidget {
  const ScheduleCreatePage({super.key, required this.meetingId});

  final int meetingId;

  /// 제출 상태가 바뀌면: 성공이면 화면을 닫고, 실패하면 안내합니다.
  void _onStateChanged(
    BuildContext context,
    ScheduleCreateState? previous,
    ScheduleCreateState next,
  ) {
    if (previous?.status == next.status) return;
    if (next.status == ScheduleCreateStatus.success) {
      context.pop();
    } else if (next.status == ScheduleCreateStatus.failure) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('일정을 만들지 못했어요')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = scheduleCreateProvider(meetingId);
    ref.listen(provider, (previous, next) {
      _onStateChanged(context, previous, next);
    });
    final state = ref.watch(provider);

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(),
      body: SafeArea(
        child: ScheduleForm(
          heading: '일정 만들기',
          submitLabel: '일정 만들기',
          isSubmitting: state.status == ScheduleCreateStatus.submitting,
          onSubmit:
              ({
                required title,
                required description,
                required startAt,
                endAt,
                required location,
              }) {
                ref
                    .read(provider.notifier)
                    .submit(
                      title: title,
                      description: description,
                      startAt: startAt,
                      endAt: endAt,
                      location: location,
                    );
              },
        ),
      ),
    );
  }
}
