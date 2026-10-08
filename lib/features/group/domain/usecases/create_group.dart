import '../../../../core/usecases/usecase.dart';
import '../entities/current_group.dart';
import 'params/create_group_params.dart';

abstract class CreateGroup extends Usecase<CurrentGroup, CreateGroupParams> {}
