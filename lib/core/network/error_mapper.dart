import 'package:dio/dio.dart';
import 'package:ligo_app/core/network/app_exception.dart';

/// Mapper encargado de convertir errores de Dio en [AppException].
class DioExceptionMapper {
  /// Convierte una [DioException] en [AppException].
  static AppException map(DioException e) {
    final status = e.response?.statusCode;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException(type: AppErrorType.timeout);

      case DioExceptionType.cancel:
        return const AppException(type: AppErrorType.cancelled);

      case DioExceptionType.connectionError:
        return const AppException(type: AppErrorType.network);

      case DioExceptionType.badResponse:
        return _fromStatusCode(status, e);

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return AppException(
          type: AppErrorType.unknown,
          message: e.message,
          statusCode: status,
          original: e,
        );
    }
  }

  /// Mapea códigos HTTP a errores de dominio.
  static AppException _fromStatusCode(int? status, DioException e) {
    final message = _extractMessage(e);

    switch (status) {
      case 400:
        return AppException(
          type: AppErrorType.badRequest,
          statusCode: status,
          message: message,
          original: e,
        );
      case 401:
        return AppException(
          type: AppErrorType.unauthorized,
          statusCode: status,
          message: message,
          original: e,
        );
      case 404:
        return AppException(
          type: AppErrorType.notFound,
          statusCode: status,
          message: message,
          original: e,
        );
      case 500:
      default:
        return AppException(
          type: AppErrorType.server,
          statusCode: status,
          message: message,
          original: e,
        );
    }
  }

  /// Extrae mensaje de error desde la respuesta del backend si existe.
  static String? _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final msg = data['message'];
      if (msg is String) return msg;
    }
    return null;
  }
}
