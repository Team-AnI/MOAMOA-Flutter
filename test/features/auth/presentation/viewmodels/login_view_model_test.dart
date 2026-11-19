import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/core/network/dio_provider.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/login_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/login_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

/// 서버 대신 정해 둔 성공 응답을 돌려주는 Dio 어댑터
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.body);

  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group(LoginViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(loginProvider, (_, _) {});
    });

    LoginViewModel viewModel() => container.read(loginProvider.notifier);

    Future<void> login() =>
        viewModel().login(email: 'moa@example.com', password: 'moamoa123');

    test('로그인에 성공하면 앱 전체 로그인 상태가 로그인한 상태가 된다', () async {
      await login();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('로그인에 성공하면 성공 단계가 된다', () async {
      await login();

      expect(container.read(loginProvider).status, LoginStatus.success);
    });

    test('로그인에 실패하면 오류를 담은 실패 단계가 된다', () async {
      const error = ApiException(code: ApiErrorCode.unauthorized);
      repository.error = error;

      await login();

      final state = container.read(loginProvider);
      expect(state.status, LoginStatus.failure);
      expect(state.error, error);
    });

    test('로그인에 실패하면 앱 전체 로그인 상태를 바꾸지 않는다', () async {
      repository.error = const ApiException(code: ApiErrorCode.unauthorized);

      await login();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('요청 중에 다시 요청해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = login();
      expect(container.read(loginProvider).status, LoginStatus.submitting);
      await login();
      repository.gate!.complete();
      await first;

      expect(repository.logins, hasLength(1));
    });

    test('로그인 응답에 토큰 필드가 빠지면 실패 단계가 된다', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final dio = Dio()
        ..httpClientAdapter = _StubAdapter(
          '{"success": true, "data": {}, "error": null}',
        );
      final container = ProviderContainer.test(
        overrides: [dioProvider.overrideWithValue(dio)],
        retry: (_, _) => null,
      );
      container.listen(loginProvider, (_, _) {});

      await container
          .read(loginProvider.notifier)
          .login(email: 'moa@example.com', password: 'moamoa123');

      expect(container.read(loginProvider).status, LoginStatus.failure);
    });
  });
}
