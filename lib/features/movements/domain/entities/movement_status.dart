/// Defines the status of a movement in the application.
enum MovementStatus {
  /// Represents a movement that is pending and has not been completed yet.
  pending,

  /// Represents a movement that has been completed successfully.
  completed,

  /// Represents a movement that has failed to complete.
  failed,

  /// Represents a movement with an unknown status.
  unknown,
}
