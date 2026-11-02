import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 확인 팝업. 확인을 누르면 true, 취소하면 false 를 돌려줍니다.
Future<bool?> showMoaConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = '취소',
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(title, style: MoaText.titleM),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                message,
                style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
              ),
            ),
            const SizedBox(height: 24),
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
    ),
  );
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

/// 어두운 배경에 둥근 모서리로 떠 있는 스낵바
void showMoaSnackBar(
  BuildContext context,
  String message, {
  String? actionLabel,
  VoidCallback? onAction,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: MoaColors.accent,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Text(
        message,
        style: MoaText.sub.copyWith(color: MoaColors.textInverse),
      ),
      action: actionLabel == null
          ? null
          : SnackBarAction(
              label: actionLabel,
              textColor: MoaColors.textInverse,
              onPressed: onAction ?? () {},
            ),
    ),
  );
}
