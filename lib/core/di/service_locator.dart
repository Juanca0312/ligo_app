import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ligo_app/core/network/dio_config.dart';
import 'package:ligo_app/core/network/dio_http_client.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/network/interceptors/auth_interceptor.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service_impl.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/core/session_manager/session_manager_impl.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:ligo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ligo_app/features/auth/domain/cubits/auth/auth_cubit.dart';
import 'package:ligo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligo_app/features/auth/domain/validators/email_validator.dart';
import 'package:ligo_app/features/auth/domain/validators/login_form_validator.dart';
import 'package:ligo_app/features/auth/domain/validators/password_validator.dart';

/// Service locator for dependency injection using GetIt.
final GetIt getIt = GetIt.instance;

/// Sets up all dependencies for the app.
void setupDependencies() {
  // Core
  getIt
    ..registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(getIt<ISessionManager>()),
    )
    ..registerLazySingleton<Dio>(
      () => DioConfig.create([getIt<AuthInterceptor>()]),
    )
    ..registerLazySingleton<IHttpClient>(
      () => DioHttpClient(getIt<Dio>()),
    )
    ..registerLazySingleton<ISecureStorageService>(
      () => SecureStorageServiceImpl(const FlutterSecureStorage()),
    )
    ..registerLazySingleton<ISessionManager>(
      () => SessionManagerImpl(getIt<ISecureStorageService>()),
    )
    // AUTH FEATURE
    ..registerLazySingleton<IAuthRemoteDataSource>(
      () => AuthDatasourceImpl(httpClient: getIt<IHttpClient>()),
    )
    ..registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<IAuthRemoteDataSource>(),
        sessionManager: getIt<ISessionManager>(),
      ),
    )
    ..registerLazySingleton<LoginFormValidators>(
      () => LoginFormValidatorsImpl(
        emailValidator: EmailValidator(),
        passwordValidator: PasswordValidator(),
      ),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(
        authRepository: getIt<IAuthRepository>(),
        validators: getIt<LoginFormValidators>(),
      ),
    );
}
