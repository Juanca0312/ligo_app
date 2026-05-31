import 'package:ligo_app/core/common/form_validator.dart';

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
