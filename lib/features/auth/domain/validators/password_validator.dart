import 'package:ligo_app/core/common/form_validator.dart';

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
