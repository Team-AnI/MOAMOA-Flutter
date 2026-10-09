import 'package:flutter/material.dart';
import 'group_design.dart';
import 'group_icon.dart';

class GroupPhotoSheet extends StatelessWidget {
  const GroupPhotoSheet({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: SizedBox(
      height: 340 - MediaQuery.paddingOf(context).bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xffd2d2d7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Text('모임 사진', style: GroupDesign.heading),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              color: GroupDesign.fill,
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    const _PhotoOption(title: '앨범에서 선택', icon: 'photo_album'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(height: 1, color: Colors.white),
                    ),
                    const _PhotoOption(title: '사진 찍기', icon: 'photo_camera'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(height: 1, color: Colors.white),
                    ),
                    _PhotoOption(
                      title: '기본 이미지로 바꾸기',
                      icon: 'photo_reset',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _PhotoOption extends StatelessWidget {
  const _PhotoOption({required this.title, required this.icon, this.onTap});
  final String title, icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    enabled: onTap != null,
    child: Tooltip(
      message: onTap == null ? '사진 선택·촬영은 아직 지원되지 않아요.' : '',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GroupIcon(icon, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: GroupDesign.body.copyWith(
                    color: GroupDesign.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
