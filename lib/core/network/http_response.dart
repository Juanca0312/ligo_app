/// Represents a standardized HTTP response used across the app.
class HttpResponse<T> {
  /// Creates an instance of [HttpResponse].
  HttpResponse({
    required this.data,
    required this.statusCode,
  });

  /// The response data, which can be of any type depending on the request.
  final T data;

  /// The HTTP status code of the response.
  final int statusCode;
}
