import 'package:flutter/material.dart';

/// Extension on [BuildContext]
extension TextThemeExtension on BuildContext {
  /// Provides access to the current theme's text styles.
  TextTheme get textTheme => Theme.of(this).textTheme;
}
