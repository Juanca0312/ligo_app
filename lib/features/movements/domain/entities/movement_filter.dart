import 'package:flutter/widgets.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

/// Represents the filter options for movements.
enum MovementFilterItem {
  /// Filter for income movements.
  income,

  /// Filter for outcome movements.
  outcome,
}

/// Extension on [MovementFilterItem] to provide localized strings.
extension MovementFilterItemExtension on MovementFilterItem {
  /// Returns a localized string representation of the filter item.
  String localized(BuildContext context) {
    switch (this) {
      case MovementFilterItem.income:
        return context.localized.income;
      case MovementFilterItem.outcome:
        return context.localized.outcome;
    }
  }
}
