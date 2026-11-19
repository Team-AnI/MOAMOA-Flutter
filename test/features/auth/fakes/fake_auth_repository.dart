import 'dart:async';

import 'package:moamoa/core/constants/profile_color.dart';
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

  /// 회원가입 요청 (호출 순서대로)
  final List<
    ({
      String name,
      String email,
      String password,
      String? phone,
      bool agreedToTerms,
    })
  >
  signUps = [];

  /// 저장을 요청한 프로필 색 (호출 순서대로)
  final List<ProfileColor> profileColors = [];

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    String? phone,
    required bool agreedToTerms,
  }) async {
    signUps.add((
      name: name,
      email: email,
      password: password,
      phone: phone,
      agreedToTerms: agreedToTerms,
    ));
    await gate?.future;
    if (error != null) throw error!;
  }

  @override
  Future<void> updateProfileColor({required ProfileColor color}) async {
    profileColors.add(color);
    await gate?.future;
    if (error != null) throw error!;
  }

  /// 로그인을 요청한 이메일·비밀번호 (호출 순서대로)
  final List<({String email, String password})> logins = [];

  @override
  Future<void> login({required String email, required String password}) async {
    logins.add((email: email, password: password));
    await gate?.future;
    if (error != null) throw error!;
  }

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
