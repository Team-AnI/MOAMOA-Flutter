import 'package:flutter/material.dart';

import 'group_button_variant.dart';
import 'group_design.dart';
import 'group_primary_button.dart';

class GroupDeleteDialog extends StatelessWidget {
  const GroupDeleteDialog.confirm({super.key, required String name})
    : title = '“$name” 모임을 삭제할까요?',
      message = '삭제하면 이 모임을 더 이상 이용할 수 없어요.',
      actionLabel = '모임 삭제';

  const GroupDeleteDialog.failure({
    super.key,
    required this.message,
    required bool canRetry,
  }) : title = canRetry ? '삭제 결과를 확인하지 못했어요' : '모임을 삭제하지 못했어요',
       actionLabel = canRetry ? '다시 시도' : null;

  final String title, message;
  final String? actionLabel;

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
          Text(title, style: GroupDesign.heading),
          const SizedBox(height: 8),
          Text(message, style: GroupDesign.body),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GroupPrimaryButton(
                  label: '닫기',
                  variant: GroupButtonVariant.secondary,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              if (actionLabel != null) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: GroupPrimaryButton(
                    label: actionLabel!,
                    variant: GroupButtonVariant.destructive,
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
