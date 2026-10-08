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
  });
  final String name;
  final TextEditingController description;
  final VoidCallback? onEdit;
  final bool enabled;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const GroupPageTitle(title: '어떤 모임인가요?', subtitle: '모임을 소개해 주세요.'),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: GroupDesign.fill,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            GroupMark(name: name, size: 56),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: GroupDesign.heading),
                  const SizedBox(height: 2),
                  const Text('관리자', style: GroupDesign.sub),
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: GroupDesign.fill,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          '바로 가입',
          style: GroupDesign.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(height: 8),
      const Text('초대 코드를 입력하면 바로 들어올 수 있어요.', style: GroupDesign.caption),
    ],
  );
}
