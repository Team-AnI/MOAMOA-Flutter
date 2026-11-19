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
import 'package:moamoa/features/auth/presentation/viewmodels/my_account_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/my_account_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

/// 서버 대신 정해 둔 성공(200) 응답을 돌려주는 Dio 어댑터
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
  group(MyAccountViewModel, () {
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
      container.listen(myAccountProvider, (_, _) {});
    });

    MyAccountViewModel viewModel() =>
        container.read(myAccountProvider.notifier);

    /// 화면을 연 뒤 처음 불러오기가 끝날 때까지 기다립니다.
    Future<void> settle() => Future<void>.delayed(Duration.zero);

    test('처음에는 불러오는 중 상태다', () {
      expect(container.read(myAccountProvider).status, MyAccountStatus.loading);
    });

    test('화면을 열면 내 정보를 불러온다', () async {
      await settle();

      final state = container.read(myAccountProvider);
      expect(state.status, MyAccountStatus.loaded);
      expect(state.account, repository.account);
    });

    test('불러오지 못하면 오류를 담은 실패 상태가 된다', () async {
      const error = ApiException(code: ApiErrorCode.network);
      repository.error = error;

      await settle();

      final state = container.read(myAccountProvider);
      expect(state.status, MyAccountStatus.failure);
      expect(state.error, error);
    });

    test('실패한 뒤 다시 불러오면 내 정보를 보여준다', () async {
      repository.error = const ApiException(code: ApiErrorCode.network);
      await settle();
      repository.error = null;

      await viewModel().load();

      expect(container.read(myAccountProvider).status, MyAccountStatus.loaded);
    });

    test('로그아웃하면 앱 전체 로그인 상태가 로그인하지 않은 상태가 된다', () async {
      await settle();

      await viewModel().logout();

      expect(repository.logouts, 1);
      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('이 기기의 로그인 정보를 지우지 못하면 로그아웃 실패로 알린다', () async {
      await settle();
      repository.error = Exception('저장소 삭제 실패');

      await viewModel().logout();

      final state = container.read(myAccountProvider);
      expect(state.logoutFailed, isTrue);
      expect(state.isLoggingOut, isFalse);
    });

    test('이 기기의 로그인 정보를 지우지 못하면 로그인한 상태가 그대로다', () async {
      await settle();
      repository.error = Exception('저장소 삭제 실패');

      await viewModel().logout();

      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.authenticated,
      );
    });

    test('로그아웃에 실패한 뒤 다시 로그아웃하면 로그인하지 않은 상태가 된다', () async {
      await settle();
      repository.error = Exception('저장소 삭제 실패');
      await viewModel().logout();
      repository.error = null;

      await viewModel().logout();

      final state = container.read(myAccountProvider);
      expect(state.logoutFailed, isFalse);
      expect(
        container.read(authSessionProvider),
        AuthSessionStatus.unauthorized,
      );
    });

    test('내 정보 응답의 필드가 빠지면 실패 상태가 된다', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final realContainer = ProviderContainer.test(
        overrides: [
          dioProvider.overrideWithValue(
            Dio()
              ..httpClientAdapter = _StubAdapter(
                '{"success": true, "data": {}, "error": null}',
              ),
          ),
        ],
        retry: (_, _) => null,
      );
      realContainer.listen(myAccountProvider, (_, _) {});

      await pumpEventQueue();

      expect(
        realContainer.read(myAccountProvider).status,
        MyAccountStatus.failure,
      );
    });

    test('로그아웃 중에 다시 눌러도 한 번만 요청한다', () async {
      await settle();
      repository.gate = Completer<void>();

      final first = viewModel().logout();
      await viewModel().logout();
      repository.gate!.complete();
      await first;

      expect(repository.logouts, 1);
    });
  });
}
