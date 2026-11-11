import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/forgot_password_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/forgot_password_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ForgotPasswordViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(forgotPasswordProvider, (_, _) {});
    });

    ForgotPasswordViewModel viewModel() =>
        container.read(forgotPasswordProvider.notifier);

    test('처음에는 요청 전 단계다', () {
      expect(
        container.read(forgotPasswordProvider).status,
        ForgotPasswordStatus.initial,
      );
    });

    test('요청에 성공하면 보냄 단계가 된다', () async {
      await viewModel().request('moa@example.com');

      expect(repository.requestedEmails, ['moa@example.com']);
      expect(
        container.read(forgotPasswordProvider).status,
        ForgotPasswordStatus.sent,
      );
    });

    test('요청에 실패하면 오류를 담은 실패 단계가 된다', () async {
      const error = ApiException(code: ApiErrorCode.network);
      repository.error = error;

      await viewModel().request('moa@example.com');

      final state = container.read(forgotPasswordProvider);
      expect(state.status, ForgotPasswordStatus.failure);
      expect(state.error, error);
    });

    test('요청 중에 다시 요청해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = viewModel().request('moa@example.com');
      expect(
        container.read(forgotPasswordProvider).status,
        ForgotPasswordStatus.sending,
      );
      await viewModel().request('moa@example.com');
      repository.gate!.complete();
      await first;

      expect(repository.requestedEmails, hasLength(1));
    });
  });
}
