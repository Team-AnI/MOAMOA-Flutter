import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/moa_theme.dart';
import '../../../group/presentation/widgets/group_icon.dart';

class SettlementBottomTabs extends StatelessWidget {
  const SettlementBottomTabs({super.key, required this.meetingId});

  final int meetingId;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: MoaColors.fill)),
      ),
      child: Row(
        children: [
          _Tab(
            icon: 'home',
            label: '홈',
            onTap: () => context.go('/groups/home'),
          ),
          _Tab(
            icon: 'home_calendar',
            label: '일정',
            onTap: () => context.push('/meetings/$meetingId/schedules'),
          ),
          _Tab(
            icon: 'home_megaphone',
            label: '공지',
            onTap: () => context.push('/meetings/$meetingId/notices'),
          ),
          const _Tab(icon: 'wallet', label: '회비', selected: true),
          const _Tab(icon: 'home_user', label: '내 정보'),
        ],
      ),
    ),
  );
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Semantics(
      button: true,
      selected: selected,
      enabled: selected || onTap != null,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GroupIcon(
                icon,
                size: 24,
                color: selected
                    ? MoaColors.textPrimary
                    : MoaColors.textTertiary,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: MoaText.caption.copyWith(
                  color: selected
                      ? MoaColors.textPrimary
                      : MoaColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
