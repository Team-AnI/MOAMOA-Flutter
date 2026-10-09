import 'package:flutter/material.dart';

import 'group_design.dart';

class GroupField extends StatelessWidget {
  const GroupField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.helper,
    this.enabled = true,
    this.requiredValue = false,
    this.multiline = false,
    this.onChanged,
    this.maxLength,
  });
  final TextEditingController controller;
  final int? maxLength;
  final String label, hint;
  final String? helper;
  final bool enabled, requiredValue, multiline;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(
          label,
          style: GroupDesign.sub.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(
        height: multiline ? 112 : null,
        child: TextFormField(
          controller: controller,
          maxLength: maxLength,
          buildCounter: maxLength == null
              ? null
              : (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) => null,
          enabled: enabled,
          onChanged: onChanged,
          style: GroupDesign.body,
          minLines: multiline ? null : 1,
          maxLines: multiline ? null : 1,
          expands: multiline,
          textAlignVertical: TextAlignVertical.top,
          textCapitalization: label == '초대 코드'
              ? TextCapitalization.characters
              : TextCapitalization.none,
          validator: requiredValue
              ? (value) => value == null || value.trim().isEmpty
                    ? '필수 항목을 입력해주세요.'
                    : null
              : null,
          decoration: InputDecoration(
            hintText: hint,
            suffix: maxLength == null
                ? null
                : Text(
                    '${controller.text.characters.length}/$maxLength',
                    style: GroupDesign.caption.copyWith(
                      color: GroupDesign.muted,
                    ),
                  ),
            hintStyle: GroupDesign.body.copyWith(
              color: const Color(0xffcccccc),
            ),
            filled: true,
            fillColor: GroupDesign.fill,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: multiline ? 18 : 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: GroupDesign.ink, width: 2),
            ),
          ),
        ),
      ),
      if (helper != null)
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 4),
          child: Text(helper!, style: GroupDesign.caption),
        ),
    ],
  );
}
