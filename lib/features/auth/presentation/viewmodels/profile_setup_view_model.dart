import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import '../../domain/usecases/update_profile_color.dart';
import '../providers/auth_providers.dart';
import 'profile_setup_state.dart';
import 'profile_setup_status.dart';

/// 가입 직후 프로필 설정 ViewModel
///
/// 고른 색을 들고 있다가 [save] 로 저장합니다. "나중에" 를 고르면 저장하지 않고,
/// 서버 기본값(LIGHT_BLUE)이 그대로 쓰입니다.
class ProfileSetupViewModel extends Notifier<ProfileSetupState> {
  @override
  ProfileSetupState build() => const ProfileSetupState();

  /// 프로필 색을 고릅니다. 저장 중에는 바꾸지 않습니다.
  void select(ProfileColor color) {
    if (state.isSubmitting) return;
    state = ProfileSetupState(color: color);
  }

  /// 고른 색을 저장합니다.
  Future<void> save() async {
    if (state.isSubmitting) return; // 중복 요청 방지
    final color = state.color;
    state = ProfileSetupState(
      color: color,
      status: ProfileSetupStatus.submitting,
    );
    try {
      await ref.read(updateProfileColorProvider)(
        UpdateProfileColorParams(color: color),
      );
      if (!ref.mounted) return;
      state = ProfileSetupState(
        color: color,
        status: ProfileSetupStatus.success,
      );
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = ProfileSetupState(
        color: color,
        status: ProfileSetupStatus.failure,
        error: error,
      );
    }
  }
}
