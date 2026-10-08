import '../../../../core/usecases/usecase.dart';
import '../entities/current_group.dart';
import '../../../../core/usecases/no_params.dart';

abstract class GetMyGroups extends Usecase<List<CurrentGroup>, NoParams> {}
