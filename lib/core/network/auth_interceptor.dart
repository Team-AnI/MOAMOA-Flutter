import 'package:dio/dio.dart';

import '../storage/auth_tokens.dart';
import '../storage/token_storage.dart';

/// 인증이 필요 없는 요청(로그인·회원가입·토큰 재발급·비밀번호 찾기)에 붙이는 표시
///
/// `Options(extra: noAuthExtra)` 로 보내면 토큰을 붙이지 않고, 401 이어도 재발급하지 않습니다.
const noAuthExtra = {AuthInterceptor.requiresAuthKey: false};

/// 요청에 액세스 토큰을 붙이고, 401 이면 토큰을 재발급해 다시 보냅니다. (API 공통 사항 "인증", 7-3)
///
/// [QueuedInterceptor] 라서 여러 요청이 동시에 401 이어도 하나씩 처리합니다.
/// 먼저 처리한 요청이 재발급하면, 뒤의 요청은 바뀐 토큰으로 다시 보내기만 합니다.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required TokenStorage tokenStorage,
    required Dio plainDio,
    required void Function() onSessionExpired,
  }) : _tokenStorage = tokenStorage,
       _plainDio = plainDio,
       _onSessionExpired = onSessionExpired;

  static const requiresAuthKey = 'requiresAuth';

  final TokenStorage _tokenStorage;

  /// 재발급과 다시 보내기에 쓰는 Dio. 이 인터셉터를 붙이지 않아야 서로 기다리며 멈추지 않습니다.
  final Dio _plainDio;
  final void Function() _onSessionExpired;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_requiresAuth(options)) {
      final tokens = await _tokenStorage.read();
      if (tokens != null) _attach(options, tokens.accessToken);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    if (err.response?.statusCode != 401 || !_requiresAuth(options)) {
      return handler.next(err);
    }
    final tokens = await _tokenStorage.read();
    if (tokens == null) return handler.next(err);

    var current = tokens;
    // 다른 요청이 먼저 재발급했으면 바뀐 토큰으로 다시 보내기만 합니다.
    if (options.headers['Authorization'] == _bearer(tokens.accessToken)) {
      final refreshed = await _refresh(tokens.refreshToken);
      if (refreshed == null) return handler.next(err);
      current = refreshed;
    }

    try {
      _attach(options, current.accessToken);
      handler.resolve(await _plainDio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  /// 7-3 으로 새 토큰을 받아 저장합니다. 실패하면 null 입니다.
  ///
  /// 리프레시 토큰이 만료되거나 이미 쓰였으면(401) 토큰을 지우고 다시 로그인하게 합니다.
  Future<AuthTokens?> _refresh(String refreshToken) async {
    try {
      // 점검 페이지처럼 JSON 이 아닌 본문이 와도 타입 오류가 나지 않게 dynamic 으로 받습니다.
      final response = await _plainDio.post<dynamic>(
        '/v1/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final body = response.data;
      final data = body is Map ? body['data'] : null;
      if (data is! Map) return null;
      final accessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];
      if (accessToken is! String || newRefreshToken is! String) return null;
      final tokens = AuthTokens(
        accessToken: accessToken,
        refreshToken: newRefreshToken,
      );
      await _tokenStorage.save(tokens);
      return tokens;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _tokenStorage.clear();
        _onSessionExpired();
      }
      return null;
    }
  }

  bool _requiresAuth(RequestOptions options) =>
      options.extra[requiresAuthKey] != false;

  void _attach(RequestOptions options, String accessToken) =>
      options.headers['Authorization'] = _bearer(accessToken);

  String _bearer(String accessToken) => 'Bearer $accessToken';
}
