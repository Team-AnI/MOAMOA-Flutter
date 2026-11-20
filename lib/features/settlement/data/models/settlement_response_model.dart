import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_response_model.freezed.dart';
part 'settlement_response_model.g.dart';

/// 서버 envelope를 그대로 읽습니다. 성공 여부의 해석과 공통 오류 변환은 Repository가 담당합니다.
@Freezed(genericArgumentFactories: true)
abstract class SettlementResponseModel<T> with _$SettlementResponseModel<T> {
  const factory SettlementResponseModel({required bool success, T? data}) =
      _SettlementResponseModel<T>;
  factory SettlementResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$SettlementResponseModelFromJson(json, fromJsonT);
}
