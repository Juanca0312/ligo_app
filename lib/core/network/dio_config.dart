import 'package:dio/dio.dart';
import 'package:ligo_app/core/environment/environment.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Factory class for creating and configuring Dio instance used in the app.
class DioConfig {
  /// Creates and configures a Dio instance with settings and interceptors.
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );

    return dio;
  }
}
