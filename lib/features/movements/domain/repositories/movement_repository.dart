import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';

/// Repository contract for movements operations.
abstract interface class MovementsRepository {
  /// Fetches all movements.
  Future<Result<List<Movement>>> getMovements();
}
