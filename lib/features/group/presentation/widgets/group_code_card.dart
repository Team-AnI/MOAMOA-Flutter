import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'group_design.dart';

class GroupCodeCard extends StatelessWidget {
  const GroupCodeCard({super.key, required this.code});
  final String code;
  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.fromLTRB(20, 0, 20, 96),
          content: Text('초대 코드를 복사했어요.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: GroupDesign.ink,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '초대 코드',
          textAlign: TextAlign.center,
          style: GroupDesign.sub.copyWith(color: const Color(0xffcccccc)),
        ),
        const SizedBox(height: 6),
        SelectableText(
          code,
          textAlign: TextAlign.center,
          style: GroupDesign.title.copyWith(
            color: Colors.white,
            fontSize: 30,
            height: 1.3,
            letterSpacing: -.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '바로 가입',
          textAlign: TextAlign.center,
          style: GroupDesign.caption.copyWith(color: const Color(0xffcccccc)),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 48,
          child: FilledButton(
            onPressed: () => _copy(context),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xff38383a),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              '코드 복사',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
