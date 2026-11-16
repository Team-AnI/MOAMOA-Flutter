import 'package:moamoa/core/constants/profile_color.dart';

import '../entities/my_account.dart';

/// 회원·인증 (API 7)
///
/// 실패하면 ApiException 을 던집니다.
abstract interface class AuthRepository {
  /// 7-1 회원가입. 성공하면 받은 토큰을 토큰 저장소에 저장합니다.
  ///
  /// 이미 가입했거나 탈퇴 후 7일이 지나지 않은 이메일이면 conflict 오류입니다.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    String? phone,
    required bool agreedToTerms,
  });

  /// 7-2 로그인. 성공하면 받은 토큰을 토큰 저장소에 저장합니다.
  ///
  /// 이메일·비밀번호가 틀렸거나 탈퇴한 사용자면 unauthorized 오류입니다. (무엇이 틀렸는지 구분하지 않음)
  Future<void> login({required String email, required String password});

  /// 7-5 비밀번호 재설정 메일 요청. 가입하지 않은 이메일도 같은 응답입니다.
  Future<void> requestPasswordReset({required String email});

  /// 7-6 새 비밀번호 설정. 링크가 만료되었거나 이미 쓰였으면 validation 오류입니다.
  ///
  /// 성공하면 이 기기의 토큰을 지웁니다. 새 비밀번호로 다시 로그인해야 합니다.
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  /// 7-4 로그아웃. 서버에 이 기기의 리프레시 토큰을 지우라고 요청한 뒤, 성공·실패와 관계없이 기기의 토큰을 지웁니다.
  ///
  /// 서버 요청이 실패해도 오류를 던지지 않습니다. 이 기기의 토큰을 지우지 못했을 때만 오류를 던집니다.
  Future<void> logout();

  /// 7-9 회원 탈퇴. 성공하면 기기의 토큰을 지웁니다.
  ///
  /// 비밀번호가 틀리면 validation 오류(400), 혼자 관리자인 모임이나 미납 정산이 있으면
  /// unprocessableEntity 오류(422)이고, 이때는 토큰을 지우지 않습니다.
  Future<void> withdraw({required String password});

  /// 7-7 내 정보 조회
  Future<MyAccount> getMyAccount();

  /// 7-8 프로필 편집. [phone] 이 null 이면 저장된 휴대폰 번호를 지웁니다.
  Future<MyAccount> updateMyProfile({
    required String name,
    required String? phone,
    required ProfileColor color,
  });

  /// 7-8 내 프로필 색 변경 (가입 직후)
  Future<void> updateProfileColor({required ProfileColor color});
}
