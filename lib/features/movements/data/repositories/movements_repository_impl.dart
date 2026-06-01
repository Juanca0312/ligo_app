import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/errors/failure_mapper.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/features/movements/data/datasources/movements_datasouce.dart';
import 'package:ligo_app/features/movements/data/mappers/movements_mapper.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/repositories/movement_repository.dart';

/// Implementation of the [MovementsRepository] interface
final class MovementsRepositoryImpl implements MovementsRepository {
  /// Creates a new instance of [MovementsRepositoryImpl].
  MovementsRepositoryImpl({
    required MovementsDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final MovementsDataSource _remoteDataSource;

  @override
  Future<Result<List<Movement>>> getMovements() async {
    try {
      final models = await _remoteDataSource.getMovements();

      final movements = MovementsMapper.fromModelList(models);

      return Result.success(movements);
    } on AppException catch (e) {
      return Result.failure(FailureMapper.from(e));
    } on Exception {
      return Result.failure(UnknownFailure());
    }
  }
}
