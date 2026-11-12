import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_sheet_grabber.dart';
import 'package:moamoa/features/schedule/presentation/schedule_format.dart';

import '../../domain/entities/vote_candidate.dart';
import 'vote_colors.dart';
import 'vote_primary_button.dart';

/// 확정할 후보 시간을 고르는 시트입니다. (Figma "[P0] 일정 확정 시트")
///
/// [candidates] 는 가능 인원이 많은 순이고, 맨 위를 골라 둔 채로 엽니다.
/// "이 시간으로 확정"을 누르면 고른 후보 시간을 돌려주고, 그냥 닫으면 null 입니다.
class VoteConfirmSheet extends StatefulWidget {
  const VoteConfirmSheet({super.key, required this.candidates});

  final List<VoteCandidate> candidates;

  @override
  State<VoteConfirmSheet> createState() => _VoteConfirmSheetState();
}

/// 고른 후보의 순서를 들고 있습니다.
class _VoteConfirmSheetState extends State<VoteConfirmSheet> {
  int _selected = 0;

  static const _radius = BorderRadius.all(Radius.circular(16));

  void _select(int index) => setState(() => _selected = index);

  void _confirm() =>
      Navigator.pop(context, widget.candidates[_selected].meetingTime);

  /// 예: 7명 가능. 맨 위(가장 많이 겹친 시간)에는 "가장 많음"을 붙입니다.
  String _availableLabelOf(int index) {
    final count = widget.candidates[index].availableCount;
    return index == 0 && count > 0 ? '$count명 가능 · 가장 많음' : '$count명 가능';
  }

  /// 고른 후보는 파란 바탕에 검은 테두리입니다.
  BoxDecoration _decorationOf(int index) => index == _selected
      ? BoxDecoration(
          color: MoaColors.accentTint,
          borderRadius: _radius,
          border: Border.all(color: MoaColors.accent, width: 1.5),
        )
      : const BoxDecoration(color: MoaColors.fill, borderRadius: _radius);

  TextStyle _timeStyleOf(int index) => index == _selected
      ? MoaText.bodyStrong.copyWith(color: MoaColors.accentText)
      : MoaText.body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MoaSheetGrabber(),
          // 제목과 안내 문구
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                Text('어느 시간으로 확정할까요?', style: MoaText.titleL),
                Text(
                  '많이 겹친 순서로 보여 드려요.',
                  style: MoaText.body.copyWith(color: MoaColors.textSecondary),
                ),
              ],
            ),
          ),
          // 후보 시간. 많으면 스크롤됩니다.
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: widget.candidates.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => _select(index),
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: _decorationOf(index),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              widget.candidates[index].meetingTime
                                  .toLocal()
                                  .fieldLabel,
                              style: _timeStyleOf(index),
                            ),
                            Text(
                              _availableLabelOf(index),
                              style: MoaText.sub.copyWith(
                                color: MoaColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 고른 후보는 검은 원 안의 체크, 나머지는 빈 원입니다.
                      if (index == _selected)
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: MoaColors.accent,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/check_bold.svg',
                          ),
                        )
                      else
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: VoteColors.textDisabled,
                              width: 1.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 확정 버튼과 안내. 확정 후에는 다른 시간으로 바꿀 수 없습니다. (API 5-5)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              spacing: 10,
              children: [
                VotePrimaryButton(label: '이 시간으로 확정', onPressed: _confirm),
                Text(
                  '확정하면 다른 시간으로 바꿀 수 없어요.',
                  style: MoaText.caption.copyWith(
                    color: MoaColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
