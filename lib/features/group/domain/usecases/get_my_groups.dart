import '../../../../core/usecases/usecase.dart';
import '../entities/current_group.dart';

abstract class GetMyGroups extends Usecase<List<CurrentGroup>, NoParams> {}
