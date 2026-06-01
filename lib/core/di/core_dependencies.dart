import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/core/network/dio_config.dart';
import 'package:ligo_app/core/network/dio_http_client.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/network/interceptors/auth_interceptor.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service_impl.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/core/session_manager/session_manager_impl.dart';

/// Sets up core dependencies for the app.
void setupCoreDependencies() {
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
    );
}
