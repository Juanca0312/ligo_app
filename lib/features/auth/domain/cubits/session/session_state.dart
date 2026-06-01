part of 'session_cubit.dart';

/// State class for the [SessionCubit], representing the current session status
/// of the user.
class SessionState extends Equatable {
  /// Creates a new instance of [SessionState] with the given parameters.
  const SessionState({
    this.status = SessionStatus.unknown,
    this.session,
  });

  /// The current session status of the user.
  final SessionStatus status;

  /// The current session of the user, if authenticated.
  final Session? session;

  /// Returns `true` if the user is authenticated and has a valid session.
  bool get isAuthenticated =>
      status == SessionStatus.authenticated && session != null;

  /// Creates a copy of the current [SessionState] with optional new values.
  SessionState copyWith({
    SessionStatus? status,
    Session? session,
  }) {
    return SessionState(
      status: status ?? this.status,
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [
    status,
    session,
  ];
}
