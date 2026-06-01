part of 'auth_cubit.dart';

/// State class for the [AuthCubit], representing the authentication state
/// of the user.
class AuthState extends Equatable {
  /// Constructs an [AuthState] with the given parameters.
  const AuthState({
    this.authRequestStatus = RequestStatus.initial,
    this.failure,
    this.email = const FormItem(value: ''),
    this.password = const FormItem(value: ''),
  });

  /// The current status of the authentication request
  final RequestStatus authRequestStatus;

  /// Value of the failure, if exists.
  final Failure? failure;

  /// The current email input and its validation error, if any.
  final FormItem<String, EmailError> email;

  /// The current password input and its validation error, if any.
  final FormItem<String, PasswordError> password;

  /// Returns true if the form is valid
  bool get isFormValid => email.isValid && password.isValid;

  /// Returns true if the authentication request is currently loading
  bool get isLoading => authRequestStatus == RequestStatus.loading;

  /// Returns true if the authentication request was successful
  bool get isSuccess => authRequestStatus == RequestStatus.success;

  /// Returns true if the authentication request was unsuccessful
  bool get isFailure => authRequestStatus == RequestStatus.failure;

  /// Creates a copy of the current [AuthState] with optional new values.
  AuthState copyWith({
    RequestStatus? authRequestStatus,
    FormItem<String, EmailError>? email,
    FormItem<String, PasswordError>? password,
    Failure? failure,
  }) {
    return AuthState(
      authRequestStatus: authRequestStatus ?? this.authRequestStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure,
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
