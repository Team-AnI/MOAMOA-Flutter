import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/dio_provider.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_remote_data_source_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/request_password_reset.dart';
import '../../domain/usecases/reset_password.dart';

// Data

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

// UseCase

final requestPasswordResetProvider = Provider<RequestPasswordReset>(
  (ref) => RequestPasswordResetImpl(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

final resetPasswordProvider = Provider<ResetPassword>(
  (ref) => ResetPasswordImpl(authRepository: ref.watch(authRepositoryProvider)),
);
