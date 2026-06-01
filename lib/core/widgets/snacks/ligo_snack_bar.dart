import 'package:flutter/material.dart';
import 'package:ligo_app/core/theme/ligo_color.dart';

/// Enum representing the type of a Ligo snackbar
enum LigoSnackbarType {
  /// Indicates a successful operation, typically shown in green.
  success,

  /// Indicates an error or failure, typically shown in red.
  error,
}

/// A utility class for showing custom snack bars in the Ligo app.
abstract class LigoSnackBar {
  /// Shows a snack bar with the given message and type.
  static void show(
    BuildContext context, {
    required String message,
    required LigoSnackbarType type,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Row(
            children: [
              Icon(
                _getIcon(type),
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(message),
              ),
            ],
          ),
          backgroundColor: _getBackgroundColor(type),
        ),
      );
  }

  static IconData _getIcon(LigoSnackbarType type) {
    switch (type) {
      case LigoSnackbarType.success:
        return Icons.check_circle_outline;

      case LigoSnackbarType.error:
        return Icons.error_outline;
    }
  }

  static Color _getBackgroundColor(LigoSnackbarType type) {
    switch (type) {
      case LigoSnackbarType.success:
        return LigoColor.success;

      case LigoSnackbarType.error:
        return LigoColor.error;
    }
  }
}
