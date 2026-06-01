import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/core/network/http_response.dart';
import 'package:ligo_app/features/movements/data/datasources/movements_datasource_impl.dart';
import 'package:ligo_app/features/movements/data/movements_endpoints.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements LigoHttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late MovementDatasourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = MovementDatasourceImpl(
      httpClient: mockHttpClient,
    );
  });

  group('getMovements', () {
    final tResponse = [
      {
        'id': 'mov_001',
        'description': 'Pago QR',
        'amount': 25.50,
        'type': 'out',
        'status': 'completed',
      },
      {
        'id': 'mov_002',
        'description': 'Transferencia',
        'amount': 100.00,
        'type': 'in',
        'status': 'completed',
      },
    ];

    test(
      'should return list of MovementModel when request succeeds',
      () async {
        // arrange
        when(
          () => mockHttpClient.get<List<dynamic>>(any()),
        ).thenAnswer(
          (_) async => HttpResponse<List<dynamic>>(
            data: tResponse,
            statusCode: 200,
          ),
        );

        // act
        final result = await datasource.getMovements();

        // assert
        expect(result, hasLength(2));
        expect(result.first.id, 'mov_001');

        verify(
          () => mockHttpClient.get<List<dynamic>>(
            MovementsEndpoints.getMovements,
          ),
        ).called(1);
      },
    );

    test(
      'should propagate AppException from HttpClient',
      () async {
        // arrange
        when(
          () => mockHttpClient.get<List<dynamic>>(any()),
        ).thenThrow(
          const AppException(
            type: AppErrorType.server,
            message: 'Server error',
          ),
        );

        // assert
        expect(
          datasource.getMovements,
          throwsA(
            predicate(
              (e) => e is AppException && e.type == AppErrorType.server,
            ),
          ),
        );
      },
    );
  });
}
