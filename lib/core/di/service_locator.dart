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
      () => AuthInterceptor(getIt<SessionManager>()),
    )
    ..registerLazySingleton<Dio>(
      () => DioConfig.create([getIt<AuthInterceptor>()]),
    )
    ..registerLazySingleton<LigoHttpClient>(
      () => DioHttpClient(getIt<Dio>()),
    )
    ..registerLazySingleton<SecureStorageService>(
      () => SecureStorageServiceImpl(const FlutterSecureStorage()),
    )
    ..registerLazySingleton<SessionManager>(
      () => SessionManagerImpl(getIt<SecureStorageService>()),
    )
    // AUTH FEATURE
    ..registerLazySingleton<AuthDataSource>(
      () => AuthDatasourceImpl(httpClient: getIt<LigoHttpClient>()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthDataSource>(),
        sessionManager: getIt<SessionManager>(),
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
        authRepository: getIt<AuthRepository>(),
        validators: getIt<LoginFormValidators>(),
      ),
    );
}
