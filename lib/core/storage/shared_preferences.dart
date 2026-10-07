import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

/// 일반 설정 값 저장소
///
/// 앱 시작 전에 `main()` 에서 인스턴스를 미리 불러와 `ProviderScope` 의
/// `overrides` 로 주입하므로, 이후에는 동기적으로 사용할 수 있습니다.
/// 테스트에서도 `overrideWithValue` 로 주입해야 합니다.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('main() 의 ProviderScope 에서 override 해야 합니다.');
}
