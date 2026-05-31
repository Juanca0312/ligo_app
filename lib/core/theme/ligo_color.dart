import 'package:flutter/material.dart';

/// Application color palette.
abstract final class LigoColor {
  /// Brand primary color.
  static const Color primary = Color(0xFF8A11D7);

  /// White color
  static const Color white = Colors.white;

  /// Black color
  static const Color black = Colors.black;

  /// Color for errors
  static const Color error = Color(0xFFE53935);

  /// Color for success
  static const Color success = Color(0xFF2E7D32);

  /// Text colors.
  static const Color textPrimary = Color(0xFF1A1A1A);

  /// Secondary text color, used for hints and less important information.
  static const Color textSecondary = Color(0xFF6B7280);

  /// Borders and surfaces.
  static const Color border = Color(0xFFE5E7EB);

  /// Surface colors for cards, dialogs, and other elevated elements.
  static const Color surface = Color(0xFFFFFFFF);

  /// Background color for the app.
  static const Color background = Color(0xFFF8F9FA);
}
