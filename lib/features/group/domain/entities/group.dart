/// API 응답 형식과 독립적인 모임 정보입니다.
class Group {
  const Group({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.memberCount,
  });

  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final int? memberCount;
}
