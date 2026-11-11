import 'dart:async';

import 'package:moamoa/features/auth/domain/repositories/auth_repository.dart';

/// 서버 대신 요청을 기록하는 테스트용 저장소
class FakeAuthRepository implements AuthRepository {
  /// 재설정 메일을 요청한 이메일 (호출 순서대로)
  final List<String> requestedEmails = [];

  /// 새 비밀번호 설정 요청 (호출 순서대로)
  final List<({String token, String newPassword})> resets = [];

  /// 값이 있으면 모든 요청이 이 예외로 실패합니다.
  Exception? error;

  /// 값이 있으면 응답을 complete 될 때까지 붙잡아 둡니다.
  Completer<void>? gate;

  @override
  Future<void> requestPasswordReset({required String email}) async {
    requestedEmails.add(email);
    await gate?.future;
    if (error != null) throw error!;
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    resets.add((token: token, newPassword: newPassword));
    await gate?.future;
    if (error != null) throw error!;
  }
}
