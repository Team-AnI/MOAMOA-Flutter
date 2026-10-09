import 'group_icon.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/group.dart';
import 'group_design.dart';
import 'group_mark.dart';

class GroupJoinSummary extends StatelessWidget {
  const GroupJoinSummary({super.key, required this.group});
  final Group group;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: 12),
      const Text('이 모임에 가입할까요?', style: GroupDesign.title),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: GroupDesign.fill,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Row(
              children: [
                GroupMark(name: group.name, size: 56),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.name, style: GroupDesign.heading),
                      if (group.description != null)
                        Text(group.description!, style: GroupDesign.sub),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, color: Colors.white),
            ),
            _row(
              'users',
              '구성원 ${group.memberCount ?? 0}명',
              '가입하면 일반 구성원으로 참여해요.',
            ),
            const SizedBox(height: 16),
            _row('shield', '바로 가입', '관리자 승인 없이 모임에 들어갈 수 있어요.'),
          ],
        ),
      ),
    ],
  );

  Widget _row(String icon, String title, String subtitle) => Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: GroupIcon(icon, size: 18, color: GroupDesign.ink)),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GroupDesign.strong.copyWith(fontSize: 15)),
            Text(subtitle, style: GroupDesign.sub),
          ],
        ),
      ),
    ],
  );
}
