import '../../../../core/usecases/usecase.dart';
import '../entities/current_group.dart';
import 'params/get_group_params.dart';

abstract class GetGroup extends Usecase<CurrentGroup, GetGroupParams> {}
