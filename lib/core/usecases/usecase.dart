import 'params.dart';

export 'no_params.dart';
export 'params.dart';

/// UseCase 공통 추상 클래스입니다.
abstract class Usecase<Result, P extends Params> {
  Future<Result> call(P params);
}
