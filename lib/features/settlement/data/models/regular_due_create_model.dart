import 'package:freezed_annotation/freezed_annotation.dart';

part 'regular_due_create_model.freezed.dart';
part 'regular_due_create_model.g.dart';

@freezed
abstract class RegularDueCreateModel with _$RegularDueCreateModel {
  const factory RegularDueCreateModel({required int regularDuesId}) =
      _RegularDueCreateModel;
  factory RegularDueCreateModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueCreateModelFromJson(json);
}
