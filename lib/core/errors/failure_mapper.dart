import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/network/app_exception.dart';

/// Utility class for mapping [AppException]s to [Failure]s.
class FailureMapper {
  /// Maps an [AppException] to a corresponding [Failure].
  static Failure from(AppException e) {
    switch (e.type) {
      case AppErrorType.unauthorized:
        return UnauthorizedFailure();
      case AppErrorType.network:
      case AppErrorType.timeout:
      case AppErrorType.server:
      case AppErrorType.badRequest:
      case AppErrorType.notFound:
      case AppErrorType.cancelled:
      case AppErrorType.unknown:
        return UnknownFailure();
    }
  }
}
