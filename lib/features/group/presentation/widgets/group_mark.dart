import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'group_design.dart';

class GroupMark extends StatelessWidget {
  const GroupMark({
    super.key,
    required this.name,
    this.size = 52,
    this.photo,
    this.backgroundColor = GroupDesign.ink,
    this.cornerRadius,
    this.textStyle,
  });
  final Uint8List? photo;
  final String name;
  final double size;
  final Color backgroundColor;
  final double? cornerRadius;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) => photo != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius ?? size * .32),
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
            color: backgroundColor,
            borderRadius: BorderRadius.circular(cornerRadius ?? size * .32),
          ),
          child: Text(
            name.trim().isEmpty ? '모' : name.trim().characters.first,
            style:
                textStyle ??
                GroupDesign.heading.copyWith(
                  color: Colors.white,
                  fontSize: size > 80 ? 30 : 18,
                ),
          ),
        );
}
