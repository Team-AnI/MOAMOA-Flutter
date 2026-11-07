import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 어두운 배경에 둥근 모서리로 떠 있는 스낵바
///
/// 동작 버튼이 필요하면 [actionLabel] 과 [onAction] 을 함께 넘깁니다.
void showMoaSnackBar(
  BuildContext context, {
  required String message,
  String? actionLabel,
  VoidCallback? onAction,
}) {
  assert(
    (actionLabel == null) == (onAction == null),
    'actionLabel 과 onAction 은 함께 넘겨야 합니다.',
  );
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
      action: actionLabel == null || onAction == null
          ? null
          : SnackBarAction(
              label: actionLabel,
              textColor: MoaColors.textInverse,
              onPressed: onAction,
            ),
    ),
  );
}
