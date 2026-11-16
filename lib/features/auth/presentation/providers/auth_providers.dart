import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/dio_provider.dart';
import 'package:moamoa/core/storage/token_storage.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_with_email.dart';
import '../../domain/usecases/request_password_reset.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/sign_up_with_email.dart';
import '../../domain/usecases/update_profile_color.dart';
import '../viewmodels/forgot_password_state.dart';
import '../viewmodels/forgot_password_view_model.dart';
import '../viewmodels/login_state.dart';
import '../viewmodels/login_view_model.dart';
import '../viewmodels/profile_setup_state.dart';
import '../viewmodels/profile_setup_view_model.dart';
import '../viewmodels/reset_password_state.dart';
import '../viewmodels/reset_password_view_model.dart';
import '../viewmodels/sign_up_state.dart';
import '../viewmodels/sign_up_view_model.dart';

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

// ViewModel / 화면 상태

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
