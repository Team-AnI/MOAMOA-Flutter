import '../../../../core/usecases/usecase.dart';
import 'params/get_group_invite_code_params.dart';

abstract class GetGroupInviteCode
    extends Usecase<String, GetGroupInviteCodeParams> {}
