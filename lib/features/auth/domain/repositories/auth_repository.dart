import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/session_manager/session.dart';

/// Interface for the authentication repository, responsible for handling
/// user authentication operations.
abstract interface class AuthRepository {
  /// Attempts to log in a user with the provided email and password.
  Future<Result<Session>> login({
    required String email,
    required String password,
  });
}
