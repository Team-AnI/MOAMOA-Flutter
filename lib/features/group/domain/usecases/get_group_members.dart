import '../../../../core/usecases/usecase.dart';
import '../entities/group_member_profile.dart';
import 'params/get_group_params.dart';

abstract class GetGroupMembers
    extends Usecase<List<GroupMemberProfile>, GetGroupParams> {}
