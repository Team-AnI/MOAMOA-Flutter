import '../../../../../core/usecases/params.dart';

final class GetGroupParams extends Params {
  const GetGroupParams({required this.groupId});
  final int groupId;
  @override
  List<Object?> get props => [groupId];
}
