import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/withdrawal_state.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/withdrawal_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/withdrawal_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(WithdrawalViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          initialAuthStatusProvider.overrideWithValue(
            AuthSessionStatus.authenticated,
          ),
        ],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(withdrawalProvider, (_, _) {});
    });

    WithdrawalViewModel viewModel() =>
        container.read(withdrawalProvider.notifier);

    Future<void> withdraw() => viewModel().withdraw(password: 'moamoa123');

    test('탈퇴하면 성공 단계가 된다', () async {
      await withdraw();

      expect(
        container.read(withdrawalProvider).status,
        WithdrawalStatus.success,
      );
    });

    test('탈퇴하면 앱 전체 로그인 상태가 로그인하지 않은 상태가 된다', () async {
      await withdraw();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('성공 단계로 바뀐 뒤에 로그인하지 않은 상태가 된다', () async {
      final order = <String>[];
      container.listen(withdrawalProvider, (_, next) {
        if (next.status == WithdrawalStatus.success) order.add('success');
      });
      container.listen(authSessionProvider, (_, next) {
        if (next == AuthSessionStatus.unauthorized) order.add('signOut');
      });

      await withdraw();

      expect(order, ['success', 'signOut']);
    });

    test('비밀번호가 틀리면 비밀번호 오류로 보는 실패 단계가 된다', () async {
      repository.error = const ApiException(code: ApiErrorCode.validation);

      await withdraw();

      final state = container.read(withdrawalProvider);
      expect(state.status, WithdrawalStatus.failure);
      expect(state.isWrongPassword, isTrue);
    });

    test('탈퇴할 수 없으면 비밀번호 오류가 아닌 실패 단계가 된다', () async {
      repository.error = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
      );

      await withdraw();

      final state = container.read(withdrawalProvider);
      expect(state.status, WithdrawalStatus.failure);
      expect(state.isWrongPassword, isFalse);
    });

    test('탈퇴에 실패하면 로그인 상태를 바꾸지 않는다', () async {
      repository.error = const ApiException(
        code: ApiErrorCode.unprocessableEntity,
      );

      await withdraw();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('요청 중에 다시 요청해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = withdraw();
      await withdraw();
      repository.gate!.complete();
      await first;

      expect(repository.withdrawals, hasLength(1));
    });
  });
}
