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
import 'package:moamoa/features/auth/presentation/viewmodels/sign_up_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/sign_up_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

/// 서버 대신 정해 둔 가입 성공(201) 응답을 돌려주는 Dio 어댑터
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
      201,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group(SignUpViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(signUpProvider, (_, _) {});
    });

    SignUpViewModel viewModel() => container.read(signUpProvider.notifier);

    Future<void> signUp() => viewModel().signUp(
      name: '이서연',
      email: 'moa@example.com',
      password: 'moamoa123',
      phone: '',
      agreedToTerms: true,
    );

    test('가입에 성공하면 앱 전체 로그인 상태가 로그인한 상태가 된다', () async {
      await signUp();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('가입에 성공하면 성공 단계가 된다', () async {
      await signUp();

      expect(container.read(signUpProvider).status, SignUpStatus.success);
    });

    test('가입에 실패하면 오류를 담은 실패 단계가 된다', () async {
      const error = ApiException(code: ApiErrorCode.conflict);
      repository.error = error;

      await signUp();

      final state = container.read(signUpProvider);
      expect(state.status, SignUpStatus.failure);
      expect(state.error, error);
    });

    test('가입에 실패하면 앱 전체 로그인 상태를 바꾸지 않는다', () async {
      repository.error = const ApiException(code: ApiErrorCode.conflict);

      await signUp();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('요청 중에 다시 요청해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = signUp();
      expect(container.read(signUpProvider).status, SignUpStatus.submitting);
      await signUp();
      repository.gate!.complete();
      await first;

      expect(repository.signUps, hasLength(1));
    });

    test('가입 응답에 토큰 필드가 빠지면 실패 단계가 된다', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final dio = Dio()
        ..httpClientAdapter = _StubAdapter(
          '{"success": true, "data": {}, "error": null}',
        );
      final realContainer = ProviderContainer.test(
        overrides: [dioProvider.overrideWithValue(dio)],
        retry: (_, _) => null,
      );
      realContainer.listen(signUpProvider, (_, _) {});

      await realContainer
          .read(signUpProvider.notifier)
          .signUp(
            name: '이서연',
            email: 'moa@example.com',
            password: 'moamoa123',
            phone: '',
            agreedToTerms: true,
          );

      expect(realContainer.read(signUpProvider).status, SignUpStatus.failure);
    });
  });
}
