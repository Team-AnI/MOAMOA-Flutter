import '../../../../core/usecases/usecase.dart';
import '../entities/current_group.dart';
import 'params/join_group_params.dart';

abstract class JoinGroup extends Usecase<CurrentGroup, JoinGroupParams> {}
