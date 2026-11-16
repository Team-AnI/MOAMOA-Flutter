import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

import '../auth_terms.dart';

/// 이용약관·개인정보 처리방침 전문을 보여주는 아래 시트
class AuthTermsSheet extends StatelessWidget {
  const AuthTermsSheet({super.key, required this.terms});

  final AuthTerms terms;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Text(terms.title, style: MoaText.titleM),
            ),
            // 본문
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Text(
                  terms.body,
                  style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
