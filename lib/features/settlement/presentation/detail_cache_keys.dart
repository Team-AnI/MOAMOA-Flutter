import 'settlement_detail_request.dart';

/// 살아 있는 상세 조회 키만 추적합니다. 캐시가 폐기되면 함께 제거합니다.
class DetailCacheKeys {
  final _keys = <SettlementDetailRequest>{};
  void add(SettlementDetailRequest key) => _keys.add(key);
  void remove(SettlementDetailRequest key) => _keys.remove(key);
  List<SettlementDetailRequest> forMeeting(int meetingId) =>
      _keys.where((key) => key.meetingId == meetingId).toList(growable: false);
}
