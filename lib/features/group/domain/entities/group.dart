import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';

/// API 응답 형식과 독립적인 모임 정보입니다.
@freezed
abstract class Group with _$Group {
  const factory Group({
    required int id,
    required String name,
    String? description,
    int? memberCount,
  }) = _Group;
}
