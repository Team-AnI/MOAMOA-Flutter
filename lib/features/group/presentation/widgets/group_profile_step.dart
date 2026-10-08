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
        subtitle: '모임원에게 보이는 사진과 이름이에요.',
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: '사진 업로드는 아직 지원되지 않아요.',
            child: TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.photo_outlined, size: 16),
              label: const Text('앨범에서 선택'),
              style: TextButton.styleFrom(
                backgroundColor: GroupDesign.fill,
                disabledForegroundColor: GroupDesign.muted,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
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
        ],
      ),
      const SizedBox(height: 28),
      GroupField(
        controller: name,
        label: '모임 이름',
        hint: '모임 이름을 입력해주세요',
        requiredValue: true,
        maxLength: 20,
        helper: '나중에 모임 설정에서 바꿀 수 있어요.',
        onChanged: onChanged,
      ),
    ],
  );
}
