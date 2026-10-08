import 'package:flutter/material.dart';
import 'group_design.dart';

class GroupMark extends StatelessWidget {
  const GroupMark({super.key, required this.name, this.size = 52});
  final String name;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: GroupDesign.ink,
      borderRadius: BorderRadius.circular(size * .32),
    ),
    child: Text(
      name.trim().isEmpty ? '모' : name.trim().characters.first,
      style: GroupDesign.heading.copyWith(
        color: Colors.white,
        fontSize: size > 80 ? 30 : 18,
      ),
    ),
  );
}
