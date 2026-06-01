import 'package:flutter/widgets.dart';
import 'package:ligo_app/core/common/form_validator.dart';
import 'package:ligo_app/core/extensions/localization_extension.dart';

/// Validator for password fields, ensuring they meet certain criteria.
class PasswordValidator implements Validator<String, PasswordError> {
  @override
  PasswordError? validate(String value) {
    if (value.isEmpty) {
      return PasswordError.required;
    }

    if (value.length < 6) {
      return PasswordError.tooShort;
    }

    return null;
  }
}

/// Enum representing possible password validation errors.
enum PasswordError {
  /// Error indicating that the password field is required but was left empty.
  required,

  /// Error indicating that the password is too short (less than 6 characters).
  tooShort,
}

/// Extension to provide localization for [PasswordError] instances.
extension PasswordErrorLocalization on PasswordError {
  /// Localizes the password error message based on the type of error.
  String localize(BuildContext context) {
    return switch (this) {
      PasswordError.required => context.localized.fieldRequired,
      PasswordError.tooShort => context.localized.invalidPassword,
    };
  }
}
