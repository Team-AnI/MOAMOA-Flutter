import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'group_design.dart';

class GroupCodeCard extends StatelessWidget {
  const GroupCodeCard({super.key, required this.code, this.approval = false});
  final bool approval;
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
          approval ? '승인 후 가입' : '바로 가입',
          textAlign: TextAlign.center,
          style: GroupDesign.caption.copyWith(color: const Color(0xffcccccc)),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: FilledButton(
                  onPressed: () => _copy(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xff38383a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    '코드 복사',
                    style: GroupDesign.body.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Tooltip(
                message: '초대 링크 형식 확정 후 연결됩니다.',
                child: SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: null,
                    style: FilledButton.styleFrom(
                      disabledBackgroundColor: Colors.white,
                      disabledForegroundColor: GroupDesign.ink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      '링크 공유',
                      style: GroupDesign.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
