import 'package:ligo_app/core/common/form_validator.dart';
import 'package:ligo_app/features/auth/domain/validators/email_validator.dart';
import 'package:ligo_app/features/auth/domain/validators/password_validator.dart';

/// A class that defines the validators for the login form, including email
/// and password validation.
abstract class LoginFormValidators {
  /// Validates the email field and returns any validation errors.
  EmailError? validateEmail(String email);

  /// Validates the password field and returns any validation errors.
  PasswordError? validatePassword(String password);
}

/// An implementation of the [LoginFormValidators]
class LoginFormValidatorsImpl implements LoginFormValidators {
  /// Constructs a [LoginFormValidatorsImpl]
  const LoginFormValidatorsImpl({
    required this.emailValidator,
    required this.passwordValidator,
  });

  /// The email validator used to validate the email field.
  final Validator<String, EmailError> emailValidator;

  /// The password validator used to validate the password field.
  final Validator<String, PasswordError> passwordValidator;

  @override
  EmailError? validateEmail(String email) {
    return emailValidator.validate(email);
  }

  @override
  PasswordError? validatePassword(String password) {
    return passwordValidator.validate(password);
  }
}
