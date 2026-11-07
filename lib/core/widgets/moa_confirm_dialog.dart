import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 확인 팝업의 틀 (흰 배경, 둥근 모서리, 안쪽 여백)
///
/// 화면에서는 `showMoaConfirmDialog` 로 띄웁니다.
/// 확인을 누르면 true, 취소하면 false 로 닫힙니다.
class MoaConfirmDialog extends StatelessWidget {
  const MoaConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MoaColors.raised,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목과 안내 문구
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: MoaText.titleM),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 취소는 false, 확인은 true 로 팝업을 닫습니다.
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    label: cancelLabel,
                    backgroundColor: MoaColors.fill,
                    foregroundColor: MoaColors.textPrimary,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DialogButton(
                    label: confirmLabel,
                    backgroundColor: MoaColors.accent,
                    foregroundColor: MoaColors.textInverse,
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

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        // MoaText 에는 글자색이 들어 있어서, 버튼 배경에 맞는 색으로 덮어씁니다.
        child: Text(
          label,
          style: MoaText.button.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
