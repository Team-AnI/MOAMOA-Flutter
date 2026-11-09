import 'package:flutter/material.dart';
import 'package:moamoa/core/widgets/moa_confirm_dialog.dart';

/// 확인 팝업을 띄웁니다. 확인을 누르면 true, 취소하면 false 를 돌려줍니다.
Future<bool?> showMoaConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String cancelLabel = '취소',
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => MoaConfirmDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
    ),
  );
}
