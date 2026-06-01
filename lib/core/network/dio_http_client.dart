import 'package:dio/dio.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/network/error_mapper.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/network/http_response.dart';

/// Implementation of [LigoHttpClient] using the Dio package.
class DioHttpClient implements LigoHttpClient {
  /// Creates a new instance of [DioHttpClient] with the provided Dio instance.
  DioHttpClient(this.dio);

  /// The Dio instance used for making HTTP requests.
  final Dio dio;

  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _request<T>(
      () => dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            ...dio.options.headers,
            ...?headers,
          },
        ),
      ),
    );
  }

  @override
  Future<HttpResponse<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
  }) {
    return _request<T>(
      () => dio.post<dynamic>(
        path,
        data: data,
        options: Options(
          headers: {
            ...dio.options.headers,
            ...?headers,
          },
        ),
      ),
    );
  }

  /// Centralized request handler to avoid duplication.
  Future<HttpResponse<T>> _request<T>(
    Future<Response<dynamic>> Function() call,
  ) async {
    try {
      final response = await call();

      return HttpResponse<T>(
        data: response.data as T,
        statusCode: response.statusCode ?? 200,
      );
    } on DioException catch (e) {
      throw DioExceptionMapper.map(e);
    } catch (e) {
      throw AppException(
        type: AppErrorType.unknown,
        message: e.toString(),
        original: e,
      );
    }
  }
}
