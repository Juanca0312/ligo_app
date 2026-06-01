part of 'session_cubit.dart';

/// State class for the [SessionCubit], representing the current session status
/// of the user.
class SessionState extends Equatable {
  /// Creates a new instance of [SessionState] with the given parameters.
  const SessionState({
    this.status = SessionStatus.unknown,
    this.sessionUser,
  });

  /// The current session status of the user.
  final SessionStatus status;

  /// The current session of the user, if authenticated.
  final SessionUser? sessionUser;

  /// Returns `true` if the user is authenticated and has a valid session.
  bool get isAuthenticated =>
      status == SessionStatus.authenticated && sessionUser != null;

  /// Creates a copy of the current [SessionState] with optional new values.
  SessionState copyWith({
    SessionStatus? status,
    SessionUser? sessionUser,
  }) {
    return SessionState(
      status: status ?? this.status,
      sessionUser: sessionUser ?? this.sessionUser,
    );
  }

  @override
  List<Object?> get props => [
    status,
    sessionUser,
  ];
}
