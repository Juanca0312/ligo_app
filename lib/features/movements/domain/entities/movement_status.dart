import 'package:flutter/widgets.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

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

/// Extension on [MovementStatus] to provide localized string representations.
extension LocalizedMovementStatus on MovementStatus {
  /// Returns a localized string representation of the movement status.
  String localized(BuildContext context) {
    switch (this) {
      case MovementStatus.pending:
        return context.localized.pending;
      case MovementStatus.completed:
        return context.localized.completed;
      case MovementStatus.failed:
        return context.localized.failed;
      case MovementStatus.unknown:
        return context.localized.unknown;
    }
  }
}
