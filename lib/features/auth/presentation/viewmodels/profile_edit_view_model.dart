import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import '../../domain/entities/my_account.dart';
import '../../domain/usecases/update_my_profile.dart';
import '../providers/auth_providers.dart';
import 'profile_edit_state.dart';
import 'profile_edit_status.dart';

/// 프로필 편집 ViewModel
///
/// 편집을 시작할 때의 내 정보([MyAccount])를 키로 받아, 그 프로필 색에서 시작합니다.
/// 저장하면 내 계정 화면이 바뀐 정보를 다시 불러오게 합니다. 저장하는 중에 화면을 닫아도 끝날 때까지 이어갑니다.
class ProfileEditViewModel extends Notifier<ProfileEditState> {
  ProfileEditViewModel({required MyAccount account}) : _account = account;

  final MyAccount _account;

  @override
  ProfileEditState build() => ProfileEditState(color: _account.profileColor);

  /// 프로필 색을 고릅니다. 저장 중에는 바꾸지 않습니다.
  void select(ProfileColor color) {
    if (state.isSubmitting) return;
    state = ProfileEditState(color: color);
  }

  /// 입력한 이름·휴대폰과 고른 색을 저장합니다. 휴대폰을 비우면 저장된 번호를 지웁니다.
  Future<void> save({required String name, required String phone}) async {
    if (state.isSubmitting) return; // 중복 요청 방지
    final color = state.color;
    state = ProfileEditState(
      color: color,
      status: ProfileEditStatus.submitting,
    );
    // 저장하는 중에 화면을 닫아도 저장이 성공하면 내 계정 화면에 반영해야 하므로 끝날 때까지 유지합니다.
    final link = ref.keepAlive();
    try {
      await ref.read(updateMyProfileProvider)(
        UpdateMyProfileParams(name: name, phone: phone, color: color),
      );
      ref.invalidate(myAccountProvider);
      state = ProfileEditState(color: color, status: ProfileEditStatus.success);
    } on Exception catch (error) {
      state = ProfileEditState(
        color: color,
        status: ProfileEditStatus.failure,
        error: error,
      );
    } finally {
      link.close();
    }
  }
}
