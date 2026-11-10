import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/network/auth_interceptor.dart';
import 'package:moamoa/core/storage/auth_tokens.dart';
import 'package:moamoa/core/storage/token_storage.dart';

/// 서버 대신 응답하는 Dio 어댑터
///
/// `Bearer new-access` 또는 [validAccessToken] 이면 200, 아니면 401 을 돌려줍니다.
/// `/v1/auth/refresh` 는 [refreshStatus] 로 응답합니다.
class _FakeServer implements HttpClientAdapter {
  String validAccessToken = 'access';
  int refreshStatus = 200;
  int refreshCount = 0;

  /// true 이면 재발급이 200 이지만 본문이 JSON 이 아닌 HTML 입니다. (점검 페이지 등)
  bool refreshReturnsHtml = false;

  /// 값이 있으면 재발급 응답을 complete 될 때까지 붙잡아 둡니다.
  Completer<void>? refreshGate;

  /// 재발급 뒤 다시 보낸 요청에 돌려줄 상태 코드 (기본 200)
  int retryStatus = 200;

  /// 값이 있으면 토큰과 관계없이 이 상태 코드로 응답합니다. (재발급 경로 제외)
  int? fixedStatus;

  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (options.path == '/v1/auth/refresh') {
      refreshCount++;
      await refreshGate?.future;
      if (refreshStatus != 200) return _json(refreshStatus, _error);
      if (refreshReturnsHtml) {
        return ResponseBody.fromString(
          '<html>점검 중</html>',
          200,
          headers: {
            Headers.contentTypeHeader: ['text/html'],
          },
        );
      }
      return _json(200, {
        'success': true,
        'data': {'accessToken': 'new-access', 'refreshToken': 'new-refresh'},
      });
    }
    final fixedStatus = this.fixedStatus;
    if (fixedStatus != null) return _json(fixedStatus, _error);
    final auth = options.headers['Authorization'];
    if (auth == 'Bearer new-access') return _json(retryStatus, {'data': {}});
    if (auth == 'Bearer $validAccessToken') return _json(200, {'data': {}});
    return _json(401, _error);
  }

  static const _error = {
    'success': false,
    'error': {'code': 'UNAUTHORIZED', 'message': '인증이 필요합니다.'},
  };

  ResponseBody _json(int status, Object body) => ResponseBody.fromString(
    jsonEncode(body),
    status,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

void main() {
  group(AuthInterceptor, () {
    late _FakeServer server;
    late TokenStorage storage;
    late Dio dio;
    late int expiredCount;

    setUp(() async {
      FlutterSecureStorage.setMockInitialValues({});
      storage = const TokenStorage(secureStorage: FlutterSecureStorage());
      await storage.save(
        const AuthTokens(accessToken: 'access', refreshToken: 'refresh'),
      );
      server = _FakeServer();
      expiredCount = 0;
      final options = BaseOptions(baseUrl: 'https://api.test');
      dio = Dio(options)
        ..httpClientAdapter = server
        ..interceptors.add(
          AuthInterceptor(
            tokenStorage: storage,
            plainDio: Dio(options)..httpClientAdapter = server,
            onSessionExpired: () => expiredCount++,
          ),
        );
    });

    test('저장된 액세스 토큰을 Authorization 헤더에 붙인다', () async {
      await dio.get<dynamic>('/v1/me');

      expect(server.requests.single.headers['Authorization'], 'Bearer access');
    });

    test('저장된 토큰이 없으면 Authorization 헤더를 붙이지 않는다', () async {
      await storage.clear();

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(isA<DioException>()),
      );

      expect(server.requests.single.headers['Authorization'], isNull);
    });

    test('인증이 필요 없는 요청에는 토큰을 붙이지 않는다', () async {
      server.validAccessToken = 'unused';

      await expectLater(
        dio.post<dynamic>(
          '/v1/auth/login',
          options: Options(extra: noAuthExtra),
        ),
        throwsA(isA<DioException>()),
      );

      expect(server.requests.single.headers['Authorization'], isNull);
    });

    test('인증이 필요 없는 요청이 401 이면 재발급하지 않는다', () async {
      await expectLater(
        dio.post<dynamic>(
          '/v1/auth/login',
          options: Options(extra: noAuthExtra),
        ),
        throwsA(isA<DioException>()),
      );

      expect(server.refreshCount, 0);
    });

    test('401 이 아닌 오류(403)는 재발급하지 않는다', () async {
      server.fixedStatus = 403;

      await expectLater(
        dio.get<dynamic>('/v1/meetings/1'),
        throwsA(isA<DioException>()),
      );

      expect(server.refreshCount, 0);
    });

    test('401 이면 토큰을 재발급해 원래 요청을 다시 보내 성공한다', () async {
      server.validAccessToken = 'expired-on-server';

      final response = await dio.get<dynamic>('/v1/me');

      expect(response.statusCode, 200);
      expect(
        server.requests.last.headers['Authorization'],
        'Bearer new-access',
      );
    });

    test('타입을 지정한 요청도 재발급 뒤 응답 본문을 그대로 받는다', () async {
      server.validAccessToken = 'expired-on-server';

      final response = await dio.get<Map<String, dynamic>>('/v1/me');

      expect(response.data, {'data': <String, dynamic>{}});
    });

    test('재발급하면 새 토큰을 저장한다', () async {
      server.validAccessToken = 'expired-on-server';

      await dio.get<dynamic>('/v1/me');

      expect(
        await storage.read(),
        const AuthTokens(
          accessToken: 'new-access',
          refreshToken: 'new-refresh',
        ),
      );
    });

    test('재발급은 저장된 리프레시 토큰으로 요청한다', () async {
      server.validAccessToken = 'expired-on-server';

      await dio.get<dynamic>('/v1/me');

      final refresh = server.requests.firstWhere(
        (r) => r.path == '/v1/auth/refresh',
      );
      expect(refresh.data, {'refreshToken': 'refresh'});
    });

    test('동시에 여러 요청이 401 이어도 재발급은 한 번만 한다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..refreshGate = Completer<void>();

      final requests = [
        dio.get<dynamic>('/v1/me'),
        dio.get<dynamic>('/v1/me/meetings'),
        dio.get<dynamic>('/v1/meetings/1'),
      ];
      await Future<void>.delayed(Duration.zero);
      server.refreshGate!.complete();
      final responses = await Future.wait(requests);

      expect(responses.map((r) => r.statusCode), [200, 200, 200]);
      expect(server.refreshCount, 1);
    });

    test('재발급도 401 이면 저장된 토큰을 지운다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..refreshStatus = 401;

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(isA<DioException>()),
      );

      expect(await storage.read(), isNull);
    });

    test('재발급도 401 이면 다시 로그인해야 한다고 알린다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..refreshStatus = 401;

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(isA<DioException>()),
      );

      expect(expiredCount, 1);
    });

    test('재발급이 401 이 아닌 이유로 실패하면 토큰을 지우지 않는다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..refreshStatus = 500;

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );

      expect(await storage.read(), isNotNull);
      expect(expiredCount, 0);
    });

    test('재발급 응답이 JSON 이 아니면 멈추지 않고 원래 401 오류를 넘긴다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..refreshReturnsHtml = true;

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
    });

    test('재발급 응답이 JSON 이 아니면 저장된 토큰을 그대로 둔다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..refreshReturnsHtml = true;

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(isA<DioException>()),
      );

      expect(
        await storage.read(),
        const AuthTokens(accessToken: 'access', refreshToken: 'refresh'),
      );
    });

    test('재발급 뒤 다시 보낸 요청이 실패하면 그 오류를 넘긴다', () async {
      server
        ..validAccessToken = 'expired-on-server'
        ..retryStatus = 404;

      await expectLater(
        dio.get<dynamic>('/v1/me'),
        throwsA(
          isA<DioException>().having(
            (e) => e.response?.statusCode,
            'statusCode',
            404,
          ),
        ),
      );
    });
  });
}
