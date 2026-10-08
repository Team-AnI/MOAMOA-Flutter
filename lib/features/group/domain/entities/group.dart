/// API 응답 형식과 독립적인 모임 정보입니다.
class Group {
  const Group({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.memberCount,
  }) : assert(memberCount == null || memberCount >= 0, '구성원 수는 음수일 수 없습니다.');

  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final int? memberCount;
}
