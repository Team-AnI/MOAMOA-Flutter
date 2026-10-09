import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'group_design.dart';

class GroupMark extends StatelessWidget {
  const GroupMark({super.key, required this.name, this.size = 52, this.photo});
  final Uint8List? photo;
  final String name;
  final double size;
  @override
  Widget build(BuildContext context) => photo != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(size * .32),
          child: Image.memory(
            photo!,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        )
      : Container(
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
