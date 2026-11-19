import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import 'profile_setup_status.dart';

part 'profile_setup_state.freezed.dart';

/// 가입 직후 프로필 설정 상태. 고른 색과 저장 단계를 담습니다.
@freezed
abstract class ProfileSetupState with _$ProfileSetupState {
  const factory ProfileSetupState({
    /// 고른 프로필 색. 처음에는 서버 기본값과 같은 연파랑입니다.
    @Default(ProfileColor.lightBlue) ProfileColor color,
    @Default(ProfileSetupStatus.initial) ProfileSetupStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _ProfileSetupState;
}

extension ProfileSetupStateX on ProfileSetupState {
  bool get isSubmitting => status == ProfileSetupStatus.submitting;
}
