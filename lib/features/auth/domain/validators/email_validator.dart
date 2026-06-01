import 'package:flutter/widgets.dart';
import 'package:ligo_app/core/common/form_validator.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

/// Validator for email addresses using a regex pattern.
class EmailValidator implements Validator<String, EmailError> {
  @override
  EmailError? validate(String value) {
    if (value.isEmpty) {
      return EmailError.required;
    }

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value)) {
      return EmailError.invalid;
    }

    return null;
  }
}

/// Enum representing possible email validation errors.
enum EmailError {
  /// Error indicating that the email field is required but was left empty.
  required,

  /// Error indicating that the email format is invalid.
  invalid,
}

/// Extension to provide localization for [EmailError] instances.
extension EmailErrorLocalization on EmailError {
  /// Localizes the email error message based on the type of error.
  String localize(BuildContext context) {
    return switch (this) {
      EmailError.required => context.localized.fieldRequired,
      EmailError.invalid => context.localized.invalidEmail,
    };
  }
}
