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
/// 요청을 보낸 뒤 로그아웃하거나 다른 계정으로 로그인해 토큰이 바뀌었으면 다시 보내지 않습니다.
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

  /// 이 인터셉터가 마지막으로 재발급하기 전의 액세스 토큰과 재발급한 토큰
  ///
  /// 401 을 받은 요청의 토큰이 [_replacedAccessToken] 이고 저장된 토큰이 [_issuedTokens] 이면
  /// 같은 로그인에서 다른 요청이 먼저 재발급한 것이라 바뀐 토큰으로 다시 보냅니다.
  String? _replacedAccessToken;
  AuthTokens? _issuedTokens;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_requiresAuth(options)) {
      try {
        final tokens = await _tokenStorage.read();
        if (tokens != null) _attach(options, tokens.accessToken);
      } on Exception {
        // 저장소를 읽지 못하면 토큰 없이 보냅니다. 여기서 멈추면 뒤의 요청까지 모두 기다립니다.
      }
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
    // 어떤 예외가 나도 handler 를 부릅니다. 부르지 않으면 뒤의 요청까지 모두 멈춥니다.
    try {
      final tokens = await _tokenStorage.read();
      if (tokens == null) return handler.next(err);

      final sentAuthorization = options.headers['Authorization'];
      var current = tokens;
      if (sentAuthorization == _bearer(tokens.accessToken)) {
        final refreshed = await _refresh(tokens);
        if (refreshed == null) return handler.next(err);
        current = refreshed;
      } else if (!_isRefreshedAfter(sentAuthorization, tokens)) {
        // 보낸 뒤 로그아웃·다른 계정 로그인으로 토큰이 바뀌었으면 다른 계정으로 다시 보내지 않습니다.
        return handler.next(err);
      }

      _attach(options, current.accessToken);
      handler.resolve(await _plainDio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    } on Exception {
      // 토큰 저장소 오류 등은 원래 401 오류로 넘깁니다.
      handler.next(err);
    }
  }

  /// 7-3 으로 새 토큰을 받아 저장합니다. 실패하면 null 입니다.
  ///
  /// 리프레시 토큰이 만료되거나 이미 쓰였으면(401) 토큰을 지우고 다시 로그인하게 합니다.
  /// 재발급하는 사이 로그아웃하거나 다른 계정으로 로그인했으면 결과를 저장하거나 지우지 않습니다.
  Future<AuthTokens?> _refresh(AuthTokens previous) async {
    try {
      // 점검 페이지처럼 JSON 이 아닌 본문이 와도 타입 오류가 나지 않게 dynamic 으로 받습니다.
      final response = await _plainDio.post<dynamic>(
        '/v1/auth/refresh',
        data: {'refreshToken': previous.refreshToken},
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
      final saved = await _tokenStorage.saveIfUnchanged(
        refreshToken: previous.refreshToken,
        tokens: tokens,
      );
      if (!saved) return null;
      _replacedAccessToken = previous.accessToken;
      _issuedTokens = tokens;
      return tokens;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // 토큰을 지우지 못해도 다시 로그인해야 한다는 사실은 알립니다.
        var sameSession = true;
        try {
          sameSession = await _tokenStorage.clearIfUnchanged(
            refreshToken: previous.refreshToken,
          );
        } finally {
          if (sameSession) _onSessionExpired();
        }
      }
      return null;
    }
  }

  /// [sentAuthorization] 로 보낸 뒤 같은 로그인에서 이 인터셉터가 재발급해 [stored] 가 됐는지
  bool _isRefreshedAfter(Object? sentAuthorization, AuthTokens stored) {
    final replacedAccessToken = _replacedAccessToken;
    return replacedAccessToken != null &&
        sentAuthorization == _bearer(replacedAccessToken) &&
        stored == _issuedTokens;
  }

  bool _requiresAuth(RequestOptions options) =>
      options.extra[requiresAuthKey] != false;

  void _attach(RequestOptions options, String accessToken) =>
      options.headers['Authorization'] = _bearer(accessToken);

  String _bearer(String accessToken) => 'Bearer $accessToken';
}
