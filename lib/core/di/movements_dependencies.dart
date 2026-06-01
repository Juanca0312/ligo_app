import 'package:ligo_app/core/di/service_locator.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/features/movements/data/datasources/movements_datasouce.dart';
import 'package:ligo_app/features/movements/data/datasources/movements_datasource_impl.dart';
import 'package:ligo_app/features/movements/data/repositories/movements_repository_impl.dart';
import 'package:ligo_app/features/movements/domain/cubits/movements/movements_cubit.dart';
import 'package:ligo_app/features/movements/domain/repositories/movement_repository.dart';

/// Sets up auth feature dependencies for the app.
void setupMovementsDependencies() {
  getIt
    ..registerLazySingleton<MovementsDataSource>(
      () => MovementDatasourceImpl(httpClient: getIt<LigoHttpClient>()),
    )
    ..registerLazySingleton<MovementsRepository>(
      () => MovementsRepositoryImpl(
        remoteDataSource: getIt<MovementsDataSource>(),
      ),
    )
    ..registerFactory<MovementsCubit>(
      () => MovementsCubit(
        movementsRepository: getIt<MovementsRepository>(),
      ),
    );
}
