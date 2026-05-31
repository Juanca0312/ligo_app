import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/network/http_response.dart';
import 'package:ligo_app/features/auth/data/auth_endpoints.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource_impl.dart';
import 'package:ligo_app/features/auth/data/models/session_model.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements IHttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late AuthDatasourceImpl authDatasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    authDatasource = AuthDatasourceImpl(httpClient: mockHttpClient);
  });

  group('login', () {
    const tEmail = 'test_user@example.com';
    const tPassword = '123456';

    final tResponse = {
      'token': 'token_123',
      'user': {
        'id': '1',
        'name': 'Juan Hernandez',
      },
    };

    final tSession = SessionModel.fromJson(tResponse);

    test('should return SessionModel when login is successful', () async {
      // arrange
      when(
        () => mockHttpClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => HttpResponse<Map<String, dynamic>>(
          data: tResponse,
          statusCode: 200,
        ),
      );

      // act
      final result = await authDatasource.login(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(result.user.id, equals(tSession.user.id));
      expect(result.user.name, equals(tSession.user.name));
      expect(result.token, equals(tSession.token));

      verify(
        () => mockHttpClient.post<Map<String, dynamic>>(
          AuthEndpoints.login,
          data: {
            'email': tEmail,
            'password': tPassword,
          },
        ),
      ).called(1);
    });

    test('should throw AppException when response data is null', () async {
      when(
        () => mockHttpClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => HttpResponse<Map<String, dynamic>>(
          data: {},
          statusCode: 200,
        ),
      );

      expect(
        () => authDatasource.login(
          email: tEmail,
          password: tPassword,
        ),
        throwsA(isA<AppException>()),
      );
    });

    test('should propagate AppException from HttpClient', () async {
      when(
        () => mockHttpClient.post<Map<String, dynamic>>(
          any(),
          data: any(named: 'data'),
        ),
      ).thenThrow(
        const AppException(
          type: AppErrorType.server,
          message: 'Server error',
        ),
      );

      expect(
        () => authDatasource.login(
          email: tEmail,
          password: tPassword,
        ),
        throwsA(
          predicate((e) => e is AppException && e.type == AppErrorType.server),
        ),
      );
    });
  });
}
