import 'package:flutter/material.dart';

import 'group_design.dart';

class GroupPrimaryButton extends StatelessWidget {
  const GroupPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.secondary = false,
    this.destructive = false,
  }) : assert(!(secondary && destructive));
  final bool secondary, destructive;

  Color get _background {
    if (destructive) return GroupDesign.dangerTint;
    return secondary ? GroupDesign.fill : GroupDesign.ink;
  }

  Color get _foreground {
    if (destructive) return GroupDesign.danger;
    return secondary ? GroupDesign.ink : Colors.white;
  }

  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 56,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: _background,
        disabledBackgroundColor: GroupDesign.fill,
        disabledForegroundColor: GroupDesign.muted,
        foregroundColor: _foreground,
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
