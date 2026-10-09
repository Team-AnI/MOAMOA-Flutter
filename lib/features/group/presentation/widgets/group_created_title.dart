/// 한글 마지막 음절의 받침 유무에 맞춰 주격 조사를 선택합니다.
String groupCreatedTitle(String name) {
  final trimmed = name.trim();
  final code = trimmed.isEmpty ? 0 : trimmed.runes.last;
  final isHangul = code >= 0xac00 && code <= 0xd7a3;
  final particle = isHangul && (code - 0xac00) % 28 == 0 ? '가' : '이';
  return '$trimmed$particle 만들어졌어요';
}
