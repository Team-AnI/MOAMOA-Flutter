/// 회원·인증 (API 7)
///
/// 실패하면 ApiException 을 던집니다.
abstract interface class AuthRepository {
  /// 7-5 비밀번호 재설정 메일 요청. 가입하지 않은 이메일도 같은 응답입니다.
  Future<void> requestPasswordReset({required String email});

  /// 7-6 새 비밀번호 설정. 링크가 만료되었거나 이미 쓰였으면 validation 오류입니다.
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}
