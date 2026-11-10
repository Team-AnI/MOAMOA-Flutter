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

  BorderRadius get _borderRadius =>
      BorderRadius.circular(cornerRadius ?? size * .32);

  String get _initial =>
      name.trim().isEmpty ? '모' : name.trim().characters.first;

  TextStyle get _effectiveTextStyle =>
      textStyle ??
      GroupDesign.heading.copyWith(
        color: Colors.white,
        fontSize: size > 80 ? 30 : 18,
      );

  @override
  Widget build(BuildContext context) => photo != null
      ? ClipRRect(
          borderRadius: _borderRadius,
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
            borderRadius: _borderRadius,
          ),
          child: Text(_initial, style: _effectiveTextStyle),
        );
}
