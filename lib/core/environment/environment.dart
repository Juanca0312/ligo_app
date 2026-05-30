/// Provides access to compile-time environment variables.
///
/// Values are injected through `--dart-define` or
/// `--dart-define-from-file`.
abstract final class Environment {
  /// Base URL of the REST API.
  static const apiUrl = String.fromEnvironment('API_URL');
}
