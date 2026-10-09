import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/group_providers.dart';
import '../widgets/group_design.dart';
import '../widgets/group_mark.dart';
import '../widgets/group_page_layout.dart';
import '../widgets/group_primary_button.dart';

/// 일정·공지·회비 영역은 담당 기능에서 연결할 기본 모임 홈입니다.
class GroupHomePage extends ConsumerWidget {
  const GroupHomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(
      groupProvider.select((state) => state.currentGroup),
    );
    return GroupPageLayout(
      isBack: true,
      title: current?.group.name ?? '모임 홈',
      onClose: () => context.go('/groups'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (current != null) ...[
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: GroupMark(name: current.group.name, size: 56),
            ),
            const SizedBox(height: 20),
            Text(current.group.name, style: GroupDesign.title),
            const SizedBox(height: 8),
            Text(
              current.canViewInviteCode ? '관리자' : '구성원',
              style: GroupDesign.sub,
            ),
            const SizedBox(height: 24),
            if ((current.group.description ?? '').isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: GroupDesign.fill,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  current.group.description!,
                  style: GroupDesign.body,
                ),
              ),
            if (current.group.memberCount != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  '구성원 ${current.group.memberCount}명',
                  style: GroupDesign.heading,
                ),
              ),
            const SizedBox(height: 24),
            if (current.canViewInviteCode)
              GroupPrimaryButton(
                label: '초대 코드 확인',
                onPressed: () => context.push('/groups/invite'),
              ),
          ] else
            const Text('내 모임 목록에서 모임을 선택해주세요.', style: GroupDesign.body),
          TextButton(
            onPressed: () => context.go('/groups'),
            child: const Text('내 모임 목록', style: GroupDesign.body),
          ),
        ],
      ),
    );
  }
}
