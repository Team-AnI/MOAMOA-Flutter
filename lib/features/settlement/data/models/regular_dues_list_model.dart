import 'package:freezed_annotation/freezed_annotation.dart';

import 'regular_due_model.dart';

part 'regular_dues_list_model.freezed.dart';
part 'regular_dues_list_model.g.dart';

@freezed
abstract class RegularDuesListModel with _$RegularDuesListModel {
  const factory RegularDuesListModel({
    required List<RegularDueModel> regularDues,
  }) = _RegularDuesListModel;
  factory RegularDuesListModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDuesListModelFromJson(json);
}
