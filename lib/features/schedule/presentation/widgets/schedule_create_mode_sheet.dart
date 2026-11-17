import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_sheet_grabber.dart';

import '../schedule_create_mode.dart';

/// 일정을 바로 만들지, 투표로 정할지 고르는 시트입니다. (Figma "[P0] 일정 만들기 · 방식 선택 시트")
/// 고른 [ScheduleCreateMode] 를 돌려주고, 그냥 닫으면 null 입니다.
class ScheduleCreateModeSheet extends StatelessWidget {
  const ScheduleCreateModeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 34),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MoaSheetGrabber(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('시간을 어떻게 정할까요?', style: MoaText.titleL),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 8,
                children: [
                  for (final mode in ScheduleCreateMode.values)
                    _ModeOption(
                      mode: mode,
                      onTap: () => Navigator.pop(context, mode),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 방식 하나의 이름과 설명입니다. 누르면 [onTap] 으로 시트를 닫습니다.
class _ModeOption extends StatelessWidget {
  const _ModeOption({required this.mode, required this.onTap});

  final ScheduleCreateMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MoaColors.fill,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(mode.title, style: MoaText.body),
                    Text(
                      mode.description,
                      style: MoaText.sub.copyWith(
                        color: MoaColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset('assets/icons/caret_right.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
