import 'package:flutter/material.dart';
import 'group_design.dart';

class GroupPageTitle extends StatelessWidget {
  const GroupPageTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: GroupDesign.title),
        const SizedBox(height: 6),
        Text(subtitle, style: GroupDesign.body),
      ],
    ),
  );
}
