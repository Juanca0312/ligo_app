import 'package:dio/dio.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';

/// Interceptor to add the Authorization header with the token
/// from the session manager.
final class AuthInterceptor extends Interceptor {
  /// Creates a new instance of [AuthInterceptor]
  AuthInterceptor(this._sessionManager);

  final SessionManager _sessionManager;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _sessionManager.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
