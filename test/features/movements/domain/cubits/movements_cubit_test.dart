import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/movements/domain/cubits/movements/movements_cubit.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/repositories/movement_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMovementsRepository extends Mock implements MovementsRepository {}

void main() {
  late MockMovementsRepository repository;
  late MovementsCubit cubit;

  setUp(() {
    repository = MockMovementsRepository();

    cubit = MovementsCubit(
      movementsRepository: repository,
    );
  });

  group(
    'MovementsCubit - loadMovements',
    () {
      blocTest<MovementsCubit, MovementsState>(
        'should emit loading then success when loadMovements succeeds',
        build: () {
          when(
            () => repository.getMovements(),
          ).thenAnswer((_) async => const Success(<Movement>[]));

          return cubit;
        },
        act: (cubit) => cubit.loadMovements(),
        expect: () => [
          predicate<MovementsState>(
            (s) => s.requestStatus == RequestStatus.loading,
          ),
          predicate<MovementsState>(
            (s) =>
                s.requestStatus == RequestStatus.success && s.movements.isEmpty,
          ),
        ],
      );

      blocTest<MovementsCubit, MovementsState>(
        'should emit loading then failure when repository fails',
        build: () {
          when(
            () => repository.getMovements(),
          ).thenAnswer((_) async => Error(UnknownFailure()));

          return cubit;
        },
        act: (cubit) => cubit.loadMovements(),
        expect: () => [
          predicate<MovementsState>(
            (s) => s.requestStatus == RequestStatus.loading,
          ),
          predicate<MovementsState>(
            (s) =>
                s.requestStatus == RequestStatus.failure &&
                s.failure is UnknownFailure,
          ),
        ],
      );

      blocTest<MovementsCubit, MovementsState>(
        'should not emit states when already loading',
        build: () {
          when(() => repository.getMovements()).thenAnswer((_) async {
            await Future<void>.delayed(const Duration(milliseconds: 50));
            return const Success(<Movement>[]);
          });

          return cubit;
        },
        act: (cubit) async {
          unawaited(cubit.loadMovements());
          unawaited(
            cubit.loadMovements(),
          ); // second call should be ignored
        },
        expect: () => [
          predicate<MovementsState>(
            (s) => s.requestStatus == RequestStatus.loading,
          ),
        ],
      );
    },
  );
}
