import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/token_storage.dart';
import 'auth_interceptor.dart';
import 'auth_session.dart';

/// 서버 주소. 앱 시작 때 `bootstrap()` 이 실행 환경 값으로 덮어씁니다.
final apiBaseUrlProvider = Provider<String>((ref) => '');

/// 모든 기능이 함께 쓰는 Dio. 서버 주소와 인증(토큰 첨부·재발급)을 공통으로 처리합니다.
final dioProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: ref.watch(apiBaseUrlProvider),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );
  return Dio(options)
    ..interceptors.add(
      AuthInterceptor(
        tokenStorage: ref.watch(tokenStorageProvider),
        plainDio: Dio(options),
        onSessionExpired: () => ref.read(authSessionProvider.notifier).expire(),
      ),
    );
});
