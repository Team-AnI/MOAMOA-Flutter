/// 회원·인증 (API 7)
///
/// 실패하면 ApiException 을 던집니다.
abstract interface class AuthRepository {
  /// 7-2 로그인. 성공하면 받은 토큰을 토큰 저장소에 저장합니다.
  ///
  /// 이메일·비밀번호가 틀렸거나 탈퇴한 사용자면 unauthorized 오류입니다. (무엇이 틀렸는지 구분하지 않음)
  Future<void> login({required String email, required String password});

  /// 7-5 비밀번호 재설정 메일 요청. 가입하지 않은 이메일도 같은 응답입니다.
  Future<void> requestPasswordReset({required String email});

  /// 7-6 새 비밀번호 설정. 링크가 만료되었거나 이미 쓰였으면 validation 오류입니다.
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}
