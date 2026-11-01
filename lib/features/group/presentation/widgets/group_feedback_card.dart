import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_icon.dart';

/// 저장 실패와 복원 완료에 사용하는 화면 하단 안내입니다.
class GroupFeedbackCard extends StatelessWidget {
  const GroupFeedbackCard({
    super.key,
    required this.title,
    required this.message,
    this.warning = false,
  });

  final String title, message;
  final bool warning;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: GroupDesign.ink,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (warning) ...[
            const GroupIcon('warning_circle', size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GroupDesign.sub.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: GroupDesign.caption.copyWith(
                    color: const Color(0xffcccccc),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
