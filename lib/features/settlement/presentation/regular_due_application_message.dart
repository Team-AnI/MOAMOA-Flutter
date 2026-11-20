import '../domain/entities/current_settlement_application.dart';

extension RegularDueApplicationMessage on CurrentSettlementApplication {
  String get message => switch (this) {
    CurrentSettlementApplication.notRequested => '정기 회비를 저장했어요.',
    CurrentSettlementApplication.applied => '설정과 이번 회차 정산에 적용했어요.',
    CurrentSettlementApplication.notApplied =>
      '설정은 저장했지만 이번 회차에는 적용되지 않았어요. 기존 정산을 확인해 주세요.',
    CurrentSettlementApplication.unknown =>
      '설정은 저장했지만 이번 회차 적용 여부를 확인하지 못했어요. 정산을 확인해 주세요.',
  };
}
