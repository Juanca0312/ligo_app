import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ligo_app/core/network/dio_config.dart';
import 'package:ligo_app/core/network/dio_http_client.dart';
import 'package:ligo_app/core/network/http_client.dart';

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
    );
}
