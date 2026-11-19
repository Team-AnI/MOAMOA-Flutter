import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/domain/usecases/request_password_reset.dart';
import 'package:moamoa/features/auth/domain/usecases/reset_password.dart';
import 'package:moamoa/features/auth/domain/usecases/sign_up_with_email.dart';
import 'package:moamoa/features/auth/domain/usecases/update_profile_color.dart';
import 'package:moamoa/features/auth/domain/usecases/login_with_email.dart';

import '../fakes/fake_auth_repository.dart';

void main() {
  late FakeAuthRepository repository;

  setUp(() => repository = FakeAuthRepository());

  group(RequestPasswordReset, () {
    test('이메일 앞뒤 공백을 빼고 재설정 메일을 요청한다', () async {
      final requestPasswordReset = RequestPasswordResetImpl(
        authRepository: repository,
      );

      await requestPasswordReset(
        const RequestPasswordResetParams(email: ' moa@example.com '),
      );

      expect(repository.requestedEmails, ['moa@example.com']);
    });

    test('이메일 형식이 다르면 validation 예외가 발생한다', () async {
      final requestPasswordReset = RequestPasswordResetImpl(
        authRepository: repository,
      );

      await expectLater(
        requestPasswordReset(const RequestPasswordResetParams(email: 'moa')),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.validation,
          ),
        ),
      );
      expect(repository.requestedEmails, isEmpty);
    });
  });

  group(ResetPassword, () {
    test('토큰과 새 비밀번호로 비밀번호 변경을 요청한다', () async {
      final resetPassword = ResetPasswordImpl(authRepository: repository);

      await resetPassword(
        const ResetPasswordParams(token: 'abc', newPassword: 'moamoa123'),
      );

      expect(repository.resets, [(token: 'abc', newPassword: 'moamoa123')]);
    });

    test('비밀번호 규칙에 맞지 않으면 validation 예외가 발생한다', () async {
      final resetPassword = ResetPasswordImpl(authRepository: repository);

      await expectLater(
        resetPassword(
          const ResetPasswordParams(token: 'abc', newPassword: 'short1'),
        ),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.validation,
          ),
        ),
      );
      expect(repository.resets, isEmpty);
    });
  });

  group(LoginWithEmail, () {
    test('이메일 앞뒤 공백을 빼고 비밀번호는 그대로 로그인을 요청한다', () async {
      final loginWithEmail = LoginWithEmailImpl(authRepository: repository);

      await loginWithEmail(
        const LoginWithEmailParams(
          email: ' moa@example.com ',
          password: ' moamoa123',
        ),
      );

      expect(repository.logins, [
        (email: 'moa@example.com', password: ' moamoa123'),
      ]);
    });

    test('이메일 형식이 다르면 validation 예외가 발생한다', () async {
      final loginWithEmail = LoginWithEmailImpl(authRepository: repository);

      await expectLater(
        loginWithEmail(
          const LoginWithEmailParams(email: 'moa', password: 'moamoa123'),
        ),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.validation,
          ),
        ),
      );
      expect(repository.logins, isEmpty);
    });

    test('비밀번호가 비었으면 validation 예외가 발생한다', () async {
      final loginWithEmail = LoginWithEmailImpl(authRepository: repository);

      await expectLater(
        loginWithEmail(
          const LoginWithEmailParams(email: 'moa@example.com', password: ''),
        ),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.validation,
          ),
        ),
      );
      expect(repository.logins, isEmpty);
    });
  });
  group(SignUpWithEmail, () {
    SignUpWithEmailParams params({
      String name = '이서연',
      String email = 'moa@example.com',
      String password = 'moamoa123',
      String phone = '',
      bool agreedToTerms = true,
    }) => SignUpWithEmailParams(
      name: name,
      email: email,
      password: password,
      phone: phone,
      agreedToTerms: agreedToTerms,
    );

    final validation = throwsA(
      isA<ApiException>().having(
        (e) => e.code,
        'code',
        ApiErrorCode.validation,
      ),
    );

    test('이름·이메일·휴대폰은 앞뒤 공백을 빼고 가입을 요청한다', () async {
      final signUp = SignUpWithEmailImpl(authRepository: repository);

      await signUp(
        params(
          name: ' 이서연 ',
          email: ' moa@example.com ',
          password: 'moamoa123',
          phone: ' 010-1234-5678 ',
        ),
      );

      expect(repository.signUps, [
        (
          name: '이서연',
          email: 'moa@example.com',
          password: 'moamoa123',
          phone: '010-1234-5678',
          agreedToTerms: true,
        ),
      ]);
    });

    test('휴대폰 번호가 비어 있으면 휴대폰 번호 없이 가입을 요청한다', () async {
      final signUp = SignUpWithEmailImpl(authRepository: repository);

      await signUp(params(phone: '  '));

      expect(repository.signUps.single.phone, isNull);
    });

    test('이름이 비었으면 validation 예외가 발생한다', () async {
      final signUp = SignUpWithEmailImpl(authRepository: repository);

      await expectLater(signUp(params(name: ' ')), validation);
      expect(repository.signUps, isEmpty);
    });

    test('비밀번호 규칙에 맞지 않으면 validation 예외가 발생한다', () async {
      final signUp = SignUpWithEmailImpl(authRepository: repository);

      await expectLater(signUp(params(password: 'moamoa')), validation);
      expect(repository.signUps, isEmpty);
    });

    test('약관에 동의하지 않았으면 validation 예외가 발생한다', () async {
      final signUp = SignUpWithEmailImpl(authRepository: repository);

      await expectLater(signUp(params(agreedToTerms: false)), validation);
      expect(repository.signUps, isEmpty);
    });
  });

  group(UpdateProfileColor, () {
    test('고른 프로필 색으로 저장을 요청한다', () async {
      final updateProfileColor = UpdateProfileColorImpl(
        authRepository: repository,
      );

      await updateProfileColor(
        const UpdateProfileColorParams(color: ProfileColor.blue),
      );

      expect(repository.profileColors, [ProfileColor.blue]);
    });
  });
}
