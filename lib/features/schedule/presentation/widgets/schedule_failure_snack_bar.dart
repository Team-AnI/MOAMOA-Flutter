import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

// Figma 의 text/inverse-muted 색입니다. 공통 테마(MoaColors)에 아직 없어서 이 알림에서만 씁니다.
const _mutedText = Color(0xFFCCCCCC);

/// 일정 화면에서 요청이 실패했을 때 아래에 띄우는 알림입니다. (Figma "Snackbar")
///
/// 경고 아이콘, 제목([message]), 안내 문구(`잠시 후 다시 시도해 주세요`) 순서로 보여줍니다.
/// [SnackBar] 를 그대로 상속하므로 `ScaffoldMessenger.of(context).showSnackBar(...)` 에 넘겨 씁니다.
class ScheduleFailureSnackBar extends SnackBar {
  ScheduleFailureSnackBar({super.key, required String message})
    : super(
        content: _FailureContent(message: message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: MoaColors.accent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      );
}

/// 알림 안의 내용입니다. 왼쪽 경고 아이콘, 오른쪽에 제목과 안내 문구를 세로로 쌓습니다.
class _FailureContent extends StatelessWidget {
  const _FailureContent({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        const Icon(Icons.error_outline, size: 20, color: MoaColors.textInverse),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: MoaText.subStrong.copyWith(color: MoaColors.textInverse),
              ),
              Text(
                '잠시 후 다시 시도해 주세요',
                style: MoaText.caption.copyWith(color: _mutedText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
