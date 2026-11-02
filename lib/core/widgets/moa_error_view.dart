import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 조회 실패 화면. 안내 문구와 다시 시도 버튼을 가운데에 보여줍니다.
///
/// 문구는 호출하는 쪽이 정합니다. (예: 기능별 예외를 사용자 문구로 바꾼 값)
class MoaErrorView extends StatelessWidget {
  const MoaErrorView({
    super.key,
    required this.message,
    required this.onAction,
    this.actionLabel = '다시 시도',
  });

  final String message;
  final VoidCallback onAction;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: MoaText.body.copyWith(color: MoaColors.textSecondary),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: MoaColors.fill,
                foregroundColor: MoaColors.textPrimary,
                minimumSize: const Size(0, 48),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(actionLabel, style: MoaText.button),
            ),
          ],
        ),
      ),
    );
  }
}
