import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_field.dart';
import 'group_mark.dart';
import 'group_page_title.dart';

class GroupInfoStep extends StatelessWidget {
  const GroupInfoStep({
    super.key,
    required this.name,
    required this.description,
    required this.onEdit,
    required this.enabled,
    this.adminName,
    this.photo,
    this.approval = false,
    this.onApprovalChanged,
  });
  final bool approval;
  final ValueChanged<bool>? onApprovalChanged;
  final String name;
  final Uint8List? photo;
  final String? adminName;
  final TextEditingController description;
  final VoidCallback? onEdit;
  final bool enabled;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const GroupPageTitle(title: '어떤 모임인가요?', subtitle: '소개와 가입 방식을 정해요.'),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GroupDesign.fill,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            if (photo == null)
              GroupMark(name: name, size: 56)
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  photo!,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: GroupDesign.heading),
                  const SizedBox(height: 2),
                  Text(
                    adminName == null || adminName!.trim().isEmpty
                        ? '관리자 · 계정 정보 미연결'
                        : '관리자 · ${adminName!.trim()}',
                    style: GroupDesign.sub,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onEdit,
              child: const Text('수정', style: GroupDesign.body),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      GroupField(
        controller: description,
        label: '모임 소개',
        hint: '어떤 모임인지 간단히 소개해 주세요',
        helper: '선택 사항이에요.',
        multiline: true,
        enabled: enabled,
      ),
      const SizedBox(height: 18),
      const Text('가입 방식', style: GroupDesign.sub),
      const SizedBox(height: 8),
      Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: GroupDesign.fill,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            for (final value in [false, true]) ...[
              if (value) const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: enabled && onApprovalChanged != null
                      ? () => onApprovalChanged!(value)
                      : null,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: approval == value ? Colors.white : null,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: approval == value
                          ? const [
                              BoxShadow(
                                color: Color(0x14000000),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      value ? '승인 후 가입' : '바로 가입',
                      style: GroupDesign.body.copyWith(
                        color: value && onApprovalChanged == null
                            ? GroupDesign.muted
                            : GroupDesign.ink,
                        fontWeight: approval == value
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      const SizedBox(height: 8),
      Text(
        approval
            ? '가입 요청을 관리자가 확인한 뒤에 들어올 수 있어요.'
            : '초대 코드를 입력하면 바로 들어올 수 있어요.',
        style: GroupDesign.caption,
      ),
    ],
  );
}
