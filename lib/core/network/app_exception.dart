/// Excepción base de la aplicación para representar errores controlados.
class AppException implements Exception {
  /// Constructs an [AppException] with the specified type and optional details.
  const AppException({
    required this.type,
    this.message,
    this.statusCode,
    this.original,
  });

  /// Tipo de error que categoriza la excepción.
  final AppErrorType type;

  /// Mensaje opcional descriptivo del error.
  final String? message;

  /// Código de estado HTTP asociado, si aplica.
  final int? statusCode;

  /// Error original capturado
  final Object? original;
}

/// Tipos de errores manejados por la aplicación.
enum AppErrorType {
  /// Problemas de conectividad.
  network,

  /// Tiempo de espera agotado.
  timeout,

  /// Error del servidor (5xx).
  server,

  /// Usuario no autorizado o token inválido.
  unauthorized,

  /// Petición inválida (400).
  badRequest,

  /// Recurso no encontrado (404).
  notFound,

  /// Petición cancelada.
  cancelled,

  /// Error no clasificado.
  unknown,
}
