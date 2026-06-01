import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/features/movements/data/datasources/movements_datasouce.dart';
import 'package:ligo_app/features/movements/data/models/movement_model.dart';
import 'package:ligo_app/features/movements/data/repositories/movements_repository_impl.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:mocktail/mocktail.dart';

class MockMovementsDataSource extends Mock implements MovementsDataSource {}

void main() {
  late MockMovementsDataSource dataSource;
  late MovementsRepositoryImpl repository;

  setUp(() {
    dataSource = MockMovementsDataSource();

    repository = MovementsRepositoryImpl(
      remoteDataSource: dataSource,
    );
  });

  group('getMovements', () {
    const tModels = [
      MovementModel(
        id: 'mov_001',
        description: 'Pago QR',
        amount: 25.5,
        type: 'out',
        status: 'completed',
      ),
    ];

    test('should return Success when data source returns data', () async {
      // arrange
      when(() => dataSource.getMovements()).thenAnswer((_) async => tModels);

      // act
      final result = await repository.getMovements();

      // assert
      expect(result, isA<Success<List<Movement>>>());

      final success = result as Success<List<Movement>>;
      expect(success.value.length, 1);
      expect(success.value.first.id, 'mov_001');

      verify(() => dataSource.getMovements()).called(1);
    });

    test('should return mapped failure when AppException is thrown', () async {
      // arrange
      when(() => dataSource.getMovements()).thenThrow(
        const AppException(type: AppErrorType.unauthorized),
      );

      // act
      final result = await repository.getMovements();

      // assert
      expect(result, isA<Error<List<Movement>>>());

      final failure = (result as Error<List<Movement>>).failure;
      expect(failure, isA<UnauthorizedFailure>());

      verify(() => dataSource.getMovements()).called(1);
    });

    test('should return UnknownFailure when unexpected error occurs', () async {
      // arrange
      when(() => dataSource.getMovements()).thenThrow(Exception('boom'));

      // act
      final result = await repository.getMovements();

      // assert
      expect(result, isA<Error<List<Movement>>>());

      final failure = (result as Error<List<Movement>>).failure;
      expect(failure, isA<UnknownFailure>());

      verify(() => dataSource.getMovements()).called(1);
    });
  });
}
