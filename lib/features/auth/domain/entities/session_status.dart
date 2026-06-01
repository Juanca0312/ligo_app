/// Session status of the user.
enum SessionStatus {
  /// User is authenticated and has a valid session.
  authenticated,

  /// User is not authenticated or session has expired.
  unauthenticated,

  /// Initial state when the app is determining the session status.
  unknown,
}
