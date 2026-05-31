part of 'auth_cubit.dart';

/// State class for the [AuthCubit], representing the authentication state
/// of the user.
class AuthState extends Equatable {
  /// Constructs an [AuthState] with the given parameters.
  const AuthState({
    this.authRequestStatus = RequestStatus.initial,
    this.email = const FormItem(value: ''),
    this.password = const FormItem(value: ''),
  });

  /// The current status of the authentication request
  final RequestStatus authRequestStatus;

  /// The current email input and its validation error, if any.
  final FormItem<String, EmailError> email;

  /// The current password input and its validation error, if any.
  final FormItem<String, PasswordError> password;

  /// Returns true if the form is valid
  bool get isFormValid => email.isValid && password.isValid;

  /// Creates a copy of the current [AuthState] with optional new values.
  AuthState copyWith({
    RequestStatus? authRequestStatus,
    FormItem<String, EmailError>? email,
    FormItem<String, PasswordError>? password,
  }) {
    return AuthState(
      authRequestStatus: authRequestStatus ?? this.authRequestStatus,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
    authRequestStatus,
    email,
    password,
    isFormValid,
  ];
}
