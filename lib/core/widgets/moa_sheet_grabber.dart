import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 바텀 시트 맨 위의 손잡이입니다. (Figma "Grabber Row")
class MoaSheetGrabber extends StatelessWidget {
  const MoaSheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 36,
          height: 5,
          decoration: const BoxDecoration(
            color: MoaColors.grabber,
            borderRadius: BorderRadius.all(Radius.circular(9999)),
          ),
        ),
      ),
    );
  }
}
