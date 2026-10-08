import 'package:flutter/material.dart';
import 'group_design.dart';
import 'group_field.dart';
import 'group_mark.dart';
import 'group_page_title.dart';

class GroupProfileStep extends StatelessWidget {
  const GroupProfileStep({
    super.key,
    required this.name,
    required this.onChanged,
  });
  final TextEditingController name;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const GroupPageTitle(
        title: '모임 프로필을 정해요',
        subtitle: '모임원에게 보이는 이름을 정해요.',
      ),
      Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: Align(
            alignment: Alignment.topLeft,
            child: GroupMark(name: name.text, size: 112),
          ),
        ),
      ),
      const SizedBox(height: 16),
      Center(
        child: Container(
          height: 40,
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: GroupDesign.tint,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '기본 이미지',
            style: GroupDesign.body.copyWith(
              color: GroupDesign.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      const SizedBox(height: 28),
      GroupField(
        controller: name,
        label: '모임 이름',
        hint: '모임 이름을 입력해주세요',
        requiredValue: true,
        onChanged: onChanged,
      ),
    ],
  );
}
