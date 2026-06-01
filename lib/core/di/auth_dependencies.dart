import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:ligo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ligo_app/features/auth/domain/cubits/auth/auth_cubit.dart';
import 'package:ligo_app/features/auth/domain/cubits/session/session_cubit.dart';
import 'package:ligo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligo_app/features/auth/domain/validators/auth_validators.dart';

/// Sets up auth feature dependencies for the app.
void setupAuthDependencies() {
  getIt
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDatasourceImpl(httpClient: getIt<LigoHttpClient>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthDataSource>(),
      ),
    )
    ..registerLazySingleton<LoginFormValidators>(
      () => LoginFormValidatorsImpl(
        emailValidator: EmailValidator(),
        passwordValidator: PasswordValidator(),
      ),
    )
    ..registerFactory<SessionCubit>(
      () => SessionCubit(
        sessionManager: getIt<SessionManager>(),
      ),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        authRepository: getIt<AuthRepository>(),
        validators: getIt<LoginFormValidators>(),
        sessionCubit: getIt<SessionCubit>(),
      ),
    );
}
