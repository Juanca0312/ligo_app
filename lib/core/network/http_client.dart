import 'package:ligo_app/core/network/http_response.dart';

///  Contract for HTTP operations used across the app.
abstract class IHttpClient {
  /// Performs a GET request.
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  /// Performs a POST request.
  Future<HttpResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
  });
}
