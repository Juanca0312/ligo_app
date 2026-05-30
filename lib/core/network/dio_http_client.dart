import 'package:dio/dio.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/network/http_response.dart';

/// Implementation of [IHttpClient] using the Dio package.
class DioHttpClient implements IHttpClient {
  /// Creates a new instance of [DioHttpClient] with the provided Dio instance.
  DioHttpClient(this.dio);

  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw ApiException(
        message: _message(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<HttpResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post<dynamic>(
        path,
        data: data,
        options: Options(headers: headers),
      );

      return HttpResponse(
        data: response.data,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw ApiException(
        message: _message(e),
        statusCode: e.response?.statusCode,
      );
    }
  }

  String _message(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return e.message ?? 'Unexpected error';
  }
}
