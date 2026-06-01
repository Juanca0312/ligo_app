import 'package:ligo_app/core/session_manager/session.dart';

/// Interface for managing user sessions
abstract interface class SessionManager {
  /// Saves the given session to secure storage.
  Future<void> saveSession(Session session);

  /// Retrieves the current session from secure storage, if it exists.
  Future<Session?> getSession();

  /// Retrieves the authentication token from secure storage, if it exists.
  Future<String?> getToken();

  /// Clears the current session from secure storage.
  Future<void> clearSession();
}
