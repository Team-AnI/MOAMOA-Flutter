import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/profile_setup_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/profile_setup_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

void main() {
  group(ProfileSetupViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(profileSetupProvider, (_, _) {});
    });

    ProfileSetupViewModel viewModel() =>
        container.read(profileSetupProvider.notifier);

    test('처음에는 서버 기본값과 같은 연파랑을 고른 상태다', () {
      expect(
        container.read(profileSetupProvider).color,
        ProfileColor.lightBlue,
      );
    });

    test('색을 고르면 고른 색이 된다', () {
      viewModel().select(ProfileColor.dark);

      expect(container.read(profileSetupProvider).color, ProfileColor.dark);
    });

    test('저장하면 고른 색으로 저장을 요청한다', () async {
      viewModel().select(ProfileColor.blue);

      await viewModel().save();

      expect(repository.profileColors, [ProfileColor.blue]);
    });

    test('저장하면 성공 단계가 된다', () async {
      await viewModel().save();

      expect(
        container.read(profileSetupProvider).status,
        ProfileSetupStatus.success,
      );
    });

    test('저장에 실패하면 고른 색을 유지한 채 오류를 담은 실패 단계가 된다', () async {
      const error = ApiException(code: ApiErrorCode.network);
      repository.error = error;
      viewModel().select(ProfileColor.gray);

      await viewModel().save();

      final state = container.read(profileSetupProvider);
      expect(state.status, ProfileSetupStatus.failure);
      expect(state.error, error);
      expect(state.color, ProfileColor.gray);
    });

    test('저장하는 중에 다시 저장해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = viewModel().save();
      await viewModel().save();
      repository.gate!.complete();
      await first;

      expect(repository.profileColors, hasLength(1));
    });

    test('저장하는 중에는 색을 골라도 바뀌지 않는다', () async {
      repository.gate = Completer<void>();

      final first = viewModel().save();
      viewModel().select(ProfileColor.dark);

      expect(
        container.read(profileSetupProvider).color,
        ProfileColor.lightBlue,
      );
      repository.gate!.complete();
      await first;
    });
  });
}
