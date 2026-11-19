import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import 'profile_edit_status.dart';

part 'profile_edit_state.freezed.dart';

/// 프로필 편집 상태. 고른 프로필 색과 저장 단계를 담습니다.
@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    required ProfileColor color,
    @Default(ProfileEditStatus.initial) ProfileEditStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _ProfileEditState;
}

extension ProfileEditStateX on ProfileEditState {
  bool get isSubmitting => status == ProfileEditStatus.submitting;
}
