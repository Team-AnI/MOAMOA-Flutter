import '../../../../../core/usecases/params.dart';
import '../../entities/current_group.dart';

final class UpdateGroupParams extends Params {
  const UpdateGroupParams({
    required this.currentGroup,
    this.name,
    this.description,
  });
  final CurrentGroup currentGroup;
  final String? name;
  final String? description;
  @override
  List<Object?> get props => [currentGroup, name, description];
}
