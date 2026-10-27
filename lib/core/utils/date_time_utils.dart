/// 두 일시가 같은 순간인지 비교합니다. 둘 다 null 이면 같습니다.
/// 서버 응답은 UTC, 입력 폼은 로컬 시각이라 `==` 로는 같은 순간도 다르게 판단됩니다.
bool isSameMoment(DateTime? a, DateTime? b) {
  if (a == null || b == null) return a == b;
  return a.isAtSameMomentAs(b);
}
