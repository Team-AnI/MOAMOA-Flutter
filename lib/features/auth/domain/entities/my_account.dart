import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

part 'my_account.freezed.dart';

/// 내 정보 (7-7). 내 계정·프로필 편집 화면에서 씁니다.
@freezed
abstract class MyAccount with _$MyAccount {
  const factory MyAccount({
    required String name,
    required String email,

    /// 선택 입력이라 없으면 null 입니다.
    String? phone,
    required ProfileColor profileColor,
  }) = _MyAccount;
}
