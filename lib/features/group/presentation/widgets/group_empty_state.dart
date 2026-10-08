import 'package:flutter/material.dart';
import 'group_design.dart';
import 'group_icon.dart';

class GroupEmptyState extends StatelessWidget {
  const GroupEmptyState({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: GroupDesign.fill,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: GroupDesign.tint,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const GroupIcon('users', size: 28),
          ),
        ),
        const SizedBox(height: 18),
        const Text('아직 참여한 모임이 없어요', style: GroupDesign.heading),
        const SizedBox(height: 6),
        const Text('직접 만들거나 초대 코드로 들어가요.', style: GroupDesign.body),
      ],
    ),
  );
}
