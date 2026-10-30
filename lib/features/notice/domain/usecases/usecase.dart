/// 파라미터 공통 추상 클래스
abstract class Params {
  const Params();
}

/// 파라미터가 필요 없는 UseCase에서 사용
final class NoParams extends Params {
  const NoParams();
}

/// UseCase 공통 추상 클래스
abstract class Usecase<Result, P extends Params> {
  Future<Result> call(P params);
}
