import 'package:ligo_app/core/common/result.dart';

/// Interface for the authentication repository, responsible for handling
/// user authentication operations.
abstract interface class AuthRepository {
  /// Attempts to log in a user with the provided email and password.
  Future<Result<void>> login({
    required String email,
    required String password,
  });
}
