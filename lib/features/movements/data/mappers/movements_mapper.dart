import 'package:ligo_app/features/movements/data/models/movement_model.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_status.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_type.dart';

/// A mapper class to convert between Movement models and domain entities.
abstract class MovementsMapper {
  /// Creates a list of [Movement] from a list of [MovementModel]
  static List<Movement> fromModelList(List<MovementModel> models) =>
      models.map(fromModel).toList();

  /// Creates a [Movement] from a [MovementModel]
  static Movement fromModel(MovementModel model) => Movement(
    id: model.id,
    description: model.description,
    amount: model.amount,
    type: _mapType(model.type),
    status: _mapStatus(model.status),
  );

  /// Maps raw string to [MovementType].
  static MovementType _mapType(String value) {
    switch (value.toLowerCase()) {
      case 'in':
        return MovementType.income;
      case 'out':
        return MovementType.outcome;
      default:
        return MovementType.unknown;
    }
  }

  /// Maps raw string to [MovementStatus].
  static MovementStatus _mapStatus(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return MovementStatus.pending;
      case 'completed':
        return MovementStatus.completed;
      case 'failed':
        return MovementStatus.failed;
      default:
        return MovementStatus.unknown;
    }
  }
}
