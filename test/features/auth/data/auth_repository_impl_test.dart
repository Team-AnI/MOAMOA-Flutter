import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/auth_interceptor.dart';
import 'package:moamoa/core/storage/jwt.dart';
import 'package:moamoa/core/storage/token_storage.dart';
import 'package:moamoa/core/storage/token_storage_impl.dart';
import 'package:moamoa/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:moamoa/features/auth/data/repositories/auth_repository_impl.dart';

/// 서버 대신 정해 둔 응답을 돌려주고, 보낸 요청을 담는 Dio 어댑터
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.statusCode, this.body);

  final int statusCode;
  final String body;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _ok = '{"success": true, "data": null, "error": null}';

void main() {
  group(AuthRepositoryImpl, () {
    late _StubAdapter adapter;
    late TokenStorage storage;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      storage = TokenStorageImpl(secureStorage: const FlutterSecureStorage());
    });

    AuthRepositoryImpl repositoryWith(int statusCode, String body) {
      adapter = _StubAdapter(statusCode, body);
      final dio = Dio()..httpClientAdapter = adapter;
      return AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(dio: dio),
        tokenStorage: storage,
      );
    }

    const loginOk =
        '{"success": true, "error": null, '
        '"data": {"accessToken": "access", "refreshToken": "refresh"}}';

    test('로그인은 이메일과 비밀번호를 담아 POST .../login 으로 보낸다', () async {
      final repository = repositoryWith(200, loginOk);

      await repository.login(email: 'moa@example.com', password: 'moamoa123');

      final request = adapter.requests.single;
      expect(request.method, 'POST');
      expect(request.path, '/v1/auth/login');
      expect(request.data, {
        'email': 'moa@example.com',
        'password': 'moamoa123',
      });
    });

    test('로그인에 성공하면 받은 토큰을 저장한다', () async {
      final repository = repositoryWith(200, loginOk);

      await repository.login(email: 'moa@example.com', password: 'moamoa123');

      expect(
        await storage.read(),
        const Jwt(accessToken: 'access', refreshToken: 'refresh'),
      );
    });

    test('로그인이 401 이면 unauthorized 코드의 ApiException 예외가 발생한다', () async {
      final repository = repositoryWith(
        401,
        jsonEncode({
          'success': false,
          'data': null,
          'error': {
            'code': 'UNAUTHORIZED',
            'message': '이메일 또는 비밀번호가 올바르지 않습니다.',
          },
        }),
      );

      await expectLater(
        repository.login(email: 'moa@example.com', password: 'wrong123'),
        throwsA(
          const ApiException(
            code: ApiErrorCode.unauthorized,
            message: '이메일 또는 비밀번호가 올바르지 않습니다.',
          ),
        ),
      );
    });

    test('로그인에 실패하면 토큰을 저장하지 않는다', () async {
      final repository = repositoryWith(
        401,
        '{"success": false, "data": null, "error": {"code": "UNAUTHORIZED"}}',
      );

      await expectLater(
        repository.login(email: 'moa@example.com', password: 'wrong123'),
        throwsA(isA<ApiException>()),
      );

      expect(await storage.read(), isNull);
    });

    test('로그인 응답에 토큰이 없으면 unknown 코드의 ApiException 예외가 발생한다', () async {
      final repository = repositoryWith(200, _ok);

      await expectLater(
        repository.login(email: 'moa@example.com', password: 'moamoa123'),
        throwsA(const ApiException(code: ApiErrorCode.unknown)),
      );
    });

    test('로그인·재설정 메일 요청·새 비밀번호 설정은 인증이 필요 없는 요청으로 보낸다', () async {
      final repository = repositoryWith(200, loginOk);

      await repository.login(email: 'moa@example.com', password: 'moamoa123');
      await repository.requestPasswordReset(email: 'moa@example.com');
      await repository.resetPassword(token: 'abc', newPassword: 'moamoa123');

      expect(
        adapter.requests.map(
          (request) => request.extra[AuthInterceptor.requiresAuthKey],
        ),
        [false, false, false],
      );
    });

    test('재설정 메일 요청은 이메일을 담아 POST .../password-reset-requests 로 보낸다', () async {
      final repository = repositoryWith(200, _ok);

      await repository.requestPasswordReset(email: 'moa@example.com');

      final request = adapter.requests.single;
      expect(request.method, 'POST');
      expect(request.path, '/v1/auth/password-reset-requests');
      expect(request.data, {'email': 'moa@example.com'});
    });

    test('새 비밀번호 설정은 토큰과 새 비밀번호를 담아 POST .../password-resets 로 보낸다', () async {
      final repository = repositoryWith(
        200,
        '{"success": true, "data": {"success": true}, "error": null}',
      );

      await repository.resetPassword(token: 'abc', newPassword: 'moamoa123');

      final request = adapter.requests.single;
      expect(request.method, 'POST');
      expect(request.path, '/v1/auth/password-resets');
      expect(request.data, {'token': 'abc', 'newPassword': 'moamoa123'});
    });

    test('링크가 만료되면 서버의 코드와 문구를 담은 ApiException 예외가 발생한다', () async {
      final repository = repositoryWith(
        400,
        jsonEncode({
          'success': false,
          'data': null,
          'error': {'code': 'VALIDATION_ERROR', 'message': '유효하지 않은 링크입니다.'},
        }),
      );

      await expectLater(
        repository.resetPassword(token: 'old', newPassword: 'moamoa123'),
        throwsA(
          const ApiException(
            code: ApiErrorCode.validation,
            message: '유효하지 않은 링크입니다.',
          ),
        ),
      );
    });

    test('응답을 받지 못하면 network 코드의 ApiException 예외가 발생한다', () async {
      final dio = Dio()
        ..httpClientAdapter = _StubAdapter(200, _ok)
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) => handler.reject(
              DioException.connectionError(
                requestOptions: options,
                reason: '연결 실패',
              ),
            ),
          ),
        );
      final repository = AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSourceImpl(dio: dio),
        tokenStorage: storage,
      );

      await expectLater(
        repository.requestPasswordReset(email: 'moa@example.com'),
        throwsA(const ApiException(code: ApiErrorCode.network)),
      );
    });
  });
}
