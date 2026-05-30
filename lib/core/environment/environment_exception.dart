/// Defines a custom exception for missing environment variables,
/// encapsulating an error message.
class EnvironmentVarNotFoundException implements Exception {
  /// Creates a new instance of [EnvironmentVarNotFoundException]
  EnvironmentVarNotFoundException({required this.message});

  /// The error message describing the exception.
  final String message;
}
