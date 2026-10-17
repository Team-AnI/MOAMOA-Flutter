import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_icon.dart';

class GroupTodoTile extends StatelessWidget {
  const GroupTodoTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });
  final String title, subtitle, icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0x1fffffff),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GroupIcon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GroupDesign.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: GroupDesign.caption.copyWith(
                  color: const Color(0xffcccccc),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const GroupIcon('chevron', size: 16, color: Color(0xffcccccc)),
      ],
    ),
  );
}
