import 'package:ligo_app/core/helpers/safe_parser_helper.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/features/auth/data/auth_endpoints.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:ligo_app/features/auth/data/models/session_model.dart';

/// Implementation of  [IAuthRemoteDataSource] for authentication operations.
final class AuthDatasourceImpl implements IAuthRemoteDataSource {
  /// Constructs an [AuthDatasourceImpl] with the required [IHttpClient].
  AuthDatasourceImpl({required IHttpClient httpClient})
    : _httpClient = httpClient;

  final IHttpClient _httpClient;

  @override
  Future<SessionModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _httpClient.post<Map<String, dynamic>>(
      AuthEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    return SafeParser.fromJson(response.data, SessionModel.fromJson);
  }
}
