import '../../../../../core/usecases/params.dart';
import '../../entities/current_group.dart';

final class DeleteGroupParams extends Params {
  const DeleteGroupParams({required this.currentGroup});
  final CurrentGroup currentGroup;

  @override
  List<Object?> get props => [currentGroup];
}
