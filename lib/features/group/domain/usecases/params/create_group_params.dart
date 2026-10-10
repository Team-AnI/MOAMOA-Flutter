import '../../../../../core/usecases/params.dart';

final class CreateGroupParams extends Params {
  const CreateGroupParams({required this.name, this.description = ''});
  final String name;
  final String description;
}
