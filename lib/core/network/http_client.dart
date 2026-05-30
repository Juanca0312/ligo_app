import 'package:ligo_app/core/network/http_response.dart';

///  Contract for HTTP operations used across the app.
abstract class IHttpClient {
  /// Performs a GET request.
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a POST request.
  Future<HttpResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
  });
}
