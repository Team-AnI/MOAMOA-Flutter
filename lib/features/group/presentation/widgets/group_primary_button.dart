import 'package:flutter/material.dart';

import 'group_button_variant.dart';
import 'group_design.dart';

class GroupPrimaryButton extends StatelessWidget {
  const GroupPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = GroupButtonVariant.primary,
  });
  final GroupButtonVariant variant;
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 56,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: variant.background,
        disabledBackgroundColor: GroupDesign.fill,
        disabledForegroundColor: GroupDesign.muted,
        foregroundColor: variant.foreground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
