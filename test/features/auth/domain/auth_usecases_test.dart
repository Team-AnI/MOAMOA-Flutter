import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/domain/usecases/request_password_reset.dart';
import 'package:moamoa/features/auth/domain/usecases/reset_password.dart';

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
}
