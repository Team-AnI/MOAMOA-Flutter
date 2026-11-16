import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

/// UpdateProfileColor 전용 파라미터
final class UpdateProfileColorParams extends Params {
  const UpdateProfileColorParams({required this.color});

  final ProfileColor color;

  @override
  List<Object?> get props => [color];
}

/// 내 프로필 색 변경 (7-8). 가입 직후 프로필 설정에서 씁니다.
abstract class UpdateProfileColor
    extends Usecase<void, UpdateProfileColorParams> {}

final class UpdateProfileColorImpl implements UpdateProfileColor {
  UpdateProfileColorImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<void> call(UpdateProfileColorParams params) {
    return _authRepository.updateProfileColor(color: params.color);
  }
}
