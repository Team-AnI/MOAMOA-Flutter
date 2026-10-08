import '../../../../../core/usecases/params.dart';
import '../../entities/current_group.dart';

final class GetGroupInviteCodeParams extends Params {
  const GetGroupInviteCodeParams({required this.currentGroup});
  final CurrentGroup currentGroup;
}
