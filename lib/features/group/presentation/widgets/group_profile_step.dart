import 'package:flutter/material.dart';
import 'group_field.dart';
import 'group_icon.dart';
import 'group_photo_sheet.dart';
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
          child: Stack(
            children: [
              GroupMark(name: name.text, size: 112),
              Positioned(
                left: 80,
                top: 80,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x14000000),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: IconButton(
                    tooltip: '모임 사진 선택',
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        barrierColor: const Color(0x8f000000),
                        shape: const RoundedRectangleBorder(),
                        builder: (_) => const GroupPhotoSheet(),
                      );
                    },
                    icon: const GroupIcon('camera', size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
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
