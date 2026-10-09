import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';

/// API 응답 형식과 독립적인 모임 정보입니다.
@freezed
abstract class Group with _$Group {
  @Assert('memberCount == null || memberCount >= 0', '구성원 수는 음수일 수 없습니다.')
  const factory Group({
    required int id,
    required String name,
    String? description,
    int? memberCount,
  }) = _Group;
}
