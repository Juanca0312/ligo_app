import 'package:flutter/material.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';

/// Application theme configuration.
abstract final class LigoLightTheme {
  /// Light theme.
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: LigoColor.primary,
      error: LigoColor.error,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: LigoColor.background,

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: LigoColor.surface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: LigoColor.border,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: LigoColor.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: LigoColor.primary,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: LigoColor.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: LigoColor.error,
            width: 2,
          ),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: LigoColor.primary,
          foregroundColor: LigoColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
