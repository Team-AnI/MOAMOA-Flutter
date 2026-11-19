import 'package:freezed_annotation/freezed_annotation.dart';
part 'regular_due_delete_model.freezed.dart';
part 'regular_due_delete_model.g.dart';

@freezed
abstract class RegularDueDeleteModel with _$RegularDueDeleteModel {
  const factory RegularDueDeleteModel({required int regularDuesId}) =
      _RegularDueDeleteModel;
  factory RegularDueDeleteModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueDeleteModelFromJson(json);
}
