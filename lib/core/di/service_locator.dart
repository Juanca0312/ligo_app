import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ligo_app/core/network/dio_config.dart';
import 'package:ligo_app/core/network/dio_http_client.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service_impl.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/core/session_manager/session_manager_impl.dart';

/// Service locator for dependency injection using GetIt.
final GetIt getIt = GetIt.instance;

/// Sets up all dependencies for the app.
void setupDependencies() {
  // Core
  getIt
    ..registerLazySingleton<Dio>(
      DioConfig.create,
    )
    ..registerLazySingleton<IHttpClient>(
      () => DioHttpClient(getIt<Dio>()),
    )
    ..registerLazySingleton<ISecureStorageService>(
      () => SecureStorageServiceImpl(const FlutterSecureStorage()),
    )
    ..registerLazySingleton<ISessionManager>(
      () => SessionManagerImpl(getIt<ISecureStorageService>()),
    );
}
