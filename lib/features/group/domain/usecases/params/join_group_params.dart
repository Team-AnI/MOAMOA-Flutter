import '../../../../../core/usecases/params.dart';

final class JoinGroupParams extends Params {
  const JoinGroupParams({required this.inviteCode});
  final String inviteCode;
}
