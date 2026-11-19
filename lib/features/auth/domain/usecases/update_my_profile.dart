import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../auth_input_rules.dart';
import '../entities/my_account.dart';
import '../repositories/auth_repository.dart';

/// UpdateMyProfile 전용 파라미터
final class UpdateMyProfileParams extends Params {
  const UpdateMyProfileParams({
    required this.name,
    required this.phone,
    required this.color,
  });

  final String name;

  /// 선택 입력. 비어 있으면 저장된 휴대폰 번호를 지웁니다.
  final String phone;
  final ProfileColor color;

  @override
  List<Object?> get props => [name, phone, color];
}

/// 프로필 편집 (7-8). 이름·휴대폰·프로필 색을 저장하고 바뀐 내 정보를 돌려줍니다.
abstract class UpdateMyProfile
    extends Usecase<MyAccount, UpdateMyProfileParams> {}

final class UpdateMyProfileImpl implements UpdateMyProfile {
  UpdateMyProfileImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  /// 이름·휴대폰이 규칙에 맞지 않으면 보내지 않습니다. 앞뒤 공백은 빼고 보냅니다.
  @override
  Future<MyAccount> call(UpdateMyProfileParams params) async {
    final error = params.name.nameError ?? params.phone.phoneError;
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    final phone = params.phone.trim();
    return _authRepository.updateMyProfile(
      name: params.name.trim(),
      phone: phone.isEmpty ? null : phone,
      color: params.color,
    );
  }
}
