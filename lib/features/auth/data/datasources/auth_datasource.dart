import 'package:ligo_app/features/auth/data/models/session_model.dart';

/// Data source for authentication operations.
abstract interface class AuthDataSource {
  /// Authenticates a user and returns the created session.
  Future<SessionModel> login({
    required String email,
    required String password,
  });
}
