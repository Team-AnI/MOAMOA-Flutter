import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/network/dio_provider.dart';
import 'package:moamoa/features/auth/domain/entities/my_account.dart';
import 'package:moamoa/features/auth/presentation/providers/auth_providers.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/profile_edit_status.dart';
import 'package:moamoa/features/auth/presentation/viewmodels/profile_edit_view_model.dart';

import '../../fakes/fake_auth_repository.dart';

/// 서버 대신 정해 둔 성공(200) 응답을 돌려주는 Dio 어댑터
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.body);

  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  group(ProfileEditViewModel, () {
    late FakeAuthRepository repository;
    late ProviderContainer container;
    const account = MyAccount(
      name: '이서연',
      email: 'moa@example.com',
      profileColor: ProfileColor.blue,
    );

    setUp(() {
      repository = FakeAuthRepository();
      container = ProviderContainer.test(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        retry: (_, _) => null,
      );
      // 화면이 열려 있는 상태
      container.listen(profileEditProvider(account), (_, _) {});
    });

    ProfileEditViewModel viewModel() =>
        container.read(profileEditProvider(account).notifier);

    Future<void> save() => viewModel().save(name: '김서연', phone: '');

    test('처음에는 지금 내 프로필 색을 고른 상태다', () {
      expect(
        container.read(profileEditProvider(account)).color,
        ProfileColor.blue,
      );
    });

    test('저장하면 입력한 이름·휴대폰과 고른 색으로 요청한다', () async {
      viewModel().select(ProfileColor.dark);

      await save();

      expect(repository.profileUpdates, [
        (name: '김서연', phone: null, color: ProfileColor.dark),
      ]);
    });

    test('저장하면 성공 단계가 된다', () async {
      await save();

      expect(
        container.read(profileEditProvider(account)).status,
        ProfileEditStatus.success,
      );
    });

    test('저장하면 내 계정 화면이 내 정보를 다시 불러온다', () async {
      container.listen(myAccountProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);
      final readsBefore = repository.accountReads;

      await save();
      container.read(myAccountProvider);
      await Future<void>.delayed(Duration.zero);

      expect(repository.accountReads, readsBefore + 1);
    });

    test('저장하는 중에 화면을 닫아도 저장이 성공하면 내 계정 화면이 다시 불러온다', () async {
      final myAccountSubscription = container.listen(
        myAccountProvider,
        (_, _) {},
      );
      await Future<void>.delayed(Duration.zero);
      final readsBefore = repository.accountReads;
      repository.gate = Completer<void>();
      final editSubscription = container.listen(
        profileEditProvider(account),
        (_, _) {},
      );

      final saving = save();
      editSubscription.close(); // 저장하는 중에 편집 화면을 닫음
      repository.gate!.complete();
      await saving;
      await Future<void>.delayed(Duration.zero);

      expect(myAccountSubscription.read().account?.name, '김서연');
      expect(repository.accountReads, readsBefore + 1);
    });

    test('저장에 실패하면 고른 색을 유지한 채 오류를 담은 실패 단계가 된다', () async {
      const error = ApiException(code: ApiErrorCode.network);
      repository.error = error;
      viewModel().select(ProfileColor.gray);

      await save();

      final state = container.read(profileEditProvider(account));
      expect(state.status, ProfileEditStatus.failure);
      expect(state.error, error);
      expect(state.color, ProfileColor.gray);
    });

    test('저장 응답의 필드가 빠지면 실패 단계가 된다', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final realContainer = ProviderContainer.test(
        overrides: [
          dioProvider.overrideWithValue(
            Dio()
              ..httpClientAdapter = _StubAdapter(
                '{"success": true, "data": {}, "error": null}',
              ),
          ),
        ],
        retry: (_, _) => null,
      );
      realContainer.listen(profileEditProvider(account), (_, _) {});

      await realContainer
          .read(profileEditProvider(account).notifier)
          .save(name: '김서연', phone: '');

      expect(
        realContainer.read(profileEditProvider(account)).status,
        ProfileEditStatus.failure,
      );
    });

    test('저장하는 중에 다시 저장해도 한 번만 보낸다', () async {
      repository.gate = Completer<void>();

      final first = save();
      await save();
      repository.gate!.complete();
      await first;

      expect(repository.profileUpdates, hasLength(1));
    });
  });
}
