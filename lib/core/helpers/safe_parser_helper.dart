import 'package:ligo_app/core/network/app_exception.dart';

/// Helper class for safely parsing JSON responses.
class SafeParser {
  /// Safely parses a JSON map into a Dart object
  /// using the provided builder function.
  static T fromJson<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) builder,
  ) {
    try {
      return builder(json);
    } catch (e) {
      throw AppException(
        type: AppErrorType.server,
        message: 'Error parsing JSON response: $e',
        original: e,
      );
    }
  }
}
