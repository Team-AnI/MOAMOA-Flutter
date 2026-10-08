import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'group_design.dart';
import 'group_icon.dart';

class GroupEntryChoices extends StatelessWidget {
  const GroupEntryChoices({super.key, this.isSheet = false});
  final bool isSheet;
  void _open(BuildContext context, String path) {
    if (isSheet) Navigator.pop(context);
    context.push(path);
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _Choice(
        title: '모임 만들기',
        subtitle: '관리자가 되어 일정, 공지, 회비를 운영해요',
        icon: 'plus',
        dark: true,
        onTap: () => _open(context, '/groups/create'),
      ),
      const SizedBox(height: 12),
      _Choice(
        title: '초대 코드로 가입',
        subtitle: '관리자에게 받은 코드를 입력해요',
        icon: 'ticket',
        dark: false,
        onTap: () => _open(context, '/groups/join'),
      ),
    ],
  );
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.dark,
    required this.onTap,
  });
  final String title, subtitle, icon;
  final bool dark;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: GroupDesign.fill,
    borderRadius: BorderRadius.circular(24),
    child: InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: dark ? const Color(0xff272729) : Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: GroupIcon(icon, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GroupDesign.strong),
                  const SizedBox(height: 2),
                  Text(subtitle, style: GroupDesign.sub),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const GroupIcon('chevron', size: 16),
          ],
        ),
      ),
    ),
  );
}
