import '../../../../core/usecases/usecase.dart';
import '../entities/group.dart';
import 'params/update_group_params.dart';

abstract class UpdateGroup extends Usecase<Group, UpdateGroupParams> {}
