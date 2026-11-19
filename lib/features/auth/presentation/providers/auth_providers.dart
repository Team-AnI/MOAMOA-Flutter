import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/dio_provider.dart';
import 'package:moamoa/core/storage/token_storage.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/my_account.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_my_account.dart';
import '../../domain/usecases/login_with_email.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/request_password_reset.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/update_my_profile.dart';
import '../../domain/usecases/update_profile_color.dart';
import '../../domain/usecases/withdraw.dart';
import '../viewmodels/forgot_password_state.dart';
import '../viewmodels/forgot_password_view_model.dart';
import '../viewmodels/login_state.dart';
import '../viewmodels/login_view_model.dart';
import '../viewmodels/my_account_state.dart';
import '../viewmodels/my_account_view_model.dart';
import '../viewmodels/profile_edit_state.dart';
import '../viewmodels/profile_edit_view_model.dart';
import '../viewmodels/profile_setup_state.dart';
import '../viewmodels/profile_setup_view_model.dart';
import '../viewmodels/reset_password_state.dart';
import '../viewmodels/reset_password_view_model.dart';
import '../viewmodels/sign_up_state.dart';
import '../viewmodels/sign_up_view_model.dart';
import '../viewmodels/withdrawal_state.dart';
import '../viewmodels/withdrawal_view_model.dart';

// Data

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  ),
);

// UseCase

final signUpWithEmailProvider = Provider<SignUpWithEmail>(
  (ref) =>
      SignUpWithEmailImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final updateProfileColorProvider = Provider<UpdateProfileColor>(
  (ref) =>
      UpdateProfileColorImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final loginWithEmailProvider = Provider<LoginWithEmail>(
  (ref) =>
      LoginWithEmailImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final requestPasswordResetProvider = Provider<RequestPasswordReset>(
  (ref) => RequestPasswordResetImpl(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

final resetPasswordProvider = Provider<ResetPassword>(
  (ref) => ResetPasswordImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final getMyAccountProvider = Provider<GetMyAccount>(
  (ref) => GetMyAccountImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final updateMyProfileProvider = Provider<UpdateMyProfile>(
  (ref) =>
      UpdateMyProfileImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final logoutProvider = Provider<Logout>(
  (ref) => LogoutImpl(authRepository: ref.watch(authRepositoryProvider)),
);

final withdrawProvider = Provider<Withdraw>(
  (ref) => WithdrawImpl(authRepository: ref.watch(authRepositoryProvider)),
);

// ViewModel / 화면 상태

final withdrawalProvider =
    NotifierProvider.autoDispose<WithdrawalViewModel, WithdrawalState>(
      WithdrawalViewModel.new,
    );

final myAccountProvider =
    NotifierProvider.autoDispose<MyAccountViewModel, MyAccountState>(
      MyAccountViewModel.new,
    );

/// 키는 편집을 시작할 때의 내 정보입니다.
final profileEditProvider = NotifierProvider.autoDispose
    .family<ProfileEditViewModel, ProfileEditState, MyAccount>(
      (account) => ProfileEditViewModel(account: account),
    );

final signUpProvider =
    NotifierProvider.autoDispose<SignUpViewModel, SignUpState>(
      SignUpViewModel.new,
    );

final profileSetupProvider =
    NotifierProvider.autoDispose<ProfileSetupViewModel, ProfileSetupState>(
      ProfileSetupViewModel.new,
    );

final loginProvider = NotifierProvider.autoDispose<LoginViewModel, LoginState>(
  LoginViewModel.new,
);

final forgotPasswordProvider =
    NotifierProvider.autoDispose<ForgotPasswordViewModel, ForgotPasswordState>(
      ForgotPasswordViewModel.new,
    );

final passwordResetProvider =
    NotifierProvider.autoDispose<ResetPasswordViewModel, ResetPasswordState>(
      ResetPasswordViewModel.new,
    );
