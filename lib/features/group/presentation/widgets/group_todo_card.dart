import 'package:flutter/material.dart';

import 'group_design.dart';
import 'group_icon.dart';
import 'group_todo_tile.dart';

/// 기능별 처리할 일이 연결되면 목록에 표시할 카드입니다.
/// 데이터가 없는 경우에는 카드 자체를 표시하지 않습니다.
class GroupTodoCard extends StatefulWidget {
  const GroupTodoCard({super.key, required this.items});
  final List<GroupTodoTile> items;
  @override
  State<GroupTodoCard> createState() => _GroupTodoCardState();
}

class _GroupTodoCardState extends State<GroupTodoCard> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: expanded
          ? const EdgeInsets.all(20)
          : const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: GroupDesign.ink,
        borderRadius: BorderRadius.circular(expanded ? 28 : 20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!expanded)
            _CollapsedTodoHeader(
              count: widget.items.length,
              title: widget.items.first.title,
              onExpand: () => setState(() => expanded = true),
            ),
          if (expanded)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '처리할 일',
                        style: GroupDesign.sub.copyWith(
                          color: const Color(0xffcccccc),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.items.length}가지가 기다려요',
                        style: GroupDesign.title.copyWith(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: expanded ? '처리할 일 접기' : '처리할 일 펼치기',
                  onPressed: () => setState(() => expanded = !expanded),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x1fffffff),
                  ),
                  icon: const GroupIcon('list_caret_up', size: 18),
                ),
              ],
            ),
          if (expanded)
            for (final item in widget.items) ...[
              const SizedBox(height: 14),
              item,
            ],
        ],
      ),
    );
  }
}

class _CollapsedTodoHeader extends StatelessWidget {
  const _CollapsedTodoHeader({
    required this.count,
    required this.title,
    required this.onExpand,
  });
  final int count;
  final String title;
  final VoidCallback onExpand;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        '처리할 일',
        style: GroupDesign.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Text('$count', style: GroupDesign.caption),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          count > 1 ? '$title 외 ${count - 1}개' : title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GroupDesign.caption.copyWith(color: const Color(0xffcccccc)),
        ),
      ),
      IconButton(
        tooltip: '처리할 일 펼치기',
        onPressed: onExpand,
        icon: const GroupIcon('list_caret_down', size: 18),
      ),
    ],
  );
}
