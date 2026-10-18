import 'package:flutter/material.dart';

import 'group_design.dart';

class GroupPrimaryButton extends StatelessWidget {
  const GroupPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.secondary = false,
  });
  final bool secondary;
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 56,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: secondary ? GroupDesign.fill : GroupDesign.ink,
        disabledBackgroundColor: GroupDesign.fill,
        disabledForegroundColor: GroupDesign.muted,
        foregroundColor: secondary ? GroupDesign.ink : Colors.white,
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
