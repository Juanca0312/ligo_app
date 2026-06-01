/// Model representing a financial movement
class MovementModel {
  /// Creates a new instance of [MovementModel] with the given parameters.
  const MovementModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.status,
  });

  /// Factory constructor to create a [MovementModel] instance from a JSON map.
  factory MovementModel.fromJson(
    Map<String, dynamic> json,
  ) => MovementModel(
    id: json['id'] as String,
    description: json['description'] as String,
    amount: (json['amount'] as num).toDouble(),
    type: json['type'] as String,
    status: json['status'] as String,
  );

  /// Unique identifier for the movement.
  final String id;

  /// Description of the movement.
  final String description;

  /// Amount of the movement.
  final double amount;

  /// Type of the movement
  final String type;

  /// Status of the movement
  final String status;
}
