import 'package:flutter/material.dart';

import 'group_design.dart';

class GroupDeleteDialog extends StatelessWidget {
  const GroupDeleteDialog({
    super.key,
    required this.name,
    this.error,
    this.canRetry = false,
  });

  final String name;
  final String? error;
  final bool canRetry;

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            error == null ? '“$name” 모임을 삭제할까요?' : '모임을 삭제하지 못했어요',
            style: GroupDesign.heading,
          ),
          const SizedBox(height: 8),
          Text(error ?? '삭제하면 이 모임을 더 이상 이용할 수 없어요.', style: GroupDesign.body),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _DialogButton(
                  label: '닫기',
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              if (error == null || canRetry) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: _DialogButton(
                    label: error == null ? '모임 삭제' : '다시 시도',
                    destructive: true,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    ),
  );
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool destructive;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: destructive
            ? const Color(0xfffdecec)
            : GroupDesign.fill,
        foregroundColor: destructive
            ? const Color(0xffe30000)
            : GroupDesign.ink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
