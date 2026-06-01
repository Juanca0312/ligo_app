import 'package:flutter/material.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

/// Defines the types of movements in the application.
enum MovementType {
  /// Represents an income movement.
  income,

  /// Represents an outcome movement.
  outcome,

  /// Represents a movement with an unknown status.
  unknown,
}

/// Extension on [MovementType] to provide localized string representations.
extension LocalizedMovementType on MovementType {
  /// Returns a localized string representation of the movement type.
  String localized(BuildContext context) {
    switch (this) {
      case MovementType.income:
        return context.localized.income;
      case MovementType.outcome:
        return context.localized.outcome;
      case MovementType.unknown:
        return context.localized.unknown;
    }
  }
}
