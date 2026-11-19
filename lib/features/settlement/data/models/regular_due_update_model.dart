import 'package:freezed_annotation/freezed_annotation.dart';
part 'regular_due_update_model.freezed.dart';
part 'regular_due_update_model.g.dart';

@freezed
abstract class RegularDueUpdateModel with _$RegularDueUpdateModel {
  const factory RegularDueUpdateModel({bool? currentSettlementApplied}) =
      _RegularDueUpdateModel;
  factory RegularDueUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueUpdateModelFromJson(json);
}
