import 'params.dart';

abstract class Usecase<Result, P extends Params> {
  Future<Result> call(P params);
}
