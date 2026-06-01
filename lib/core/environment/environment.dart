import 'package:ligo_app/core/environment/environment_exception.dart';

/// Provides access to compile-time environment variables.
///
/// Values are injected through `--dart-define` or
/// `--dart-define-from-file`.
abstract final class Environment {
  Environment._();

  /// Base URL of the REST API.
  static final String apiUrl = _requiredEnv(
    const String.fromEnvironment('API_URL'),
    'API_URL',
  );

  static String _requiredEnv(String value, String name) {
    if (value.isEmpty) {
      throw EnvironmentVarNotFoundException(
        message:
            'Required environment variable "$name" was not provided. '
            'Pass it using --dart-define or --dart-define-from-file.',
      );
    }
    return value;
  }
}
