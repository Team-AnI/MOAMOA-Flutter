import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 조회 실패 화면. 안내 문구와 다시 시도 버튼을 가운데에 보여줍니다.
///
/// 문구는 호출하는 쪽이 정합니다. (예: 기능별 예외를 사용자 문구로 바꾼 값)
class MoaErrorWidget extends StatelessWidget {
  const MoaErrorWidget({
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
            _ErrorActionButton(label: actionLabel, onPressed: onAction),
          ],
        ),
      ),
    );
  }
}

/// 오류 화면의 다시 시도 버튼 (연한 배경, 둥근 모서리)
class _ErrorActionButton extends StatelessWidget {
  const _ErrorActionButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: MoaColors.fill,
        foregroundColor: MoaColors.textPrimary,
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      // MoaText 에는 글자색이 들어 있어서, 버튼 전경색과 같은 색으로 덮어씁니다.
      child: Text(
        label,
        style: MoaText.button.copyWith(color: MoaColors.textPrimary),
      ),
    );
  }
}
