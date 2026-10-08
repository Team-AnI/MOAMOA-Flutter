import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupIcon extends StatelessWidget {
  const GroupIcon(this.name, {super.key, this.size, this.color});
  final String name;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/group/$name.svg',
    width: size,
    height: size,
    colorFilter: color == null
        ? null
        : ColorFilter.mode(color!, BlendMode.srcIn),
  );
}
