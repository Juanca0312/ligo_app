import 'package:flutter/widgets.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

/// Extension to provide localization for [Failure] instances.
extension FailureLocalization on Failure {
  /// Localizes the failure message based on the type of failure.
  String localize(BuildContext context) {
    return switch (this) {
      UnauthorizedFailure() => context.localized.unauthorizedError,

      UnknownFailure() => context.localized.genericError,
    };
  }
}
