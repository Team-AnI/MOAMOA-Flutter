import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/reset_password_state.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/reset_password_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/reset_password_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ResetPasswordViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          // 로그인한 기기에서 메일 링크를 연 상태
          initialAuthStatusProvider.overrideWithValue(
            AuthSessionStatus.authenticated,
          ),
        ],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(passwordResetProvider, (_, _) {});
    });

    ResetPasswordViewModel viewModel() =>
        container.read(passwordResetProvider.notifier);

    test('요청에 성공하면 성공 단계가 된다', () async {
      await viewModel().submit(token: 'abc', newPassword: 'moamoa123');

      expect(repository.resets, [(token: 'abc', newPassword: 'moamoa123')]);
      expect(
        container.read(passwordResetProvider).status,
        ResetPasswordStatus.success,
      );
    });

    test('요청에 성공하면 로그인해 있던 기기도 로그아웃 상태가 된다', () async {
      await viewModel().submit(token: 'abc', newPassword: 'moamoa123');

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('요청에 실패하면 로그인 상태를 그대로 둔다', () async {
      repository.error = const ApiException(code: ApiErrorCode.validation);

      await viewModel().submit(token: 'abc', newPassword: 'moamoa123');

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('서버가 validation 오류를 주면 링크 만료로 본다', () async {
      repository.error = const ApiException(code: ApiErrorCode.validation);

      await viewModel().submit(token: 'old', newPassword: 'moamoa123');

      final state = container.read(passwordResetProvider);
      expect(state.status, ResetPasswordStatus.failure);
      expect(state.isLinkExpired, isTrue);
    });

    test('네트워크 오류는 링크 만료로 보지 않는다', () async {
      repository.error = const ApiException(code: ApiErrorCode.network);

      await viewModel().submit(token: 'abc', newPassword: 'moamoa123');

      expect(container.read(passwordResetProvider).isLinkExpired, isFalse);
    });

    test('요청 중에 다시 요청해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = viewModel().submit(token: 'abc', newPassword: 'moamoa123');
      await viewModel().submit(token: 'abc', newPassword: 'moamoa123');
      repository.gate!.complete();
      await first;

      expect(repository.resets, hasLength(1));
    });
  });
}
