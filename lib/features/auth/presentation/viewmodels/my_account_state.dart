import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/my_account.dart';
import 'my_account_status.dart';

part 'my_account_state.freezed.dart';

/// 내 계정 화면 상태. 내 정보와 로그아웃 진행 여부를 담습니다.
@freezed
abstract class MyAccountState with _$MyAccountState {
  const factory MyAccountState({
    @Default(MyAccountStatus.loading) MyAccountStatus status,

    /// [status] 가 loaded 일 때만 값이 있습니다.
    MyAccount? account,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,

    /// 로그아웃 요청 중이면 true. 중복 요청을 막습니다.
    @Default(false) bool isLoggingOut,
  }) = _MyAccountState;
}
