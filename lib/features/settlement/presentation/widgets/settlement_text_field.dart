import 'package:flutter/material.dart';

import '../../../../core/theme/moa_theme.dart';

class SettlementTextField extends StatelessWidget {
  const SettlementTextField({
    super.key,
    required this.controller,
    required this.label,
    this.numeric = false,
    this.validator,
    this.maxLength,
  });
  final TextEditingController controller;
  final String label;
  final bool numeric;
  final String? Function(String)? validator;
  final int? maxLength;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: MoaText.subStrong),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: numeric ? TextInputType.number : TextInputType.text,
          maxLength: maxLength,
          validator: (value) => validator?.call(value ?? ''),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: MoaColors.fill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    ),
  );
}
