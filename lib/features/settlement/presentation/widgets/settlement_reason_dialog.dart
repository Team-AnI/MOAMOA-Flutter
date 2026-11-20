import 'package:flutter/material.dart';

import '../../../../core/theme/moa_theme.dart';

/// 반려·취소가 실제로 공유하는 사유 입력 창입니다. 입력 Controller는 창이 소유합니다.
class SettlementReasonDialog extends StatefulWidget {
  const SettlementReasonDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.description,
  });
  final String title, confirmLabel;
  final String? description;
  @override
  State<SettlementReasonDialog> createState() => _SettlementReasonDialogState();
}

class _SettlementReasonDialogState extends State<SettlementReasonDialog> {
  final _reason = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _complete() {
    if (_formKey.currentState!.validate()) Navigator.pop(context, _reason.text);
  }

  String? _validate(String? value) =>
      (value?.length ?? 0) > 255 ? '사유는 255자 이하여야 해요.' : null;
  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: MoaColors.raised,
    surfaceTintColor: Colors.transparent,
    insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: MoaText.titleM),
            if (widget.description case final description?) ...[
              const SizedBox(height: 8),
              Text(description, style: MoaText.sub),
            ],
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _reason,
                maxLength: 255,
                validator: _validate,
                decoration: const InputDecoration(hintText: '사유 (선택)'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: MoaColors.fill,
                      foregroundColor: MoaColors.textPrimary,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      '취소',
                      style: MoaText.button.copyWith(
                        color: MoaColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton(
                    onPressed: _complete,
                    style: FilledButton.styleFrom(
                      backgroundColor: MoaColors.accent,
                      foregroundColor: MoaColors.textInverse,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      widget.confirmLabel,
                      style: MoaText.button.copyWith(
                        color: MoaColors.textInverse,
                      ),
                    ),
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
