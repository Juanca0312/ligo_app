/// Defines a custom exception for API-related errors,
/// encapsulating an error message and an optional HTTP status code.
class ApiException implements Exception {
  /// Creates a new instance of [ApiException]
  ApiException({required this.message, this.statusCode});

  /// The error message describing the exception.
  final String message;

  /// The optional HTTP status code associated with the error.
  final int? statusCode;
}
