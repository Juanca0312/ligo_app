import 'package:ligo_app/features/movements/domain/entities/movement_status.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_type.dart';

/// Represents a financial movement
class Movement {
  /// Creates a new instance of [Movement] with the given parameters.
  Movement({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.status,
  });

  /// Unique identifier for the movement.
  final String id;

  /// Description of the movement.
  final String description;

  /// Amount of the movement.
  final double amount;

  /// Type of the movement
  final MovementType type;

  /// Status of the movement
  final MovementStatus status;

  /// Returns a formatted string representation of the movement amount
  String get amountFormatted =>
      '${type == .outcome ? '-' : ''} S/.${amount.toStringAsFixed(2)}';
}
