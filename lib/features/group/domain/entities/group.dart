/// API 응답 형식과 독립적인 모임 정보입니다.
class Group {
  const Group({
    required this.id,
    required this.name,
    this.description,
    this.memberCount,
  }) : assert(memberCount == null || memberCount >= 0, '구성원 수는 음수일 수 없습니다.');

  final int id;
  final String name;
  final String? description;
  final int? memberCount;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          memberCount == other.memberCount;
  @override
  int get hashCode => Object.hash(id, name, description, memberCount);
}
