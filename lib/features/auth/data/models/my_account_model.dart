import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import '../../domain/entities/my_account.dart';

part 'my_account_model.freezed.dart';
part 'my_account_model.g.dart';

/// 내 정보 조회(7-7)·수정(7-8) 응답. 앱은 userId 를 쓰지 않아 담지 않습니다.
@freezed
abstract class MyAccountModel with _$MyAccountModel {
  const factory MyAccountModel({
    required String name,
    required String email,
    String? phone,

    /// LIGHT_BLUE·GRAY·BLUE·DARK
    String? profileColor,
  }) = _MyAccountModel;

  factory MyAccountModel.fromJson(Map<String, dynamic> json) =>
      _$MyAccountModelFromJson(json);
}

extension MyAccountModelX on MyAccountModel {
  MyAccount toEntity() => MyAccount(
    name: name,
    email: email,
    phone: phone,
    profileColor: ProfileColor.fromServer(profileColor),
  );
}
