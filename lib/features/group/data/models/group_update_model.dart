import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group.dart';

part 'group_update_model.freezed.dart';
part 'group_update_model.g.dart';

/// 수정 응답에는 역할과 구성원 수가 포함되지 않습니다.
@freezed
abstract class GroupUpdateModel with _$GroupUpdateModel {
  const factory GroupUpdateModel({
    required int meetingId,
    required String name,
    String? description,
  }) = _GroupUpdateModel;

  factory GroupUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$GroupUpdateModelFromJson(json);
}

extension GroupUpdateModelX on GroupUpdateModel {
  Group toEntity() =>
      Group(id: meetingId, name: name, description: description);
}
